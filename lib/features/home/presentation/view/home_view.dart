import 'package:pizza_sofian_market/core/utils/app_imports.dart';

import '../../../../core/widgets/falling_flowers.dart';
import '../widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key,});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const HomeViewBody(),

        const Positioned.fill(
          child: FallingFlowers(),
        ),
      ],
    );  }
}

