import 'package:pizza_sofian_market/core/utils/app_imports.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? color;
  final Color borderColor;

  const CustomButton({
    super.key,
    required this.child,
    this.onPressed,
    this.color,
    this.borderColor=AppColor.mainColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.w),
      child: ElevatedButton(

        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          disabledBackgroundColor:AppColor.card ,
          side: BorderSide(
            color: borderColor,
          ),
        ),
        child: child,
      ),
    );
  }
}