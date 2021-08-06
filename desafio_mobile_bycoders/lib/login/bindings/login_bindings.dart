import 'package:desafio_mobile_bycoders/app/helpers/global_controller.dart';
import 'package:desafio_mobile_bycoders/login/controller/login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
        () => LoginController(FirebaseAuth.instance, Get.find<GlobalController>()));
  }
}
