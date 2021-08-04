import 'package:flutter/material.dart';

// created by Saulo Senoski at 20210803 22:48.
//
// saulo@onecorpore.com.br
// OneCorpore
// Desenvolvimento de Softwares

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    this.onTap,
    this.iconData = Icons.cached,
    this.size = 50,
    this.color = Colors.grey,
  });

  final Function()? onTap;
  final IconData iconData;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: onTap,
        // ignore: sized_box_for_whitespace
        child: Container(
          height: size,
          width: size,
          child: Icon(
            iconData,
            size: size * 0.6,
            color: color,
          ),
        ));
  }
}
