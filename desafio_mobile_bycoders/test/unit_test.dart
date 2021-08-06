import 'package:desafio_mobile_bycoders/app/helpers/global_controller.dart';
import 'package:desafio_mobile_bycoders/home/controller/home_controller.dart';
import 'package:desafio_mobile_bycoders/login/controller/login_controller.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mockito/mockito.dart';

import 'mock_geolocator.dart';

class MockFirebaseAnalytics extends Mock implements FirebaseAnalytics {}

main() async {
  Get.testMode = true;

  await Hive.initFlutter();

  final user = MockUser(
    isAnonymous: false,
    uid: 'someuid',
    email: 'bob@somedomain.com',
    displayName: 'Bob',
  );

  final auth = MockFirebaseAuth(signedIn: false, mockUser: user);

  GlobalController globalController = Get.put(
    GlobalController(MockFirebaseAnalytics(), auth),
  );

  LoginController loginController = Get.put(
    LoginController(auth, globalController),
  );

  HomeController homeController = Get.put(HomeController(
    auth,
    globalController,
  ));

  group('Login Unit Test', () {
    // Testa se o login está funcionando corretamente
    test('signin with email and password', () async {
      final logged = await loginController.login('bob@somedomain.com', "123456");
      expect(logged, true);
    });
    // testa se os dados foram salvos corretamente no banco local
    test('user credentials from local data base', () async {
      expect(loginController.box?.get("email"), user.email);
      expect(loginController.box?.get("uid"), user.uid);
    });

    tearDown(() {
      Get.reset();
    });
  });

  group("Home Unit test", () {
    setUp(() async {
      GeolocatorPlatform.instance = MockGeolocatorPlatform();
      Get.testMode = true;
    });

    test("determinar posição", () async {
      final result = await homeController.determinePosition();
      expect(result, true);
    });
    test('return position from database', () async {
      await homeController.determinePosition();

      expect(homeController.box, isNotNull);
      expect(homeController.box?.get("latitude"), mockPosition.latitude);
      expect(homeController.box?.get("longitude"), mockPosition.longitude);
      expect(homeController.box?.get("accuracy"), mockPosition.accuracy);
    });

    // Testa se o logou está funcionando corretamente
    test('signout', () async {
      final notLogged = await homeController.signOut();
      expect(notLogged, true);
    });

    tearDown(() {
      Get.reset();
    });
  });
}
