import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tatsam/routing/router.dart';

import 'bloc/tatsam_bloc.dart';
import 'bloc_observer.dart';
import 'routing/route_paths.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.openBox('countries');

  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TatsamBloc(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tatsam',
        onGenerateRoute: generateRoutes,
        initialRoute: RoutePaths.listScreen,
      ),
    );
  }
}
