import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends GetxController {
  final target = LatLng(37.42796133580664, -122.085749655962).obs;
  Completer<GoogleMapController> mapController = Completer();
  RxSet<Marker> marcadores = Set<Marker>().obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _determinePosition();
  }

  void _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
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
        goToTarget();
      }
    } else {
      // em caso de erro informa o usuário com um snackbar
      Get.snackbar("Erro no Serviço de Geolocalização",
          "Por favor Ative o serviço de localização e tente novamente!",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void goToTarget() async {
    final GoogleMapController _map = await mapController.future;
    _map.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: target.value, zoom: 15),
      ),
    );

    marcadores.add(
      Marker(
        markerId: MarkerId(DateTime.now().millisecondsSinceEpoch.toString()),
        position: target.value,
      ),
    );
  }
}
