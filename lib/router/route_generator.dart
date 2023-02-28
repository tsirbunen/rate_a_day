import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/pages.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(final RouteSettings settings) {
    Widget page;
    final String? routeName = settings.name;

    switch (routeName) {
      case '/':
      case '/today':
        page = const Today();
        break;
      case '/month':
        page = const Month();
        break;
      case '/info':
        page = const Info();
        break;
      case '/settings':
        page = Settings();
        break;
      default:
        page = Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        );
    }

    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, anotherAnimation, child) {
        animation =
            CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn);

        return SlideTransition(
          position:
              Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
                  .animate(animation),
          child: child,
        );
      },
    );
  }
}
