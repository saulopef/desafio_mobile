import 'package:desafio_mobile_bycoders/app/helpers/global_controller.dart';
import 'package:desafio_mobile_bycoders/app/helpers/global_variables.dart';
import 'package:desafio_mobile_bycoders/app/routes/app_pages.dart';
import 'package:desafio_mobile_bycoders/app/routes/app_routes.dart';
import 'package:desafio_mobile_bycoders/initial_route/binding/initial_binding.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configApp();
  runApp(MyApp());
}

Future<void> configApp() async {
  // Inicia uma instancia do firebase
  await Firebase.initializeApp();
  // Envia todos os uncaught ao Crashlytics.
  if (!Get.testMode) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }
  // Inicia uma instancia do DataBase
  await Hive.initFlutter();
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver analyticsObs = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    Get.put(GlobalController(analytics, FirebaseAuth.instance), permanent: true);
    return GetMaterialApp(
      title: 'Desafio Mobile Flutter',
      debugShowCheckedModeBanner: false,
      navigatorObservers: [analyticsObs],
      theme: ThemeData(
        primarySwatch: MaterialColor(
          OneColors.cwbBlue.value,
          customSwatch(OneColors.cwbBlue),
        ),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.grey),
        ),
        scaffoldBackgroundColor: OneColors.white,
        accentColor: OneColors.cwbGreen,
        cardColor: Colors.white,
      ),
      getPages: AppPages.pages,
      initialBinding: InitialBinding(),
      initialRoute: Routes.INITIAL,
    );
  }
}
