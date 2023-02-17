import 'package:flutter/material.dart';
import 'package:wallpapers/pages/home/home_page.dart';

import '../../model/wallpaper_model.dart';
import '../detail/detail_page.dart';
import 'routes.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  Route<dynamic> pageRouteSlide(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }

  switch (settings.name) {
    case Routes.home:
      return MaterialPageRoute(
        builder: (context) => const HomePage(),
      );
    default:
      final argument = settings.arguments as WallpaperModel;
      return pageRouteSlide(
        DetailPage(
          wallpaper: argument,
        ),
      );
  }
}
