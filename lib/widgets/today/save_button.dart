import 'package:flutter/material.dart';
import 'package:rate_a_day/main.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rate_a_day/packages/pages.dart';
import 'package:rate_a_day/packages/localizations.dart';
import 'package:rate_a_day/packages/utils.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({Key? key}) : super(key: key);

  void _navigateToCalendarPage() {
    final NavigatorState? navigatorState = navigatorKey.currentState;
    if (navigatorState == null) return;
    navigatorState.pushReplacementNamed(Month.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);
    final TextStyle style = StyleUtil.saveButtonText(themeData);

    return Container(
      margin: const EdgeInsets.only(top: 30.0),
      child: StreamBuilder<Status>(
          stream: dataBloc.status,
          builder:
              (final BuildContext context, AsyncSnapshot<Status> snapshot) {
            final Status? status = snapshot.hasData ? snapshot.data : null;

            if (status != Status.DIRTY) return Column();

            return ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  context.translate(Phrase.saveData).toUpperCase(),
                  style: style,
                ),
              ),
              onPressed: () async {
                final bool? success = await dataBloc.saveData();
                if (success == true) _navigateToCalendarPage();
              },
            );
          }),
    );
  }
}
