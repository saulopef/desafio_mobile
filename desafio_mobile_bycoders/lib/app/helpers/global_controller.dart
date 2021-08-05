import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver analyticsObs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalController(this.analytics, this.analyticsObs);
  Rx<User?> userCredential = Rx<User?>(null);
  @override
  void onInit() {
    super.onInit();
    userCredential.bindStream(_auth.authStateChanges());
  }
}
