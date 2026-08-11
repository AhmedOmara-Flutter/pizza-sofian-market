import 'package:pizza_sofian_market/core/utils/app_imports.dart';

void onBoardingViewed() async {
  await CacheHelper.saveData(key: 'onBoarding', value: true);
}
