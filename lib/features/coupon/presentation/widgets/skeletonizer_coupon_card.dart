import 'package:pizza_sofian_market/core/utils/app_imports.dart';

class SkeletonizerCouponCard extends StatelessWidget {
  const SkeletonizerCouponCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: AppColor.background,
        highlightColor: AppColor.card,
        duration: const Duration(milliseconds: 1200),
      ),
      enabled: true,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColor.card,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: AppColor.border.withValues(alpha: 0.22),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColor.mainColor.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColor.border.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  alignment: Alignment.center,
                  child: const Text('🎟️', style: TextStyle(fontSize: 23)),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'SUMMER20',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 52,
                            height: 24,
                            decoration: BoxDecoration(
                              color: AppColor.border.withValues(alpha: 0.35),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'خصم 20٪ على طلبك',
                        style: StyleManager.font12Weight500.copyWith(
                          color: AppColor.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              height: 42,
              decoration: BoxDecoration(
                color: AppColor.border.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('🛍️', style: TextStyle(fontSize: 18)),
                          const SizedBox(width: 6),
                          Text(
                            'الحد الأدنى',
                            style: StyleManager.font12Weight500.copyWith(
                              color: AppColor.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '100 جنيه',
                        style: StyleManager.font12Weight500.copyWith(
                          color: AppColor.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 38,
                  color: AppColor.accentColor.withValues(alpha: 0.15),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('💰', style: TextStyle(fontSize: 18)),
                          const SizedBox(width: 6),
                          Text(
                            'قيمة الخصم',
                            style: StyleManager.font11Weight400.copyWith(
                              color: AppColor.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '20%',
                        style: StyleManager.font12Weight500.copyWith(
                          color: AppColor.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 42,
              child: CustomButton(
                onPressed: null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('🎟️', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 7),
                    Text(
                      'استخدم الكوبون',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColor.card,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
