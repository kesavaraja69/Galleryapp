import 'package:flutter/material.dart';
import 'package:galleryapp/app/constants/constants.dart';
import 'package:galleryapp/app/constants/sizeconfig.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatelessWidget {
  final GoException? error;
  const ErrorScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          error.toString(),
          style: kPopinsSemiBold.copyWith(
              fontSize: SizeConfig.screenWidth! * 0.03,
              color: BConstantColors.txt3Color),
        ),
      ),
    );
  }
}
