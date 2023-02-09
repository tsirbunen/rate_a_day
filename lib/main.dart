import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/theme.dart';
import 'package:rate_a_day/packages/widgets.dart';
import 'package:rate_a_day/router/route_generator.dart';
import 'package:rate_a_day/packages/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const RateADayApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class RateADayApp extends StatelessWidget {
  const RateADayApp({Key? key}) : super(key: key);

  Widget _buildPage(final BuildContext context, final Widget? child) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        child ?? Column(),
        Positioned(
          right: ScreenSizeUtil.getMenuContainerRightMargin(screenWidth),
          bottom: ScreenSizeUtil.generalMargin,
          child: const ExpandableFloatingMenu(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final SettingsBloc settingsBloc = SettingsBloc();
    final DataBloc dataBloc = DataBloc();

    return BlocProvider(
      bloc: settingsBloc,
      blocDisposer: (final SettingsBloc settingsBloc) => settingsBloc.dispose(),
      child: BlocProvider(
        bloc: dataBloc,
        blocDisposer: (final DataBloc dataBloc) => dataBloc.dispose(),
        child: MaterialApp(
          title: 'app',
          theme: themeData,
          navigatorKey: navigatorKey,
          onGenerateRoute: RouteGenerator.generateRoute,
          builder: _buildPage,
          scaffoldMessengerKey: snackbarKey,
        ),
      ),
    );
  }
}
