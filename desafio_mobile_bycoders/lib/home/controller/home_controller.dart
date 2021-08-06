import 'dart:async';

import 'package:desafio_mobile_bycoders/app/helpers/global_controller.dart';
import 'package:desafio_mobile_bycoders/app/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';

class HomeController extends GetxController {
  HomeController(this._auth, this.globalController);
  final globalController;
  // posição da camera, posiciona inicialmente em uma localização qualquer
  //e depois anima a tela para a posição do usuário
  final target = LatLng(37.42796133580664, -122.085749655962).obs;

// Controllador do mapa
  Completer<GoogleMapController> mapController = Completer();

  // Marcadores do mapa
  RxSet<Marker> marcadores = Set<Marker>().obs;

  FirebaseAuth _auth;

  Box? box;

  @override
  void onInit() async {
    super.onInit();
    box = await Hive.openBox('globalStore');
  }

  @override
  void onReady() async {
    super.onReady();
    determinePosition();
  }

  // Busca a posição atual do usuário
  Future<bool> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Varifica se o serviço de geolocalização está habilitado no aparelho
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      // Verifica se foi concedida permissão de geolocalização
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        // Se for negado, solicita novamente
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          // em caso de erro informa o usuário com um snackbar
          Get.snackbar("Erro no Serviço de Geolocalização", "Permissão de Localização negada",
              snackPosition: SnackPosition.BOTTOM);

          // Envia evento de erro ao analytics
          if (!Get.testMode) {
            globalController.analytics.logEvent(name: "Home_Render", parameters: {
              "success": "false",
              "latitude": "",
              "longitude": "",
              "accuracy": "",
              "error": "Permissão de Localização negada"
            });
          }
          return false;
        }

        if (permission == LocationPermission.deniedForever) {
          // em caso de erro informa o usuário com um snackbar
          Get.snackbar("Erro no Serviço de Geolocalização",
              "Permissão de Localização permanentemente negada, não podemos solicitar nova permissão",
              snackPosition: SnackPosition.BOTTOM);

          // Envia evento de erro ao analytics
          if (!Get.testMode) {
            globalController.analytics.logEvent(name: "Home_Render", parameters: {
              "success": "false",
              "latitude": "",
              "longitude": "",
              "accuracy": "",
              "error":
                  "Permissão de Localização permanentemente negada, não podemos solicitar nova permissão"
            });
          }
          return false;
        }
        return false;
      } else {
        Position position = await Geolocator.getCurrentPosition();

        target.value = LatLng(position.latitude, position.longitude);

        // Salva a posição atual do usuario
        box?.put("latitude", position.latitude);
        box?.put("longitude", position.longitude);
        box?.put("accuracy", position.accuracy);

        // Envia evento de erro ao analytics
        if (!Get.testMode) {
          globalController.analytics.logEvent(name: "Home_Render", parameters: {
            "success": "true",
            "latitude": position.latitude,
            "longitude": position.longitude,
            "accuracy": position.accuracy,
            "error": ""
          });
        }

        // Anima o mapa para a posição atual do usuário
        goToTarget();
        return true;
      }
    } else {
      // Em caso de erro informa o usuário com um Dialog que o serviço não está habilitado
      Get.defaultDialog(
        title: "Erro no Serviço de Geolocalização",
        content: Text("Por favor Ative o serviço de localização e tente novamente!"),
        textConfirm: "Já ativei!",
        onConfirm: () {
          Get.back();
          determinePosition();
        },
      );

      // Envia evento de erro ao analytics
      if (!Get.testMode) {
        globalController.analytics.logEvent(name: "Home_Render", parameters: {
          "success": "false",
          "latitude": "",
          "longitude": "",
          "accuracy": "",
          "error": "Serviço de Localização desativado"
        });
      }
      return false;
    }
  }

  void goToTarget() async {
    // Anima o mapa para a posição atual do usuário
    final GoogleMapController _map = await mapController.future;
    _map.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: target.value, zoom: 18),
      ),
    );

    marcadores.add(
      Marker(
          markerId: MarkerId(DateTime.now().millisecondsSinceEpoch.toString()),
          position: target.value,
          infoWindow: InfoWindow(
            title: "Posição Atual",
          )),
    );
  }

  // realiza logout
  Future<bool> signOut() async {
    final String? email = _auth.currentUser?.email;

    try {
      await _auth.signOut();

      if (!Get.testMode) {
        // Envia evento de sucesso ao analytics
        globalController.analytics.logEvent(name: "Usuario_Deslogado", parameters: {"user": email});
      }
      // Envia o usuario pra a tela de login
      Get.offAndToNamed(Routes.LOGIN);
      return true;
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Erro de Logout", e.message ?? "Erro ao tentar realizar o logout",
          snackPosition: SnackPosition.BOTTOM);
      if (!Get.testMode) {
        // Envia evento de erro ao analytics
        globalController.analytics.logEvent(name: "Erro_Logout", parameters: {
          "user_email": email,
          "logout_error": e.message ?? "Erro ao tentar realizar o logout"
        });
      }
      return false;
    }
  }
}
