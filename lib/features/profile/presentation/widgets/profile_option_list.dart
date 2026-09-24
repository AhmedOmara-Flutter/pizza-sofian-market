import 'package:pizza_sofian_market/features/profile/presentation/widgets/toggle_button.dart';

import '../../../../core/utils/app_imports.dart';

class ProfileOptionsList extends StatelessWidget {
  final bool isButton;
  final String text;
  final String emoji;
  final VoidCallback? onTap;

  const ProfileOptionsList({
    super.key,
    this.isButton = false,
    required this.text,
    required this.emoji,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.transparent,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColor.border.withOpacity(.6),
                width: 1.w,
              ),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  color: AppColor.mainColor.withOpacity(.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  emoji,
                  style: TextStyle(
                    fontSize: 17.sp,
                  ),
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Text(
                  text,
                  style: StyleManager.font13Weight600.copyWith(
                    color: AppColor.textPrimary,
                  ),
                ),
              ),
              if (isButton)
                const ToggleButton()
              else
                Text(
                  '›',
                  style: TextStyle(
                    fontSize: 25.sp,
                    color: AppColor.textSecondary,
                    height: 1,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
