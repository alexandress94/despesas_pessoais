import 'package:despesas_pessoais/app/bindings/transactions_bindings.dart';
import 'package:despesas_pessoais/app/ui/android/initial/initial_page.dart';
import 'package:despesas_pessoais/app/ui/android/transaction/transaction_page.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.INITIAL,
      page: () => InitialPage(),
    ),
    GetPage(
      name: Routes.TRANSACTION,
      page: () => TransactionPage(),
      binding: TransactionPageBinding(),
    ),
  ];
}
