import 'package:pizza_sofian_market/core/utils/app_imports.dart';

import '../widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key,});

  @override
  Widget build(BuildContext context) {
    return const HomeViewBody();
    // return Stack(
    //   children: [
    //     const HomeViewBody(),
    //
    //     const Positioned.fill(
    //       child: MawlidCelebrationOverlay(),
    //     ),
    //   ],
    // );
  }
}


//  @override
//   void initState() {
//     super.initState();
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       showMawlidCelebrationPopup(context);
//     });
//   }