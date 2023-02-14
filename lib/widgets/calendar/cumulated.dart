import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/utils.dart';

class Cumulated extends StatelessWidget {
  final Evaluation evaluation;
  final int value;
  const Cumulated({Key? key, required this.evaluation, required this.value})
      : super(key: key);

  Color _getColor(final ThemeData themeData) {
    final Evaluation colorSelector =
        value == 0 ? Evaluation.noEvaluation : evaluation;
    return Evaluations.getColor(colorSelector, themeData);
  }

  @override
  Widget build(
    final BuildContext context,
  ) {
    final ThemeData themeData = Theme.of(context);
    final IconData iconData = Evaluations.getIcon(evaluation);
    final Color color = _getColor(themeData);
    return Container(
      margin: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 5.0),
            child: Icon(
              iconData,
              color: color,
              size: 42,
            ),
          ),
          Text(
            '$value',
            style: themeData.textTheme.headline6?.copyWith(
                color: color, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
