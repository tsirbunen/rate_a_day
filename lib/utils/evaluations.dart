import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/utils.dart';

enum Evaluation { satisfied, dissatisfied, didNotLearn, didLearn, noEvaluation }

class Evaluations {
  static IconData getIcon(final Evaluation evaluation) {
    switch (evaluation) {
      case Evaluation.satisfied:
        return Icons.sentiment_satisfied_alt;
      case Evaluation.dissatisfied:
        return Icons.sentiment_very_dissatisfied;
      case Evaluation.didLearn:
        return Icons.rocket_launch;
      case Evaluation.didNotLearn:
        return Icons.rocket;
      case Evaluation.noEvaluation:
        return Icons.radio_button_unchecked;
      default:
        return Icons.sentiment_satisfied_alt;
    }
  }

  static Color getColor(
      final Evaluation evaluation, final ThemeData themeData) {
    switch (evaluation) {
      case Evaluation.satisfied:
        return StyleUtil.happy(themeData);
      case Evaluation.dissatisfied:
        return StyleUtil.unhappy(themeData);
      case Evaluation.didLearn:
        return StyleUtil.didLearn(themeData);
      default:
        return StyleUtil.notSelected(themeData);
    }
  }
}
