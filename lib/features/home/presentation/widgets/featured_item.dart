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
    return GestureDetector(
      onTap: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        await AppSounds.playClickSound('click_song.wav');

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
            Positioned(
              top: 43.h,
              child: Container(
                width: 110.w,
                height: 90.h,
                decoration: BoxDecoration(
                  color: AppColor.card,
                  borderRadius: BorderRadius.circular(22.r),
                  border: Border.all(
                    color: Colors.white.withOpacity(.05),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.35),
                      blurRadius: 22.r,
                      offset: Offset(0, 10.h),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 39.h,
                    left: 10.w,
                    right: 10.w,
                    bottom: 15.h,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        productEntity.name,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: StyleManager.font14Weight600.copyWith(
                          color: AppColor.textPrimary,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              top: 0,
              child: SizedBox(
                width: 90.w,
                height: 90.w,
                child: CachedNetworkImage(
                  imageUrl: productEntity.image ?? "",
                  fit: BoxFit.contain,
                  placeholder: (_, __) => Center(
                    child: SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(
                        color: AppColor.mainColor,
                        strokeWidth: 2,
                      ),
                    ),
                  ),

                  errorWidget: (_, __, ___) =>
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60.r),
                          child: SizedBox(
                            width: 90.w,
                            height: 90.w,
                            child: Icon(
                              Icons.fastfood_rounded,
                              size: 36.sp,
                              color: AppColor.textSecondary,
                            ),
                          ),
                        ),

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