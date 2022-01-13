import 'package:flutter/material.dart';
import 'package:tatsam/routing/route_paths.dart';
import 'package:tatsam/screens/favorite_screen.dart';
import 'package:tatsam/screens/list_screen.dart';

Route<dynamic> generateRoutes(RouteSettings settings) {
  return MaterialPageRoute(
    settings: settings,
    builder: (BuildContext context) {
      switch (settings.name) {
        case RoutePaths.listScreen:
          return const ListScreen();

        case RoutePaths.favoriteScreen:
          return const FavoriteScreen();

        default:
          return const ListScreen();
      }
    },
  );
}
