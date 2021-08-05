import 'package:desafio_mobile_bycoders/app/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class InitialController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    FirebaseAuth _auth = FirebaseAuth.instance;
    if (_auth.currentUser == null) {
      Get.offAndToNamed(Routes.LOGIN);
    } else {
      Get.offAndToNamed(Routes.HOME);
    }
  }
}
