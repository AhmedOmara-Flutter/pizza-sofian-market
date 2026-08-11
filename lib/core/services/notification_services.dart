import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin _local =
  FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel =
  AndroidNotificationChannel(
    'pizza_sofian_channel',
    'Pizza Sofian Notifications',
    description: 'Notifications for Pizza Sofian',
    importance: Importance.max,
    playSound: true,
  );

  static Future<void> initLocal() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _local.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        print('🔔 Notification clicked');
        print('Payload: ${response.payload}');
      },
    );

    final AndroidFlutterLocalNotificationsPlugin? android =
    _local.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await android?.createNotificationChannel(_channel);

    await android?.requestNotificationsPermission();
  }

  static Future<void> showNotification(RemoteMessage message) async {
    final RemoteNotification? notification = message.notification;

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
      notification?.title ?? 'Pizza Sofian',
      notification?.body ?? '',
      details,
      payload: message.data.toString(),
    );
  }
  static Future<void> initFirebase() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    await _firebaseMessaging.subscribeToTopic('all_users');

    final String? token = await _firebaseMessaging.getToken();

    print('======================================');
    print('FCM TOKEN:');
    print(token);
    print('======================================');

    FirebaseMessaging.onMessage.listen(
          (RemoteMessage message) async {
        print('📩 FOREGROUND MESSAGE');
        print('Title: ${message.notification?.title}');
        print('Body: ${message.notification?.body}');
        print('Data: ${message.data}');

        if (message.notification != null) {
          await showNotification(message);
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
          (RemoteMessage message) {
        print('🔔 Notification opened from background');
        print('Data: ${message.data}');
      },
    );

    final RemoteMessage? initialMessage =
    await _firebaseMessaging.getInitialMessage();

    if (initialMessage != null) {
      print('🔔 App opened from terminated state');
      print('Data: ${initialMessage.data}');
    }
  }
}