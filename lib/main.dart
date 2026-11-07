import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:pizza_sofian_market/core/utils/app_imports.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initAppModule();
  Bloc.observer = BlocObserverReader();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: 'https://oibjkvqmjskoxwnibcqn.supabase.co',
    anonKey: 'sb_publishable_HC_WTlQooAt4rmPpeYZCXQ_wRQajfhP',
  );
  await CacheHelper.init();
  Constants.onBoarding = await CacheHelper.getData(key: 'onBoarding') ?? false;
  Constants.uId = await CacheHelper.getData(key: 'uId') ?? '';
  runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const MyApp(),
      ),
    );
}
