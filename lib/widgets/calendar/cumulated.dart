import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/utils.dart';

class Cumulated extends StatelessWidget with Constants {
  final Evaluation evaluation;
  final int value;
  Cumulated({Key? key, required this.evaluation, required this.value})
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
    final TextStyle style = StyleUtil.cumulatedText(themeData, color);
    final double iconSize = SizeUtil.cumulatedIcon;

    return Container(
      margin: EdgeInsets.only(left: paddingXS, right: paddingXS),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: paddingXS),
            child: Icon(
              iconData,
              color: color,
              size: iconSize,
            ),
          ),
          Text('$value', style: style),
        ],
      ),
    );
  }
}
