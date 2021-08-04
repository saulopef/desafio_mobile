import 'package:desafio_mobile_bycoders/login/controller/login_controller.dart';
import 'package:desafio_mobile_bycoders/login/repository/login_repo.dart';
import 'package:get/get.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
