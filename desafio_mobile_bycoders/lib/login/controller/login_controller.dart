import 'package:desafio_mobile_bycoders/login/repository/login_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final LoginRepository repository;

  LoginController(this.repository);

  final _obj = ''.obs;
  // Define se deve esconder o campo senha
  final obscure = true.obs;
  // Define se deve guardar informações de login
  final keepLogin = true.obs;
  // Key para validação do formulário de login
  final formKey = GlobalKey<FormState>();

  get obj => this._obj.value;
}
