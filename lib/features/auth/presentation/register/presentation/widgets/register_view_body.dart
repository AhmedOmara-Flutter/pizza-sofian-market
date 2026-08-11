import 'package:pizza_sofian_market/core/utils/app_imports.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _headerAnim;
  late Animation<double> _formAnim;
  late Animation<double> _footerAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _headerAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    );

    _formAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
    );

    _footerAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimated({
    required Animation<double> animation,
    required Widget child,
    double offset = 20,
  }) {
    return FadeTransition(
      opacity: animation,
      child: AnimatedBuilder(
        animation: animation,
        child: child,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, offset.h * (1 - animation.value)),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              const InfoActionRow(text: '', showBack: true, bottomPadding: 0),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildAnimated(
                      animation: _headerAnim,
                      child: Column(
                        children: [
                          Hero(
                            tag: 'appLogo',
                            child: SizedBox(
                              height: 280.h,
                              width: double.infinity,
                              child: Image.asset(
                                Assets.images.arLogo.path,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Text('إنشاء حساب', style: StyleManager.font19Weight700),
                          SizedBox(height: 8.h),
                          Text(
                            'أنشئ حسابك وابدأ رحلتك مع بيتزا سفيان',
                            textAlign: TextAlign.center,
                            style: StyleManager.font13Weight600,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 32.h),

                    _buildAnimated(
                      animation: _formAnim,
                      child: const RegisterForm(),
                    ),

                    SizedBox(height: 32.h),

                    _buildAnimated(
                      animation: _footerAnim,
                      child: const CustomAuthFooter(),
                    ),

                    SizedBox(height: 45.h),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
