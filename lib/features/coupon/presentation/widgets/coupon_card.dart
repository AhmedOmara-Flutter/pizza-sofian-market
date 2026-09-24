import 'dart:async';

import 'package:pizza_sofian_market/core/utils/app_imports.dart';
import 'package:pizza_sofian_market/features/coupon/presentation/widgets/status_badge.dart';

import '../../../../core/cubit/selected_coupon_cubit/selected_coupon_cubit.dart';
import '../../domain/entities/coupon_entity.dart';
import 'expiry_section.dart';
import 'info_item.dart';

class CouponCard extends StatefulWidget {
  const CouponCard({
    super.key,
    required this.coupon,
  });

  final CouponEntity coupon;

  @override
  State<CouponCard> createState() => _CouponCardState();
}

class _CouponCardState extends State<CouponCard> {
  Timer? _timer;

  late DateTime _now;

  CouponEntity get coupon => widget.coupon;

  @override
  void initState() {
    super.initState();

    _now = DateTime.now();

    _timer = Timer.periodic(
      const Duration(minutes: 1),
          (_) {
        if (!mounted) return;

        setState(() {
          _now = DateTime.now();
        });
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  bool get isExpired => !_now.isBefore(coupon.expiresAt);

  bool get isUsed => coupon.used;

  bool get isAvailable => !isUsed && !isExpired;

  String get discountText {
    return coupon.discountType == 'percentage'
        ? '${coupon.discountValue.toStringAsFixed(0)}%'
        : '${coupon.discountValue.toStringAsFixed(0)} جنيه';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: AppColor.border,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withValues(alpha: 0.12),
            blurRadius: 10,
            offset: const Offset(0, 3),
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
                  color: isAvailable
                      ? AppColor.mainColor.withValues(alpha: 0.10)
                      : AppColor.border.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(13),
                ),
                alignment: Alignment.center,
                child: Text(
                  '🏷️',
                  style: TextStyle(
                    fontSize: 23,
                    color: isAvailable
                        ? AppColor.mainColor
                        : AppColor.textSecondary,
                  ),
                ),
              ),

              const SizedBox(width: 11),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            coupon.code,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColor.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        StatusBadge(
                          text: isUsed
                              ? 'مستخدم'
                              : isExpired
                              ? 'منتهي'
                              : 'متاح',
                          isAvailable: isAvailable,
                        ),
                      ],
                    ),

                    const SizedBox(height: 3),

                    Text(
                      coupon.discountType == 'percentage'
                          ? 'خصم ${coupon.discountValue.toStringAsFixed(0)}٪ على طلبك'
                          : 'خصم ${coupon.discountValue.toStringAsFixed(0)} جنيه على طلبك',
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

          ExpirySection(
            expiresAt: coupon.expiresAt,
            now: _now,
            isUsed: isUsed,
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: InfoItem(
                  emoji: '🛍️',
                  title: 'الحد الأدنى',
                  value:
                  '${coupon.minimumOrder.toStringAsFixed(0)} جنيه',
                ),
              ),

              Container(
                width: 1,
                height: 38,
                color: AppColor.border.withValues(alpha: 0.8),
              ),

              Expanded(
                child: InfoItem(
                  emoji: '💰',
                  title: 'قيمة الخصم',
                  value: discountText,
                ),
              ),
            ],
          ),

          if (isAvailable) ...[
            const SizedBox(height: 14),

            BlocBuilder<SelectedCouponCubit, SelectedCouponState>(
              builder: (context, state) {
                final isSelected =
                    state is SelectedCouponSelected &&
                        state.code == coupon.code;

                return SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: CustomButton(
                    onPressed: isSelected
                        ? null
                        : () {
                      context
                          .read<SelectedCouponCubit>()
                          .selectCoupon(coupon.code);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isSelected ? '✅' : '🏷️',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 7),
                        Text(
                          isSelected
                              ? 'تم اختيار الكوبون'
                              : 'استخدم الكوبون',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}