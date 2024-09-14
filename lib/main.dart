import 'package:flutter/material.dart';
import 'package:galleryapp/app/routes/app_route_config.dart';
import 'package:galleryapp/core/services/locator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'app/providers/providers.dart';

void main() {
  setupLocator(); //! Initialize get_it
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:
          providers, //! List of providers to be made available throughout the app
      child:
          const Core(), //! The root widget of the app that can access the provided data
    );
  }
}

class Core extends StatelessWidget {
  const Core({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Gallery App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: GoogleFonts.poppins().fontFamily,
        useMaterial3: true,
      ),
      //! Go Router config
      routerConfig: MyAppRoute().router,
    );
  }
}
