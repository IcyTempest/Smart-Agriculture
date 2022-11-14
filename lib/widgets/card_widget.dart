import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smart_agriculture_v2/configs/space_config.dart';
import 'package:smart_agriculture_v2/domain/domains.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key, required this.myContent}) : super(key: key);
  final MyContent myContent;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      margin: EdgeInsets.only(
        bottom: SpaceConfig.height1,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          opacity: 0.5,
          image: AssetImage(
            myContent.imagePath ?? "assets/images/rise.png",
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            getText(myContent.title ?? "Unkown",
                size: 25, fontWeight: FontWeight.normal, paddingDown: 15),
            getText("Farmer: ${myContent.farmerName ?? "Unknown"}"),
            getText("Local: 0${myContent.local ?? "0"}"),
            getText("Device: 0${myContent.devices ?? "0"}"),
            getText("Date Start: ${myContent.date ?? "Unknown"}"),
          ],
        ),
      ),
    );
  }

  Widget getText(
    String text, {
    Color? color = Colors.white,
    FontWeight fontWeight = FontWeight.bold,
    double? size,
    double paddingDown = 10,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: paddingDown),
      child: Text(
        text,
        style: textStyle(
          color: color,
          fontWeight: fontWeight,
          size: size,
        ),
      ),
    );
  }

  TextStyle textStyle(
      {Color? color = Colors.white, FontWeight fontWeight = FontWeight.bold, double? size}) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.bold,
    );
  }
}
