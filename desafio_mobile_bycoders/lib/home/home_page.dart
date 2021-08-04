import 'package:desafio_mobile_bycoders/app/helpers/global_variables.dart';
import 'package:desafio_mobile_bycoders/app/widgets/rouded_icon_buton.dart';
import 'package:desafio_mobile_bycoders/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Minha Localização Atual',
          style: OneStyles.pageTitle.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          RoundIconButton(
            iconData: Icons.logout_rounded,
            color: Colors.white,
          )
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => GoogleMap(
            onMapCreated: (GoogleMapController _controller) {
              controller.mapController.complete(_controller);
            },
            initialCameraPosition: CameraPosition(
              target: controller.target.value,
              zoom: 11,
            ),
            markers: controller.marcadores,
          ),
        ),
      ),
    );
  }
}
