import 'package:desafio_mobile_bycoders/initial_route/controller/initial_controller.dart';
import 'package:get/get.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(InitialController());
  }
}
