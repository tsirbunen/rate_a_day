import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/utils.dart';

class DidLearnToggle extends StatelessWidget {
  const DidLearnToggle({Key? key}) : super(key: key);

  Color _getIconColor(final bool didLearn, final ThemeData themeData) {
    return didLearn
        ? Evaluations.getColor(Evaluation.didLearn, themeData)
        : Evaluations.getColor(Evaluation.didNotLearn, themeData);
  }

  IconData _getIconData(final bool didLearn) {
    return didLearn
        ? Evaluations.getIcon(Evaluation.didLearn)
        : Evaluations.getIcon(Evaluation.didNotLearn);
  }

  @override
  Widget build(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);
    final double iconSize = SizeUtil.evaluationIconSize;

    return StreamBuilder<bool>(
      stream: dataBloc.didLearnNew,
      builder: (final BuildContext context, AsyncSnapshot<bool> snapshot) {
        final bool didLearn = snapshot.hasData ? snapshot.data! : false;

        return Material(
          borderRadius: BorderRadius.circular(iconSize),
          color: Colors.transparent,
          child: InkWell(
            splashColor: themeData.colorScheme.background,
            borderRadius: BorderRadius.circular(iconSize),
            child: Icon(
              _getIconData(didLearn),
              color: _getIconColor(didLearn, themeData),
              size: iconSize,
            ),
            onTap: () => dataBloc.toggleDidLearn(!didLearn),
          ),
        );
      },
    );
  }
}
