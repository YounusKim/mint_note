import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 200,
        child: SvgPicture.asset('assets/images/mint.svg', fit: BoxFit.contain),
      ),
    );
  }
}
