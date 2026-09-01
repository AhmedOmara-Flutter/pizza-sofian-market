import 'package:flutter/services.dart';
import 'package:pizza_sofian_market/core/utils/app_imports.dart';
import '../../../../core/services/app_update_service.dart';
import '../../../../core/services/notification_services.dart';
import '../../updates/presentation/view/force_update_view.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> logoSlide;
  late Animation<double> logoFade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    logoSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    logoFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();

    _startApp();
  }

  // Future<void> _startApp() async {
  //   try {
  //     await Future.wait([
  //       NotificationServices.initLocal().then((_) {
  //         return NotificationServices.initFirebase();
  //       }),
  //     ]);
  //     debugPrint('🟢 Notifications DONE');
  //   } catch (e) {
  //     debugPrint('🔴 Splash initialization error: $e');
  //   }
  //
  //   if (!mounted) return;
  //
  //   if (!Constants.onBoarding) {
  //     Navigator.pushReplacementNamed(
  //       context,
  //       RouteManager.onBoarding,
  //     );
  //   } else {
  //     final isLogged = isLoggedIn();
  //
  //     Navigator.pushReplacementNamed(
  //       context,
  //       isLogged
  //           ? RouteManager.home
  //           : RouteManager.login,
  //     );
  //   }
  // }
  Future<void> _startApp() async {
    // نبدأ تهيئة الإشعارات في الخلفية بدون انتظارها
    _initializeNotifications();

    // وقت بسيط جدًا لظهور الـ Splash والأنيميشن
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!mounted) return;

    if (!Constants.onBoarding) {
      Navigator.pushReplacementNamed(
        context,
        RouteManager.onBoarding,
      );
    } else {
      final isLogged = isLoggedIn();

      Navigator.pushReplacementNamed(
        context,
        isLogged ? RouteManager.home : RouteManager.login,
      );
    }
  }

  Future<void> _initializeNotifications() async {
    try {
      await NotificationServices.initLocal();
      await NotificationServices.initFirebase();

      debugPrint('🟢 Notifications DONE');
    } catch (e) {
      debugPrint('🔴 Notification initialization error: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        SystemNavigator.pop();
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.assets.images.splashBg.path),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 150.h,width: double.infinity,),
            FadeTransition(
              opacity: logoFade,
              child: SlideTransition(
                position: logoSlide,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Hero(
                      tag: 'appLogo',
                      child: Image.asset(
                        Assets.assets.images.appLogo2.path,
                        height: 250.h,
                        width: 280.w,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: 25.h),
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(
                              Icons.star_rounded,
                              color: AppColor.mainColor,
                              size: 16.sp,
                            ),
                          ),
                          const TextSpan(text: '  '),
                          TextSpan(
                            text: 'طعم على أصوله.. وحكاية في كل لقمة',
                            style: StyleManager.font14Weight600.copyWith(
                              color: AppColor.mainColor,
                            ),
                          ),
                          const TextSpan(text: '  '),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(
                              Icons.star_rounded,
                              color: AppColor.mainColor,
                              size: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 165.h),
            Padding(
              padding: EdgeInsets.all(20.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: AppColor.mainColor,
                    strokeWidth: 3.w,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'جاري التحميل',
                    style: StyleManager.font14Weight600.copyWith(
                      color: AppColor.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
