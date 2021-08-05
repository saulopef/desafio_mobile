import 'dart:async';

import 'package:desafio_mobile_bycoders/app/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';

class HomeController extends GetxController {
  // posição da camera, posiciona inicialmente em uma localização qualquer
  //e depois anima a tela para a posição do usuário
  final target = LatLng(37.42796133580664, -122.085749655962).obs;

// Controllador do mapa
  Completer<GoogleMapController> mapController = Completer();

  // Marcadores do mapa
  RxSet<Marker> marcadores = Set<Marker>().obs;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Box? box;

  @override
  void onReady() async {
    super.onReady();
    box = await Hive.openBox('globalStore');
    determinePosition();
  }

  // Busca a posição atual do usuário
  void determinePosition() async {
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
        }

        if (permission == LocationPermission.deniedForever) {
          // em caso de erro informa o usuário com um snackbar
          Get.snackbar("Erro no Serviço de Geolocalização",
              "Permissão de Localização permanentemente negada, não podemos solicitar nova permissão",
              snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        Position position = await Geolocator.getCurrentPosition();

        target.value = LatLng(position.latitude, position.longitude);

        // Salva a posição atual do usuario
        box?.put("latitude", position.latitude);
        box?.put("longitude", position.longitude);
        box?.put("accuracy", position.accuracy);

        // Anima o mapa para a posição atual do usuário
        goToTarget();
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
  void signOut() {
    try {
      _auth.signOut();
      Get.offAndToNamed(Routes.LOGIN);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Erro de Logout", e.message ?? "Erro ao tentar realizar o logout",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
