import 'package:pizza_sofian_market/features/checkout/presentation/view_model/checkout_cubit.dart';
import '../../../../../core/helper_function/custom_show_dialog.dart';
import '../../../../../core/utils/app_imports.dart';
import '../../../../restaurant_status/presentation/view_model/restaurant_status_cubit.dart';

class OrderReviewButtonSection extends StatelessWidget {
  const OrderReviewButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        final cubit = context.read<CheckoutCubit>();

        return BlocSelector<
            RestaurantStatusCubit,
            RestaurantStatusState,
            bool>(
          selector: (state) {
            if (state is RestaurantStatusLoaded) {
              return state.restaurantStatus.isOpen;
            }

            return false;
          },
          builder: (context, isRestaurantOpen) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: isRestaurantOpen
                  ? CustomButton(
                key: const ValueKey('confirm_order'),
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();

                  if (cubit.enteredCouponCode.isNotEmpty &&
                      cubit.appliedCoupon == null) {
                    AppVibration.heavy();
                    AppSounds.playClickSound('click_error.wav');

                    customShowSnakeBar(
                      context,
                      color: AppColor.red,
                      label: 'يرجى التحقق من الكوبون أولاً',
                    );

                    return;
                  }

                  CustomShowDialog.show(
                    context,
                    title: 'تأكيد الدفع',
                    content: Text(
                      'هل أنت متأكد من إتمام عملية الدفع؟',
                      textAlign: TextAlign.center,
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    accept: () async {
                      Navigator.pop(context);

                      cubit.orderEntity.orderNote =
                          cubit.notesController.text.trim();

                      await cubit.addOrder(cubit.orderEntity);
                    },
                    cancel: () {
                      Navigator.pop(context);
                    },
                  );
                },
                child: Text(
                  'تاكيد الطلب',
                  style: StyleManager.font15Weight800.copyWith(
                    color: AppColor.white,
                  ),
                ),
              )
                  : Container(
                key: const ValueKey('restaurant_closed'),
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 15.h,
                ),
                decoration: BoxDecoration(
                  color: AppColor.card,
                  borderRadius: BorderRadius.circular(18.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.06),
                      blurRadius: 12.r,
                      offset: Offset(0, 5.h),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        color: AppColor.red.withOpacity(.10),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '🏪',
                        style: TextStyle(
                          fontSize: 23.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'المطعم مغلق حاليًا',
                            style: StyleManager.font14Weight600.copyWith(
                              color: AppColor.textPrimary,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'لا يمكن إتمام الطلب الآن، حاول مرة أخرى لاحقًا',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: StyleManager.font11Weight400.copyWith(
                              color: AppColor.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
