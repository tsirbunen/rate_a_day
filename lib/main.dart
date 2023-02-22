import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/localizations.dart';
import 'package:rate_a_day/packages/models.dart';
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
    return Stack(
      children: [
        child ?? Column(),
        Positioned(
          right: ScreenSizeUtil.getMenuContainerRightMargin(context),
          bottom: ScreenSizeUtil.generalMargin,
          child: const ExpandableFloatingMenu(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final SettingsBloc settingsBloc = SettingsBloc();
    // final Translator translator = settingsBloc.translator;
    final DataBloc dataBloc = DataBloc();

    // TODO SET UP iOS LOCALIZATION STUFF!!!
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
              print('snap........ ${snapshot.data}');
              return MaterialApp(
                title: 'app',
                theme: themeData,
                navigatorKey: navigatorKey,
                onGenerateRoute: RouteGenerator.generateRoute,
                builder: _buildPage,
                scaffoldMessengerKey: snackbarKey,
                locale: selectedLocale == null
                    ? const Locale('en')
                    : selectedLocale.countryCode == 'fi'
                        ? const Locale('fi')
                        : const Locale('en'),
                localeResolutionCallback:
                    (Locale? deviceLocale, Iterable<Locale> supportedLocales) {
                  print(
                      'localeResolutionCallback+++++++++++++++++ $selectedLocale');
                  if (selectedLocale != null) {
                    print('asetetaan valittu kieli $selectedLocale');
                    if (selectedLocale.languageCode == 'fi') {
                      return const Locale('fi');
                    } else {
                      return const Locale('en');
                    }
                  }
                  //Pitäisi olla locale, mutta onkin string!!!
                  if (deviceLocale.toString().startsWith('en')) {
                    return const Locale('en');
                  }

                  if (deviceLocale.toString().startsWith('fi')) {
                    return const Locale('fi');
                  }

                  print(deviceLocale); //en_US
                  print(supportedLocales);
                  // return deviceLocale;
                  // Tänne oikea, joka tulee blokista
                  return const Locale('en');
                },
                // supportedLocales: [Locale('en'), Locale('fi')],
                localizationsDelegates: const [
                  CustomLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                // localizationsDelegates: CustomLocalizations.delegate,
                supportedLocales: CustomLocalizations.supportedLocales,
              );
            }),
      ),
    );
  }
}

// extension LocalizedBuildContext on BuildContext {
//   CustomLocalizations get loc => CustomLocalizations.of(this);
// }
