import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  final FirebaseAnalytics analytics;
  final FirebaseAuth _auth;
  GlobalController(this.analytics, this._auth);
  Rx<User?> userCredential = Rx<User?>(null);
  @override
  void onInit() {
    super.onInit();
    userCredential.bindStream(_auth.authStateChanges());
  }
}
