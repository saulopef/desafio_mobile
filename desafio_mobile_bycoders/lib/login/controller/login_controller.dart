import 'package:desafio_mobile_bycoders/app/helpers/global_controller.dart';
import 'package:desafio_mobile_bycoders/app/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class LoginController extends GetxController {
  final globalController = Get.find<GlobalController>();
  FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<User?> _userCredential = Rx<User?>(null);

  Box? box;

  final _obj = ''.obs;
  // Define se deve esconder o campo senha
  final obscure = true.obs;
  // Define se deve guardar informações de login
  final keepLogin = true.obs;
  // Key para validação do formulário de login
  final formKey = GlobalKey<FormState>();

  get obj => this._obj.value;

  @override
  void onInit() async {
    super.onInit();
    _userCredential.bindStream(_auth.authStateChanges());
    box = await Hive.openBox('globalStore');
  }

  void login(String email, String password) async {
    // FirebaseCrashlytics.instance.crash();
    try {
      // realiza login
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // se tudo der certo guarda as informações
      box?.put('email', email);
      // Envia evento de sucesso ao analytics
      globalController.analytics.logLogin();
      globalController.analytics.logEvent(name: "Usuario_Logado", parameters: {
        "user_email": _userCredential.value?.email,
        "user_uid": _userCredential.value?.uid
      });
      // então envia o usuario para a tela principal.
      Get.offAndToNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      // em caso de erro informa o usuário com um snackbar
      Get.snackbar("Erro de Login", e.message ?? "Erro ao tentar realizar o login",
          snackPosition: SnackPosition.BOTTOM);
      // Envia evento de erro ao analytics
      globalController.analytics.logEvent(name: "Erro_Login", parameters: {
        "user_email": email,
        "login_error": e.message ?? "Erro ao tentar realizar o login"
      });
    }
  }
}
