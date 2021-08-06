import 'package:desafio_mobile_bycoders/home/home_page.dart';
import 'package:desafio_mobile_bycoders/login/login_page.dart';
import 'package:desafio_mobile_bycoders/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:integration_test/integration_test.dart';

main() {
  Get.testMode = true;
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Encontra os inputs
  final emailFormField = find.byKey(Key('email'));
  final passwordFormField = find.byKey(Key('senha'));
  final loginButton = find.byType(ElevatedButton).first;

  testWidgets("Erro de login", (tester) async {
    await app.configApp();
    await tester.pumpWidget(app.MyApp());
    await tester.pumpAndSettle();
    Get.testMode = true;

    // Preenche os campos do formulário de login
    await tester.enterText(emailFormField, "saulopef@gmail.com");
    await tester.enterText(passwordFormField, "senhaAleatoria");
    await tester.pumpAndSettle();

    // tenta realizar o login;
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.byType(HomePage), findsNothing);

    // await app.configApp();
    Get.reset();
  });

  testWidgets("login com sucesso e mapa renderizado com sucesso", (tester) async {
    await tester.pumpWidget(app.MyApp());
    await tester.pumpAndSettle();
    Get.testMode = true;

    // Preenche os campos do formulário de login
    await tester.enterText(emailFormField, "bycoders@testemobile.com");
    await tester.enterText(passwordFormField, "123456");
    await tester.pumpAndSettle();

    // tenta realizar o login;
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(find.byType(LoginPage), findsNothing);
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byType(GoogleMap).first, findsOneWidget);
  });
}
