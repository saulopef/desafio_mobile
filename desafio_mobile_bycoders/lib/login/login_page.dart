import 'package:desafio_mobile_bycoders/app/helpers/global_variables.dart';
import 'package:desafio_mobile_bycoders/login/controller/login_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// created by Saulo Senoski at 20210803 22:48.
//
// saulo@onecorpore.com.br
// OneCorpore
// Desenvolvimento de Softwares

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: childrens(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> childrens() {
  final controller = Get.find<LoginController>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  return [
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      margin: const EdgeInsets.symmetric(vertical: 20),
      height: 200,
      child: Image.asset(OneAssets.logo),
    ),
    Obx(() {
      // ignore: unused_local_variable
      final String obj = controller.obj; // mock

      return TextFormField(
        key: Key('email'),
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
          labelText: 'email',
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
      );
    }),
    OneSapators.medium,
    Obx(() {
      return TextFormField(
        key: Key('senha'),
        obscureText: controller.obscure.value,
        controller: passwordController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
          labelText: 'Senha',
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.0),
          ),
          suffixIcon: InkWell(
            onTap: () {
              controller.obscure.toggle();
            },
            child: Icon(
              controller.obscure.value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              size: 30,
            ),
          ),
        ),
      );
    }),
    OneSapators.medium,
    GestureDetector(
      onTap: () {
        controller.keepLogin.toggle();
      },
      child: Container(
        width: double.infinity,
        height: 50,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Checkbox(
                value: controller.keepLogin.value,
                onChanged: (b) {
                  controller.keepLogin.toggle();
                })),
            const Text('Mantenha-me Logado',
                style: TextStyle(color: OneColors.charcoal, fontSize: 16)),
          ],
        ),
      ),
    ),
    Align(
      child: RichText(
        text: TextSpan(
          text: 'Não Consigo ',
          style: const TextStyle(color: OneColors.charcoal),
          children: <TextSpan>[
            TextSpan(
              text: 'Acessar Minha Conta.',
              style: const TextStyle(color: OneColors.oceanBlue),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.defaultDialog(
                    title: '',
                    content: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.lock_outline_rounded,
                            size: 100,
                            color: OneColors.oceanBlue,
                          ),
                          Text(
                            'Para Recuperar sua Senha',
                            style: TextStyle(color: Colors.black87, fontSize: 20.0),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Entre em Contato com o responsavel',
                            style: TextStyle(color: Colors.black45, fontSize: 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    confirm: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: ElevatedButton(
                        onPressed: () => Get.back(),
                        child: const Text(
                          'Ok',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
            )
          ],
        ),
      ),
    ),
    const SizedBox(height: 16),
    Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        width: GetPlatform.isMobile ? Get.width : Get.width / 3,
        child: Obx(
          () => ElevatedButton(
            onPressed: () {
              HapticFeedback.heavyImpact();
              controller.login(emailController.text, passwordController.text);
            },
            child: controller.isLoading.value
                ? Container(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
                : const Text(
                    'Fazer Login',
                    style: TextStyle(color: Colors.white),
                  ),
          ),
        ))
  ];
}
