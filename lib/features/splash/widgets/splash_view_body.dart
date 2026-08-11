import 'package:flutter/services.dart';
import 'package:pizza_sofian_market/core/utils/app_imports.dart';

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
    goToHome();
  }

  Future<void> goToHome() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    if (!Constants.onBoarding) {
      Navigator.pushReplacementNamed(context, RouteManager.onBoarding);
    } else {
      final isLogged = isLoggedIn();

      Navigator.pushReplacementNamed(
        context,
        isLogged ? RouteManager.home : RouteManager.login,
      );
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
          color: AppColor.black,
          image: DecorationImage(
            image: AssetImage(Assets.images.bg2.path),
            fit: BoxFit.contain,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 100.h, width: double.infinity),
            SafeArea(
              child: Padding(
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
              ),
            ),
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
