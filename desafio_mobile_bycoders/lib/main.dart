import 'package:desafio_mobile_bycoders/app/helpers/global_variables.dart';
import 'package:desafio_mobile_bycoders/app/routes/app_pages.dart';
import 'package:desafio_mobile_bycoders/app/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inicia uma instancia do firebase
  await Firebase.initializeApp();
  // Inicia uma instancia do DataBase
  await Hive.initFlutter();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Desafio Mobile Flutter',
      debugShowCheckedModeBanner: false,
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
      initialRoute: Routes.HOME,
    );
  }
}
