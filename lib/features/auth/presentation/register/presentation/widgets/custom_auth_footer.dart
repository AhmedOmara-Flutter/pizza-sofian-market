import 'package:pizza_sofian_market/core/utils/app_imports.dart';
class CustomAuthFooter extends StatelessWidget {
  const CustomAuthFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "تمتلك حساب بالفعل؟ ",
          style: Theme
              .of(
            context,
          )
              .textTheme
              .labelMedium!
              .copyWith(color: Color(0xff949D9E)),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RouteManager.login);
          },
          child: Text(
            'تسجيل دخول',
            style: Theme
                .of(
              context,
            )
                .textTheme
                .labelMedium!
                .copyWith(color: AppColor.mainColor),
          ),
        ),
      ],
    );
  }
}
