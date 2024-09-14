import 'package:flutter/material.dart';
import 'package:galleryapp/meta/screens/largescreen/desktop_screen.dart';
import 'package:galleryapp/meta/screens/mobilescreen/mobile_screen.dart';
import 'package:galleryapp/meta/screens/tabletscreen/table_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        FocusScope.of(context).unfocus();
      },
      child: SizedBox(
        child: LayoutBuilder(
          builder: (context, constraints) {
            //! Check if the maxWidth is greater than 950, use the desktop layout
            if (constraints.maxWidth > 950) {
              return DesktopLayoutScreen(
                constraints:
                    constraints, //! Pass the constraints to the Desktop layout
              );
            }
            //! Check if the maxWidth is greater than 600, but less than 950, use the tablet layout
            else if (constraints.maxWidth > 600) {
              return TabletLayoutScreen(
                constraints:
                    constraints, //! Pass the constraints to the Tablet layout
              );
            }
            //! If maxWidth is less than 600, use the mobile layout
            else {
              return MobileLayoutScreen(
                constraints:
                    constraints, //! Pass the constraints to the Mobile layout
              );
            }
          },
        ),
      ),
    );
  }
}
