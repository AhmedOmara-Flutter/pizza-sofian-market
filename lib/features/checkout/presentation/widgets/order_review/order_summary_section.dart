import '../../../../../core/utils/app_imports.dart';

class OrderSummarySection extends StatelessWidget {
  final double totalPrice;
  final double delivery;

  const OrderSummarySection({
    super.key,
    required this.totalPrice,
    required this.delivery,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20.h,
        horizontal: 15.w,
      ),
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: AppColor.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'المجموع الفرعي :',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: AppColor.textSecondary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'التوصيل :',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: AppColor.textSecondary,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$totalPrice جنيه',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: AppColor.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '$delivery جنيه',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColor.mainColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.only(
              top: 8.h,
              bottom: 12.h,
              left: 20.w,
              right: 20.w,
            ),
            child: Divider(
              color: AppColor.border,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الكلي',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: AppColor.textPrimary,
                ),
              ),
              Text(
                '${(totalPrice + delivery).toStringAsFixed(2)} جنيه',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: AppColor.mainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}