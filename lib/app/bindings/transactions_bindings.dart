import 'package:despesas_pessoais/app/controller/transaction_controller.dart';
import 'package:get/get.dart';

class TransactionPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () {
        return TransactionController();
      },
    );
  }
}
