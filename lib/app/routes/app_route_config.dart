import 'package:flutter/material.dart';
import 'package:galleryapp/app/constants/app_route_constants.dart';
import 'package:galleryapp/meta/screens/error/errorscreen.dart';
import 'package:galleryapp/meta/screens/home/home_screen.dart';
import 'package:galleryapp/meta/screens/listofimages/full_screenimage.dart';
import 'package:go_router/go_router.dart';

class MyAppRoute {
  /// The route configuration.
  final GoRouter router = GoRouter(
    initialLocation:
        '/', //! The initial route or screen that the app should load when it starts
    routes: <RouteBase>[
      GoRoute(
        name: MyAppRouteConstants.homeRouteName,
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        name: MyAppRouteConstants
            .fullScreenimageRouteName, //! Name of the route for identification and navigation purposes
        path:
            '/fullScreenimage/:imageUrl', //! Route path with a dynamic parameter for imageUrl
        builder: (BuildContext context, GoRouterState state) {
          return FullScreenImage(
            imageUrl: state.pathParameters['imageUrl'],
          ); //! Passes the extracted imageUrl from path parameters to the FullScreenImage widget
        },
      ),
    ],
    errorBuilder: (context, state) => ErrorScreen(error: state.error),
  );
}
