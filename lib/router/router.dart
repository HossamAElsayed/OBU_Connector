import 'package:flutter/material.dart';
import 'package:obu_connector/device/device_manager.dart';
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

      case '/DeviceManagerScreen':
        final args = settings.arguments as DeviceManagerScreen;
        return MaterialPageRoute(
          builder: (_) => DeviceManagerScreen(name: args.name),
        );

      // case '/DeviceManagerScreen':
      //   return MaterialPageRoute(
      //     builder: (_) => DeviceManagerScreen(),
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
