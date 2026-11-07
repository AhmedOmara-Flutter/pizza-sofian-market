import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pizza_sofian_market/core/services/database_services.dart';
import 'package:pizza_sofian_market/core/services/service_locator.dart';
import 'package:pizza_sofian_market/core/utils/navigation_key.dart';
import 'package:pizza_sofian_market/core/utils/route_manager.dart';

class NotificationServices {
  // TODO: حط مفتاح VAPID هنا
  // Firebase Console > Project settings > Cloud Messaging > Web configuration > Generate key pair
  static const String _vapidKey = 'PUT_YOUR_VAPID_KEY_HERE';

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin _local =
  FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'pizza_sofian_channel',
    'Pizza Sofian Notifications',
    description: 'Notifications for Pizza Sofian',
    importance: Importance.max,
    playSound: true,
  );

  static bool _listenersStarted = false;

  // =========================================================
  // Local Notification (موبايل فقط)
  // =========================================================

  static Future<void> initLocal() async {
    if (kIsWeb) return; // flutter_local_notifications مش بتدعم الويب

    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _local.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        if (response.payload == null || response.payload!.isEmpty) return;
        try {
          final Map<String, dynamic> data = jsonDecode(response.payload!);
          _handleNotificationNavigation(data);
        } catch (e) {
          debugPrint('❌ Notification payload error: $e');
        }
      },
    );

    final AndroidFlutterLocalNotificationsPlugin? android =
    _local.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await android?.createNotificationChannel(_channel);
    await android?.requestNotificationsPermission();
  }

  // =========================================================
  // Show Notification - Foreground
  // =========================================================

  static Future<void> showNotification(RemoteMessage message) async {
    final RemoteNotification? notification = message.notification;

    // على الويب: نعرض شريط تنبيه جوه التطبيق
    if (kIsWeb) {
      _showInAppBanner(
        notification?.title ?? 'إشعار جديد',
        notification?.body ?? '',
        message.data,
      );
      return;
    }

    final AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      _channel.id,
      _channel.name,
      channelDescription: _channel.description,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      icon: '@mipmap/ic_launcher',
    );

    final NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    await _local.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      notification?.title ?? 'إشعار جديد',
      notification?.body ?? '',
      details,
      payload: jsonEncode(message.data),
    );
  }

  static void _showInAppBanner(
      String title,
      String body,
      Map<String, dynamic> data,
      ) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 6),
        behavior: SnackBarBehavior.floating,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            if (body.isNotEmpty) Text(body),
          ],
        ),
        action: SnackBarAction(
          label: 'عرض',
          onPressed: () => _handleNotificationNavigation(data),
        ),
      ),
    );
  }

  // =========================================================
  // Notification Navigation
  // =========================================================

  static void _handleNotificationNavigation(Map<String, dynamic> data) {
    final String? screen = data['screen']?.toString();

    if (screen == null || screen.isEmpty) return;

    switch (screen) {
      case 'product':
        final String? productId = data['productId']?.toString();
        if (productId == null || productId.isEmpty) return;
        navigatorKey.currentState?.pushNamed(
          RouteManager.productDetails,
          arguments: productId,
        );
        break;

      case 'orders':
        navigatorKey.currentState?.pushNamed(RouteManager.orders);
        break;

      case 'coupon':
        navigatorKey.currentState?.pushNamed(RouteManager.coupon);
        break;

      case 'home':
        navigatorKey.currentState?.pushNamed(RouteManager.home);
        break;

      default:
        debugPrint('⚠️ Unknown notification screen: $screen');
    }
  }

  // =========================================================
  // Save FCM Token
  // =========================================================

  static Future<void> _saveToken(String token) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      debugPrint('⚠️ No logged in user');
      return;
    }
    await instance<DatabaseServices>().updateData(
      path: 'users',
      docId: user.uid,
      data: {'fcmToken': token},
    );
  }

  static Future<void> saveFcmToken() async {
    try {
      final String? token = await _firebaseMessaging.getToken(
        vapidKey: kIsWeb ? _vapidKey : null,
      );

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ FCM Token is null');
        return;
      }

      await _saveToken(token);
      debugPrint('✅ FCM TOKEN SAVED');
    } catch (e) {
      debugPrint('❌ Error saving FCM Token: $e');
    }
  }

  // =========================================================
  // زرار "فعّل الإشعارات" (مهم للويب وللـ iPhone)
  // لازم يتنده من ضغطة زرار
  // =========================================================

  static Future<bool> enableFromButton() async {
    try {
      final NotificationSettings s = await _firebaseMessaging
          .requestPermission(alert: true, badge: true, sound: true);

      if (s.authorizationStatus != AuthorizationStatus.authorized &&
          s.authorizationStatus != AuthorizationStatus.provisional) {
        return false;
      }

      await saveFcmToken();
      return true;
    } catch (e) {
      debugPrint('❌ enableFromButton error: $e');
      return false;
    }
  }

  // =========================================================
  // Firebase
  // =========================================================

  static Future<void> initFirebase() async {
    if (kIsWeb) {
      // على الويب: متطلبش الإذن هنا (المتصفح بيرفض من غير ضغطة)
      // لو العميل سمح قبل كده، نحدّث التوكن
      final NotificationSettings s =
      await _firebaseMessaging.getNotificationSettings();
      if (s.authorizationStatus == AuthorizationStatus.authorized) {
        await saveFcmToken();
      }
    } else {
      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      // subscribeToTopic مش مدعومة على الويب
      await _firebaseMessaging.subscribeToTopic('all_users');
      await saveFcmToken();
    }

    if (_listenersStarted) return;
    _listenersStarted = true;

    // Token Refresh
    _firebaseMessaging.onTokenRefresh.listen((String token) async {
      try {
        await _saveToken(token);
      } catch (e) {
        debugPrint('❌ Error updating FCM Token: $e');
      }
    });

    // Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        await showNotification(message);
      }
    });

    // Background -> opened
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationNavigation(message.data);
    });

    // Terminated -> opened
    final RemoteMessage? initialMessage =
    await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationNavigation(initialMessage.data);
    }
  }
}