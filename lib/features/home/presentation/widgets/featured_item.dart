import 'package:cached_network_image/cached_network_image.dart';
import 'package:pizza_sofian_market/core/entities/product_entity.dart';

import '../../../../core/utils/app_imports.dart';

class FeaturedItem extends StatelessWidget {
  final ProductEntity productEntity;

  const FeaturedItem({
    super.key,
    required this.productEntity,
  });

  @override
  Widget build(BuildContext context) {
    final isPaused = productEntity.isPaused;

    return GestureDetector(
      onTap: () async {
        FocusManager.instance.primaryFocus?.unfocus();

        await AppSounds.playClickSound(
          'click_song.wav',
        );

        Navigator.pushNamed(
          context,
          RouteManager.productDetails,
          arguments: productEntity.id,
        );
      },
      child: SizedBox(
        width: 112.w,
        height: 158.h,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
// =========================
// CARD
// =========================
            Positioned(
              top: 43.h,
              child: Container(
                width: 110.w,
                height: 90.h,
                decoration: BoxDecoration(
                  color: AppColor.card,
                  borderRadius: BorderRadius.circular(22.r),
                  border: Border.all(
                    color: isPaused
                        ? AppColor.border
                        : AppColor.mainColor.withOpacity(.1),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.25),
                      blurRadius: 18.r,
                      offset: Offset(0, 8.h),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 39.h,
                    left: 8.w,
                    right: 8.w,
                    bottom: 10.h,
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      productEntity.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.font14Weight600.copyWith(
                        color: isPaused
                            ? AppColor.textSecondary
                            : AppColor.textPrimary,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ),

// =========================
// PRODUCT IMAGE
// =========================
            Positioned(
              top: 0,
              child: SizedBox(
                width: 90.w,
                height: 90.w,
                child: Opacity(
                  opacity: isPaused ? .38 : 1,
                  child: CachedNetworkImage(
                    imageUrl: productEntity.image ?? '',
                    fit: BoxFit.contain,
                    placeholder: (_, __) =>
                        Center(
                          child: SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: const CircularProgressIndicator(
                              color: AppColor.mainColor,
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                    errorWidget: (_, __, ___) {
                      return Container(
                        width: 90.w,
                        height: 90.w,
                        decoration: BoxDecoration(
                          color: AppColor.card,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColor.border,
                          ),
                        ),
                        child: Icon(
                          Icons.fastfood_rounded,
                          size: 36.sp,
                          color: AppColor.textSecondary,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            if (isPaused)
              Positioned(
                top: 18.h,
                left: 8.w,
                right: 8.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 5.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.card.withOpacity(.94),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColor.red.withOpacity(.18),
                    ),
                  ),
                  child: Text(
                    'غير متوفر حاليًا',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: StyleManager.font11Weight400.copyWith(
                      color: AppColor.red,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
