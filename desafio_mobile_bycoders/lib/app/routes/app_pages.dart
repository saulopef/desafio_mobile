import 'package:desafio_mobile_bycoders/app/routes/app_routes.dart';
import 'package:desafio_mobile_bycoders/home/binding/home_binding.dart';
import 'package:desafio_mobile_bycoders/home/home_page.dart';
import 'package:desafio_mobile_bycoders/login/bindings/login_bindings.dart';
import 'package:desafio_mobile_bycoders/login/login_page.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.LOGIN, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
