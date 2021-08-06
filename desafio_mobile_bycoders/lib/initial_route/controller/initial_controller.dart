import 'package:desafio_mobile_bycoders/app/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class InitialController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void onReady() {
    super.onReady();
    if (auth.currentUser == null) {
      Get.offAndToNamed(Routes.LOGIN);
    } else {
      Get.offAndToNamed(Routes.HOME);
    }
  }
}
