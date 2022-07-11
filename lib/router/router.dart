import 'package:flutter/material.dart';
import 'package:obu_connector/home/home.dart';

class AppRouter {
  Route? onGenerateRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const HomePageBody(),
        );
      // case '/LoginPage':
      //   return MaterialPageRoute(
      //     builder: (_) => const LoginPage(),
      //   );
      // case '/AlbumDetailedPage':
      //   final args = settings.arguments as AlbumDetailedPage;
      //   return MaterialPageRoute(
      //     builder: (_) => AlbumDetailedPage(args.albumData),
      //   );

      default:
        return null;
    }
  }
}
