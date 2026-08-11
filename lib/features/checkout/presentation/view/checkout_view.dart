import 'package:pizza_sofian_market/core/entities/order_entity.dart';

import '../../../../core/utils/app_imports.dart';
import '../view_model/checkout_cubit.dart';
import '../widgets/checkout_view_body.dart';

class CheckoutView extends StatelessWidget {
  final OrderEntity orderEntity;

  const CheckoutView({super.key, required this.orderEntity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutCubit(orderEntity, instance(), instance()),
      child: Scaffold(
        body: CheckoutViewBody(),
      ),
    );
  }
}
