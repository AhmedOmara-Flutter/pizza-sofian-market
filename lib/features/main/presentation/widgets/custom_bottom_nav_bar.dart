import '../../../../core/utils/app_imports.dart';
import '../../../cart/presentation/view_model/cart_cubit.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        final cubit = context.read<MainCubit>();

        return Container(
          decoration: BoxDecoration(
            color: AppColor.card,
            border: Border(
              top: BorderSide(
                color: AppColor.border,
                width: 1,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColor.black.withOpacity(.18),
                blurRadius: 12.r,
                offset: Offset(0, -3.h),
              ),
            ],
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashFactory: NoSplash.splashFactory,
              splashColor: AppColor.transparent,
              highlightColor: AppColor.transparent,
              hoverColor: AppColor.transparent,
            ),
            child: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: cubit.changeBottomNav,
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColor.card,
              elevation: 0,
              selectedItemColor: AppColor.accentColor,
              unselectedItemColor:
              AppColor.textSecondary.withOpacity(.65),
              selectedFontSize: 12.sp,
              unselectedFontSize: 12.sp,
              selectedLabelStyle:
              StyleManager.font13Weight400.copyWith(
                color: AppColor.accentColor,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle:
              StyleManager.font13Weight400.copyWith(
                color: AppColor.textSecondary.withOpacity(.65),
                fontWeight: FontWeight.w500,
              ),
              items: [
                _buildItem(
                  icon: Icons.home_rounded,
                  activeIcon: Icons.home_rounded,
                  label: 'الرئيسية',
                ),
                _buildItem(
                  icon: Icons.restaurant_menu_rounded,
                  activeIcon: Icons.restaurant_menu_rounded,
                  label: 'القائمة',
                ),
                _buildCartItem(
                  isActive: cubit.currentIndex == 2,
                ),
                _buildItem(
                  icon: Icons.person_rounded,
                  activeIcon: Icons.person_rounded,
                  label: 'حسابي',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  BottomNavigationBarItem _buildItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        size: 25.sp,
        color: AppColor.textSecondary.withOpacity(.65),
      ),
      activeIcon: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 5.h,
        ),
        decoration: BoxDecoration(
          color: AppColor.accentColor.withOpacity(.12),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Icon(
          activeIcon,
          size: 25.sp,
          color: AppColor.accentColor,
        ),
      ),
      label: label,
    );
  }

  BottomNavigationBarItem _buildCartItem({
    required bool isActive,
  }) {
    return BottomNavigationBarItem(
      icon: _buildCartIcon(isActive: false),
      activeIcon: _buildCartIcon(isActive: true),
      label: 'السلة',
    );
  }

  Widget _buildCartIcon({
    required bool isActive,
  }) {
    return Builder(
      builder: (context) {
        final cartCubit = context.watch<CartCubit>();
        final cartCount = cartCubit.cart.cartItems.length;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            if (isActive)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 5.h,
                ),
                decoration: BoxDecoration(
                  color: AppColor.accentColor.withOpacity(.12),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(
                  Icons.shopping_cart_rounded,
                  size: 25.sp,
                  color: AppColor.accentColor,
                ),
              )
            else
              Icon(
                Icons.shopping_cart_rounded,
                size: 25.sp,
                color: AppColor.textSecondary.withOpacity(.65),
              ),
            if (cartCount > 0)
              Positioned(
                top: -7.h,
                right: -8.w,
                child: TweenAnimationBuilder<double>(
                  key: ValueKey(cartCount),
                  tween: Tween(
                    begin: 0.0,
                    end: 1.0,
                  ),
                  duration: const Duration(
                    milliseconds: 450,
                  ),
                  curve: Curves.elasticOut,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: child,
                    );
                  },
                  child: Container(
                    constraints: BoxConstraints(
                      minWidth: 18.w,
                      minHeight: 18.w,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.accentColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColor.card,
                        width: 2,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$cartCount',
                      style: TextStyle(
                        color: AppColor.textPrimary,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
