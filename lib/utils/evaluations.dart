import 'package:flutter/material.dart';

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
        return themeData.colorScheme.tertiary;
      case Evaluation.dissatisfied:
        return themeData.colorScheme.error;
      case Evaluation.didLearn:
        return themeData.colorScheme.onTertiary;
      default:
        return themeData.colorScheme.tertiaryContainer;
    }
  }
}
