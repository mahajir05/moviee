import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/cores/domain/entities/media.dart';
import 'cores/config/app_router.dart';
import '/cores/services/service_locator.dart';
import 'cores/config/app_strings.dart';
import 'cores/config/app_theme.dart';
import 'features/watchlist/presentation/controllers/watchlist_bloc/watchlist_bloc.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MediaAdapter());
  await Hive.openBox('items');
  ServiceLocator.init();

  runApp(
    BlocProvider<WatchlistBloc>(
      create: (context) => sl<WatchlistBloc>(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,
      theme: getApplicationTheme(),
      routerConfig: AppRouter().router,
    );
  }
}
