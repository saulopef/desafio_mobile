import 'package:desafio_mobile_bycoders/login/repository/login_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<User?> _userCredential = Rx<User?>(null);

  final _obj = ''.obs;
  // Define se deve esconder o campo senha
  final obscure = true.obs;
  // Define se deve guardar informações de login
  final keepLogin = true.obs;
  // Key para validação do formulário de login
  final formKey = GlobalKey<FormState>();

  get obj => this._obj.value;

  @override
  void onInit() {
    super.onInit();
    _userCredential.bindStream(_auth.authStateChanges());
  }

  void login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Erro de Login", e.message ?? "Erro ao tentar realizar o login",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void signOut() {
    try {
      _auth.signOut();
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Erro de Logout", e.message ?? "Erro ao tentar realizar o logout",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
