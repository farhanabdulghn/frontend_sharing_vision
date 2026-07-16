import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_sharing_vision/app_theme.dart';
import 'package:frontend_sharing_vision/config/env.dart';
import 'package:frontend_sharing_vision/pages/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const environment = String.fromEnvironment(
    'environment',
    defaultValue: kReleaseMode ? Environment.dev : Environment.prod,
  );

  Environment.initConfig(environment);
  runApp(ProviderScope(retry: (retryCount, error) => null, child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(context),
      home: MainScreen(),
    );
  }
}
