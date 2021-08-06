import 'package:desafio_mobile_bycoders/app/helpers/global_controller.dart';
import 'package:desafio_mobile_bycoders/home/controller/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
        () => HomeController(FirebaseAuth.instance, Get.find<GlobalController>()));
  }
}
