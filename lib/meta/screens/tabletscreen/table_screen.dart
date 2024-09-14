import 'package:flutter/material.dart';
import 'package:galleryapp/app/constants/constants.dart';
import 'package:galleryapp/app/constants/sizeconfig.dart';
import 'package:galleryapp/meta/screens/home/galleryhome_screen.dart';

class TabletLayoutScreen extends StatelessWidget {
  final BoxConstraints constraints;
  const TabletLayoutScreen({super.key, required this.constraints});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: BConstantColors.backgroundColor,
        title: Text(
          "Gallery app",
          style: kPopinsSemiBold.copyWith(
              fontSize: SizeConfig.screenWidth! * 0.02,
              color: BConstantColors.txt3Color),
        ),
        centerTitle: true,
      ),
      backgroundColor: BConstantColors.backgroundColor,
      body: GalleryHomeScreen(
        constraints: constraints,
      ),
    );
  }
}
