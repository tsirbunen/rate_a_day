import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/localizations.dart';
import 'package:rate_a_day/packages/theme.dart';
import 'package:rate_a_day/packages/widgets.dart';
import 'package:rate_a_day/router/route_generator.dart';
import 'package:rate_a_day/packages/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(RateADayApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class RateADayApp extends StatelessWidget with Constants {
  RateADayApp({Key? key}) : super(key: key);

  Widget _buildPage(final BuildContext context, final Widget? child) {
    return Stack(
      children: [
        child ?? Column(),
        Positioned(
          right: SizeUtil.getMenuContainerRightMargin(context),
          bottom: mediumMargin,
          child: const ExpandableFloatingMenu(),
        ),
      ],
    );
  }

  Locale _resolveLocale(
    List<Locale>? locales,
    Iterable<Locale> supportedLocales,
    final Locale? selectedLocale,
  ) {
    String? code;
    if (selectedLocale == null) {
      code = locales != null && locales.isNotEmpty
          ? locales[0].toString().substring(0, 2)
          : supportedLocales.toList()[0].toString().substring(0, 2);
    } else {
      code = selectedLocale.languageCode;
    }

    switch (code) {
      case 'fi':
        return const Locale('fi');
      default:
        return const Locale('en');
    }
  }

  @override
  Widget build(BuildContext context) {
    final SettingsBloc settingsBloc = SettingsBloc();
    final DataBloc dataBloc = DataBloc();

    // TODO: SET UP iOS LOCALIZATION STUFF!!!
    return BlocProvider(
      bloc: settingsBloc,
      blocDisposer: (final SettingsBloc settingsBloc) => settingsBloc.dispose(),
      child: BlocProvider(
        bloc: dataBloc,
        blocDisposer: (final DataBloc dataBloc) => dataBloc.dispose(),
        child: StreamBuilder<Locale?>(
            stream: settingsBloc.locale,
            builder: (final BuildContext context,
                final AsyncSnapshot<Locale?> snapshot) {
              final Locale? selectedLocale =
                  snapshot.hasData ? snapshot.data : null;
              if (selectedLocale != null) dataBloc.setNewLocale(selectedLocale);

              return MaterialApp(
                title: 'app',
                theme: themeData,
                navigatorKey: navigatorKey,
                onGenerateRoute: RouteGenerator.generateRoute,
                builder: _buildPage,
                scaffoldMessengerKey: snackbarKey,
                locale: selectedLocale,
                localeListResolutionCallback:
                    (List<Locale>? locales, Iterable<Locale> supportedLocales) {
                  return _resolveLocale(
                      locales, supportedLocales, selectedLocale);
                },
                localizationsDelegates: const [
                  CustomLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: CustomLocalizations.supportedLocales,
              );
            }),
      ),
    );
  }
}
