import 'package:pizza_sofian_market/core/utils/app_imports.dart';

bool isLoggedIn() {
  return FirebaseAuth.instance.currentUser != null;
}
