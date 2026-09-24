import 'package:pizza_sofian_market/features/profile/presentation/widgets/profile_option_list.dart';
import '../../../../core/utils/app_imports.dart';

class ProfileGeneralSection extends StatelessWidget {
  const ProfileGeneralSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 14.h),

          Text(
            'عام',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColor.textSecondary,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 14.h),

          ProfileOptionsList(
            text: 'الملف الشخصي',
            emoji: '👤',
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.pushNamed(context, RouteManager.editProfile);
            },
          ),

          ProfileOptionsList(
            text: 'طلباتي',
            emoji: '📦',
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.pushNamed(context, RouteManager.orders);
            },
          ),

          ProfileOptionsList(
            text: 'المفضلة',
            emoji: '❤️',
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.pushNamed(context, RouteManager.favorite);
            },
          ),

          ProfileOptionsList(
            text: 'الكوبون',
            emoji: '🏷️',
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.pushNamed(context, RouteManager.coupon);
            },
          ),
        ],
      ),
    );
  }
}