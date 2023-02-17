import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpapers/theme/theme.dart';

import 'pages/home/home_page.dart';
import 'pages/routes/app_routes.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WallPaper',
      theme: theme,
      onGenerateRoute: onGenerateRoute,
      home: const HomePage(),
    );
  }
}
