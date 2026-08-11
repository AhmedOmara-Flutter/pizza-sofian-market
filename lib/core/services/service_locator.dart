import 'package:pizza_sofian_market/core/repos/order_repo/order_repo.dart';
import 'package:pizza_sofian_market/core/repos/product_repo/product_repo.dart';
import 'package:pizza_sofian_market/core/repos/product_repo/product_repo_impl.dart';
import 'package:pizza_sofian_market/core/services/storage_services.dart';
import 'package:pizza_sofian_market/core/utils/app_imports.dart';
import '../../features/favorite/app/repos/favorite_repo_impl.dart';
import '../../features/favorite/domain/repos/favorite_repo.dart';
import '../../features/reviews/data/repos/review_repo_impl.dart';
import '../../features/reviews/domain/repos/review_repo.dart';
import '../repos/cart_repo/cart_repo.dart';
import '../repos/cart_repo/cart_repo_impl.dart';
import '../repos/offer_repo/offer_repo.dart';
import '../repos/offer_repo/offer_repo_impl.dart';
import '../repos/order_repo/order_repo_impl.dart';
import '../repos/upload_image_repo/upload_image_repo.dart';
import '../repos/upload_image_repo/upload_image_repo_impl.dart';

final instance = GetIt.instance;

void initAppModule() {
  instance.registerLazySingleton<AuthServices>(
        () => AuthWithFirebase(),
  );
  instance.registerLazySingleton<DatabaseServices>(() => FirestoreDatabase());
  instance.registerLazySingleton<StorageServices>(() => SupabaseStorage());
  instance.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(instance(), instance()),
  );

  instance.registerLazySingleton<ProductRepo>(
    () => ProductRepoImpl(instance()),
  );

  instance.registerLazySingleton<FavoriteRepo>(
    () => FavoriteRepoImpl(instance()),
  );
  instance.registerLazySingleton<OrderRepo>(
    () => OrderRepoImpl(instance()),
  );

  instance.registerLazySingleton<ReviewRepo>(
        () => ReviewRepoImpl(instance()),
  );
  instance.registerLazySingleton<OfferRepo>(
        () => OfferRepoImpl(instance()),
  );
  instance.registerLazySingleton<UploadImageRepo>(
        () => UploadImageRepoImpl(instance()),
  );
  instance.registerLazySingleton<CartRepo>(
        () => CartRepoImpl(instance()),
  );
}
