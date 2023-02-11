import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rate_a_day/packages/utils.dart';

class HappyOrNotSelection extends StatelessWidget {
  const HappyOrNotSelection({Key? key}) : super(key: key);

  Color _getIconColor(
    final Rating currentRating,
    final ThemeData themeData,
    final Rating ratingType,
  ) {
    if (currentRating == Rating.UNHAPPY && ratingType == Rating.UNHAPPY) {
      return Evaluations.getColor(Evaluation.dissatisfied, themeData);
    } else if (currentRating == Rating.HAPPY && ratingType == Rating.HAPPY) {
      return Evaluations.getColor(Evaluation.satisfied, themeData);
    }
    return Evaluations.getColor(Evaluation.didNotLearn, themeData);
  }

  IconData _getIconData(final Rating ratingType) {
    return ratingType == Rating.HAPPY
        ? Evaluations.getIcon(Evaluation.satisfied)
        : Evaluations.getIcon(Evaluation.dissatisfied);
  }

  Widget _buildSelectButton(final BuildContext context, final Rating ratingType,
      final Rating currentRating, onSelect) {
    final double iconSize = ScreenSizeUtil.evaluationIconSize;
    final ThemeData themeData = Theme.of(context);

    return Material(
      borderRadius: BorderRadius.circular(iconSize),
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(5.0),
        child: InkWell(
          splashColor: themeData.colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(iconSize),
          child: Icon(
            _getIconData(ratingType),
            color: _getIconColor(currentRating, themeData, ratingType),
            size: iconSize,
          ),
          onTap: onSelect,
        ),
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);
    return Container(
      margin: const EdgeInsets.only(top: 5.0),
      child: StreamBuilder<Rating>(
          stream: dataBloc.rating,
          builder:
              (final BuildContext context, AsyncSnapshot<Rating> snapshot) {
            final Rating currentRating =
                snapshot.hasData ? snapshot.data! : Rating.MISSING;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSelectButton(
                  context,
                  Rating.UNHAPPY,
                  currentRating,
                  () => dataBloc.rate(Rating.UNHAPPY),
                ),
                _buildSelectButton(
                  context,
                  Rating.HAPPY,
                  currentRating,
                  () => dataBloc.rate(Rating.HAPPY),
                ),
              ],
            );
          }),
    );
  }
}
