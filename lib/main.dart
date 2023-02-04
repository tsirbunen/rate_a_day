import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/theme.dart';
import 'package:rate_a_day/packages/widgets.dart';
import 'package:rate_a_day/router/route_generator.dart';

Future<void> main() async {
  runApp(const RateADayApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class RateADayApp extends StatelessWidget {
  const RateADayApp({Key? key}) : super(key: key);

  Widget _buildPage(final BuildContext context, final Widget? child) {
    return Stack(
      children: [
        child ?? Column(),
        const Positioned(
          right: 20.0,
          bottom: 20.0,
          child: ExpandableFloatingMenu(),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final DataBloc dataBloc = DataBloc();
    return BlocProvider(
      bloc: dataBloc,
      blocDisposer: (final DataBloc dataBloc) => dataBloc.dispose(),
      child: MaterialApp(
        title: 'app',
        theme: themeData,
        navigatorKey: navigatorKey,
        onGenerateRoute: RouteGenerator.generateRoute,
        builder: _buildPage,
      ),
    );
  }
}
