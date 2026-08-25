// import 'dart:math' as math;
// import 'package:flutter/material.dart';
//
// class MawlidCelebrationOverlay extends StatefulWidget {
//   const MawlidCelebrationOverlay({
//     super.key,
//     this.enabled = true,
//   });
//
//   final bool enabled;
//
//   @override
//   State<MawlidCelebrationOverlay> createState() =>
//       _MawlidCelebrationOverlayState();
// }
//
// class _MawlidCelebrationOverlayState
//     extends State<MawlidCelebrationOverlay>
//     with TickerProviderStateMixin {
//   late final AnimationController _lanternController;
//   late final AnimationController _petalController;
//   late final AnimationController _glowController;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _lanternController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 5),
//     )..repeat(reverse: true);
//
//     _petalController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 8),
//     )..repeat();
//
//     _glowController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1800),
//     )..repeat(reverse: true);
//   }
//
//   @override
//   void dispose() {
//     _lanternController.dispose();
//     _petalController.dispose();
//     _glowController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (!widget.enabled) {
//       return const SizedBox.shrink();
//     }
//
//     return Positioned.fill(
//       child: IgnorePointer(
//         child: Stack(
//           children: [
//             // ==========================================
//             // ✨ Stars
//             // ==========================================
//             const _MawlidStars(),
//
//             // ==========================================
//             // 🏮 Lanterns
//             // ==========================================
//             AnimatedBuilder(
//               animation: _lanternController,
//               builder: (_, __) {
//                 return Stack(
//                   children: [
//                     _Lantern(
//                       left: 18,
//                       top: -5,
//                       size: 52,
//                       animation:
//                       _lanternController.value,
//                     ),
//                     _Lantern(
//                       right: 20,
//                       top: 8,
//                       size: 45,
//                       animation:
//                       1 - _lanternController.value,
//                     ),
//                     _Lantern(
//                       left: 95,
//                       top: -18,
//                       size: 32,
//                       animation:
//                       1 - _lanternController.value,
//                     ),
//                     _Lantern(
//                       right: 100,
//                       top: -14,
//                       size: 34,
//                       animation:
//                       _lanternController.value,
//                     ),
//                   ],
//                 );
//               },
//             ),
//
//             // ==========================================
//             // 🌙 Crescent
//             // ==========================================
//             Positioned(
//               top: 65,
//               right: 22,
//               child: AnimatedBuilder(
//                 animation: _glowController,
//                 builder: (_, __) {
//                   final glow =
//                       4 + (_glowController.value * 8);
//
//                   return CustomPaint(
//                     size: const Size(55, 55),
//                     painter: _CrescentPainter(
//                       glow: glow,
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//             // ==========================================
//             // 🌸 Falling petals
//             // ==========================================
//             AnimatedBuilder(
//               animation: _petalController,
//               builder: (_, __) {
//                 return const _FallingPetals();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _Lantern extends StatelessWidget {
//   const _Lantern({
//     this.left,
//     this.right,
//     required this.top,
//     required this.size,
//     required this.animation,
//   });
//
//   final double? left;
//   final double? right;
//   final double top;
//   final double size;
//   final double animation;
//
//   @override
//   Widget build(BuildContext context) {
//     final swing =
//         math.sin(animation * math.pi * 2) * 0.06;
//
//     return Positioned(
//       left: left,
//       right: right,
//       top: top,
//       child: Transform.rotate(
//         angle: swing,
//         child: Column(
//           children: [
//             Container(
//               width: 2,
//               height: 42,
//               color: Colors.amber.withOpacity(.7),
//             ),
//
//             Container(
//               width: size * .28,
//               height: 5,
//               decoration: BoxDecoration(
//                 color: const Color(0xFFFFC107),
//                 borderRadius: BorderRadius.circular(5),
//               ),
//             ),
//
//             Container(
//               width: size * .62,
//               height: size,
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Color(0xFFFFD54F),
//                     Color(0xFFFF9800),
//                     Color(0xFFE67E22),
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(
//                   size * .18,
//                 ),
//                 border: Border.all(
//                   color: Colors.amber.shade200,
//                   width: 1.5,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.orange.withOpacity(.45),
//                     blurRadius: 15,
//                     spreadRadius: 2,
//                   ),
//                 ],
//               ),
//               child: Center(
//                 child: Icon(
//                   Icons.auto_awesome,
//                   color: Colors.white.withOpacity(.9),
//                   size: size * .3,
//                 ),
//               ),
//             ),
//
//             Container(
//               width: size * .3,
//               height: 5,
//               decoration: BoxDecoration(
//                 color: const Color(0xFFFFC107),
//                 borderRadius: BorderRadius.circular(5),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// class _CrescentPainter extends CustomPainter {
//   const _CrescentPainter({
//     required this.glow,
//   });
//
//   final double glow;
//
//   @override
//   void paint(
//       Canvas canvas,
//       Size size,
//       ) {
//     final center = Offset(
//       size.width / 2,
//       size.height / 2,
//     );
//
//     final paint = Paint()
//       ..color = const Color(0xFFFFD54F)
//       ..style = PaintingStyle.fill
//       ..maskFilter = MaskFilter.blur(
//         BlurStyle.normal,
//         glow,
//       );
//
//     canvas.drawCircle(
//       center,
//       22,
//       paint,
//     );
//
//     final cutout = Paint()
//       ..color = Colors.transparent
//       ..blendMode = BlendMode.clear;
//
//     canvas.saveLayer(
//       Offset.zero & size,
//       Paint(),
//     );
//
//     canvas.drawCircle(
//       center,
//       22,
//       paint,
//     );
//
//     canvas.drawCircle(
//       Offset(
//         center.dx + 9,
//         center.dy - 7,
//       ),
//       21,
//       cutout,
//     );
//
//     canvas.restore();
//   }
//
//   @override
//   bool shouldRepaint(
//       covariant _CrescentPainter oldDelegate,
//       ) {
//     return oldDelegate.glow != glow;
//   }
// }
// class _MawlidStars extends StatelessWidget {
//   const _MawlidStars();
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: const [
//         _Star(left: 35, top: 115, size: 5),
//         _Star(left: 75, top: 75, size: 3),
//         _Star(right: 75, top: 120, size: 4),
//         _Star(right: 35, top: 180, size: 3),
//         _Star(left: 145, top: 85, size: 3),
//         _Star(right: 145, top: 65, size: 4),
//       ],
//     );
//   }
// }
//
// class _Star extends StatelessWidget {
//   const _Star({
//     this.left,
//     this.right,
//     required this.top,
//     required this.size,
//   });
//
//   final double? left;
//   final double? right;
//   final double top;
//   final double size;
//
//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       left: left,
//       right: right,
//       top: top,
//       child: Icon(
//         Icons.star,
//         size: size,
//         color: const Color(0xFFFFD54F),
//       ),
//     );
//   }
// }
//
// class _FallingPetals extends StatefulWidget {
//   const _FallingPetals();
//
//   @override
//   State<_FallingPetals> createState() =>
//       _FallingPetalsState();
// }
//
// class _FallingPetalsState
//     extends State<_FallingPetals>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController controller;
//
//   final random = math.Random();
//
//   late final List<_PetalData> petals;
//
//   @override
//   void initState() {
//     super.initState();
//
//     petals = List.generate(
//       14,
//           (_) => _PetalData(
//         left: random.nextDouble(),
//         delay: random.nextDouble(),
//         size: 5 + random.nextDouble() * 7,
//         rotation: random.nextDouble() * math.pi,
//       ),
//     );
//
//     controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 7),
//     )..repeat();
//   }
//
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: controller,
//       builder: (_, __) {
//         return Stack(
//           children: petals.map((petal) {
//             final progress =
//                 (controller.value + petal.delay) % 1;
//
//             final screenHeight =
//                 MediaQuery.sizeOf(context).height;
//
//             final screenWidth =
//                 MediaQuery.sizeOf(context).width;
//
//             final top =
//                 -20 + (screenHeight + 40) * progress;
//
//             final horizontal =
//                 math.sin(progress * math.pi * 4) * 25;
//
//             return Positioned(
//               left:
//               petal.left * screenWidth + horizontal,
//               top: top,
//               child: Transform.rotate(
//                 angle:
//                 petal.rotation +
//                     progress * math.pi * 3,
//                 child: Container(
//                   width: petal.size,
//                   height: petal.size * .65,
//                   decoration: BoxDecoration(
//                     color: Colors.pinkAccent.withOpacity(.75),
//                     borderRadius: BorderRadius.circular(100),
//                     boxShadow: [
//                       BoxShadow(
//                         color:
//                         Colors.pinkAccent.withOpacity(.25),
//                         blurRadius: 5,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }).toList(),
//         );
//       },
//     );
//   }
// }
//
// class _PetalData {
//   const _PetalData({
//     required this.left,
//     required this.delay,
//     required this.size,
//     required this.rotation,
//   });
//
//   final double left;
//   final double delay;
//   final double size;
//   final double rotation;
// }
//
//
// void showMawlidCelebrationPopup(BuildContext context) {
//   showGeneralDialog(
//     context: context,
//     barrierDismissible: true,
//     barrierLabel: 'Mawlid Celebration',
//     barrierColor: Colors.black.withOpacity(.45),
//     transitionDuration: const Duration(milliseconds: 500),
//     pageBuilder: (_, __, ___) {
//       return const _MawlidPopup();
//     },
//     transitionBuilder: (_, animation, __, child) {
//       final curved = CurvedAnimation(
//         parent: animation,
//         curve: Curves.easeOutBack,
//       );
//
//       return FadeTransition(
//         opacity: CurvedAnimation(
//           parent: animation,
//           curve: Curves.easeOut,
//         ),
//         child: ScaleTransition(
//           scale: Tween<double>(
//             begin: .75,
//             end: 1,
//           ).animate(curved),
//           child: child,
//         ),
//       );
//     },
//   );
// }
//
// class _MawlidPopup extends StatelessWidget {
//   const _MawlidPopup();
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Material(
//         color: Colors.transparent,
//         child: Container(
//           margin: const EdgeInsets.symmetric(horizontal: 28),
//           padding: const EdgeInsets.fromLTRB(
//             20,
//             18,
//             20,
//             22,
//           ),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(28),
//             gradient: const LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Color(0xFF3A2415),
//                 Color(0xFF1F1510),
//               ],
//             ),
//             border: Border.all(
//               color: const Color(0xFFFFD54F),
//               width: 1.3,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.orange.withOpacity(.35),
//                 blurRadius: 30,
//                 spreadRadius: 4,
//               ),
//             ],
//           ),
//           child: Stack(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(
//                   top: 12,
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // 🏮 Icon
//                     Container(
//                       width: 65,
//                       height: 65,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: const Color(0xFFFF9800)
//                             .withOpacity(.15),
//                         border: Border.all(
//                           color: const Color(0xFFFFD54F)
//                               .withOpacity(.5),
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.orange
//                                 .withOpacity(.25),
//                             blurRadius: 20,
//                           ),
//                         ],
//                       ),
//                       child: const Icon(
//                         Icons.auto_awesome,
//                         color: Color(0xFFFFD54F),
//                         size: 34,
//                       ),
//                     ),
//
//                     const SizedBox(height: 18),
//
//                     const Text(
//                       'كل عام وأنتم بخير ❤️',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Color(0xFFFFD54F),
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         shadows: [
//                           Shadow(
//                             color: Colors.black54,
//                             blurRadius: 8,
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     const SizedBox(height: 8),
//
//                     const Text(
//                       'بمناسبة المولد النبوي الشريف ﷺ',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//
//                     const SizedBox(height: 10),
//
//                     Text(
//                       'صلّوا على من أضاء الدنيا بنوره ❤️',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.white.withOpacity(.75),
//                         fontSize: 13,
//                       ),
//                     ),
//
//                     const SizedBox(height: 20),
//
//                     SizedBox(
//                       width: double.infinity,
//                       height: 46,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor:
//                           const Color(0xFFE67E22),
//                           foregroundColor: Colors.white,
//                           elevation: 0,
//                           shape: RoundedRectangleBorder(
//                             borderRadius:
//                             BorderRadius.circular(15),
//                           ),
//                         ),
//                         child: const Text(
//                           'كل عام وأنتم بخير ❤️',
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               // ❌ Close button
//               Positioned(
//                 top: 0,
//                 right: 0,
//                 child: IconButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   icon: Container(
//                     padding: const EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(.08),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                       Icons.close,
//                       color: Colors.white70,
//                       size: 20,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }