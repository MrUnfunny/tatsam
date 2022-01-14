import 'package:flutter/material.dart';
import 'package:tatsam/routing/route_paths.dart';
import 'package:tatsam/presentation/screens/favorite_screen.dart';
import 'package:tatsam/presentation/screens/list_screen.dart';

import '../models/country.dart';

Route<dynamic> generateRoutes(RouteSettings settings) {
  return MaterialPageRoute(
    settings: settings,
    builder: (BuildContext context) {
      switch (settings.name) {
        case RoutePaths.listScreen:
          return const ListScreen();

        case RoutePaths.favoriteScreen:
          return FavoriteScreen(
            countries: settings.arguments as List<Country>,
          );

        default:
          return const ListScreen();
      }
    },
  );
}
