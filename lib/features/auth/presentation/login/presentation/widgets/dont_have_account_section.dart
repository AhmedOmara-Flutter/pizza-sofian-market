import 'package:pizza_sofian_market/core/utils/app_imports.dart';

class DontHaveAccountSection extends StatelessWidget {
  const DontHaveAccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "لا تمتلك حساب؟ ",
          style: Theme.of(
            context,
          ).textTheme.labelMedium!.copyWith(color: Color(0xff949D9E)),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RouteManager.register);
          },
          child: Text(
            "قم بإنشاء حساب",
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.copyWith(color: AppColor.mainColor),
          ),
        ),
      ],
    );
  }
}
