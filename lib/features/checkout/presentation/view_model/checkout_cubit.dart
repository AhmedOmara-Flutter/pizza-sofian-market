import 'dart:async';
import 'package:pizza_sofian_market/core/entities/order_entity.dart';
import '../../../../core/entities/selected_location_entity.dart';
import '../../../../core/repos/order_repo/order_repo.dart';
import '../../../../core/repos/upload_image_repo/upload_image_repo.dart';
import '../../../../core/utils/app_imports.dart';
import '../view/pages/address_page_view.dart';
import '../view/pages/payment_method_view.dart';
import '../view/pages/review_order_view.dart';
import '../view/pages/select_location_view.dart';
part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit(this.orderEntity, this._orderRepo, this._uploadImageRepo)
    : super(CheckoutInitial());

  final OrderRepo _orderRepo;
  final UploadImageRepo _uploadImageRepo;
  Timer? timer;
  OrderEntity orderEntity;
  final notesController = TextEditingController();
  final PageController pageController = PageController();
  int currentIndex = 0;
  bool? isCashOnDelivery;
  int? selectedLocationIndex;
  final List<String> stepperTitles = ['الدفع', 'المكان', 'العنوان', 'مراجعه'];
  final List<Widget> stepperPages = const [
    PaymentMethodView(),
    SelectLocationView(),
    AddressPageView(),
    ReviewOrderView(),
  ];
  late List<Map<String, String>> paymentOptions = [
    {
      "title": "الدفع عند الاستلام",
      "subtitle": "التسليم الي المكان",
      "price": "${orderEntity.cartEntity.getTotalPrice()} جنيه",
    },
    {
      "title": "الدفع اونلاين",
      "subtitle": "يرجي تحديد طريقه الدفع",
      "price": "${orderEntity.cartEntity.getTotalPrice()} جنيه",
    },
  ];
  final List<SelectedLocationEntity> placesOptions = [
    SelectedLocationEntity(
      title: 'الاستلام من المطعم',
      subTitle: 'استلم طلبك من المطعم',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'آخر الإذاعة',
      subTitle: 'اختر عنوانك داخل أخر الإذاعة',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'آخر الأستاذ',
      subTitle: 'اختر عنوانك داخل آخر الأستاذ',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'آخر سفاجا البلد',
      subTitle: 'اختر عنوانك داخل آخر سفاجا البلد',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'أول الأستاذ',
      subTitle: 'اختر عنوانك داخل أول الأستاذ',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'الإسكان الشرقي',
      subTitle: 'اختر عنوانك داخل الإسكان الشرقي',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'الأشغال',
      subTitle: 'اختر عنوانك داخل الأشغال',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'الإذاعة',
      subTitle: 'اختر عنوانك داخل الإذاعة',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'العرايشي',
      subTitle: 'اختر عنوانك داخل العرايشي',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'العروسة',
      subTitle: 'اختر عنوانك داخل العروسة',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'المدينة الصناعية',
      subTitle: 'اختر عنوانك داخل المدينة الصناعية',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'اللواء',
      subTitle: 'اختر عنوانك داخل اللواء',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'أمواج',
      subTitle: 'اختر عنوانك داخل أمواج',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'تحت الكوبري',
      subTitle: 'اختر عنوانك داخل تحت الكوبري',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'الدائري',
      subTitle: 'اختر عنوانك داخل الدائري',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'زرزارة الجديدة',
      subTitle: 'اختر عنوانك داخل زرزارة الجديدة',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'سوما باي',
      subTitle: 'اختر عنوانك داخل سوما باي',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'سفاجا البلد',
      subTitle: 'اختر عنوانك داخل سفاجا البلد',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'الشروق',
      subTitle: 'اختر عنوانك داخل الشروق',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'الشارع الخلفي',
      subTitle: 'اختر عنوانك داخل الشارع الخلفي',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'الشباب',
      subTitle: 'اختر عنوانك داخل الشباب',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'عماير الجيش',
      subTitle: 'اختر عنوانك داخل عماير الجيش',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'عماير الهدي',
      subTitle: 'اختر عنوانك داخل عماير الهدي',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'عماير النيابة',
      subTitle: 'اختر عنوانك داخل عماير النيابة',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'عماير مبارك',
      subTitle: 'اختر عنوانك داخل عماير مبارك',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'كريازي',
      subTitle: 'اختر عنوانك داخل كريازي',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'كيلو 14',
      subTitle: 'اختر عنوانك داخل كيلو 14',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'كيلو 8',
      subTitle: 'اختر عنوانك داخل كيلو 8',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'الكيلو 1',
      subTitle: 'اختر عنوانك داخل الكيلو 1',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'الكيلو 3',
      subTitle: 'اختر عنوانك داخل الكيلو 3',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'الكيلو 5',
      subTitle: 'اختر عنوانك داخل الكيلو 5',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'مارينا الفولي',
      subTitle: 'اختر عنوانك داخل مارينا الفولي',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'مركز الشباب',
      subTitle: 'اختر عنوانك داخل مركز الشباب',
      cost: 0,
    ),
    SelectedLocationEntity(
      title: 'ميناء أبو طرطور',
      subTitle: 'اختر عنوانك داخل ميناء أبو طرطور',
      cost: 0,
    ),
  ];
  void changePage(int index) {
    currentIndex = index;
    emit(CheckoutChangePage());
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void changeSelectedLocationIndex(int index) {
    selectedLocationIndex = index;
    emit(CheckoutChangeLocationIndex());
  }

  void selectShipping(bool value) {
    isCashOnDelivery = value;
    emit(CheckoutSelectShipping());
  }

  Future<void> addOrder(OrderEntity orderEntity) async {
    emit(CheckoutAddOrderLoading());

    // الدفع عند الاستلام
    if (orderEntity.isCashOnDelivery == true) {
      orderEntity.paymentImage = null;

      final result = await _orderRepo.addOrder(orderEntity);

      result.fold(
        (failure) {
          emit(CheckoutAddOrderError(failure.errMessage));
        },
        (data) {
          orderEntity.id = data;
          emit(CheckoutAddOrderSuccess());
        },
      );

      return;
    }
    if (orderEntity.paymentFileImage == null) {
      emit(CheckoutAddOrderError('يرجى إرفاق صورة إثبات الدفع'));
      return;
    }

    final imageResult = await _uploadImageRepo.uploadImage(
      orderEntity.paymentFileImage!,
    );

    imageResult.fold(
      (failure) {
        emit(CheckoutAddOrderError(failure.errMessage));
      },
      (imageUrl) async {
        orderEntity.paymentImage = imageUrl;

        final result = await _orderRepo.addOrder(orderEntity);

        result.fold(
          (failure) {
            emit(CheckoutAddOrderError(failure.errMessage));
          },
          (data) {
            orderEntity.id = data;
            emit(CheckoutAddOrderSuccess());
          },
        );
      },
    );
  }
}
