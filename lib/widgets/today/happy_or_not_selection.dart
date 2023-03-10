import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rate_a_day/packages/utils.dart';

class HappyOrNotSelection extends StatelessWidget with Constants {
  HappyOrNotSelection({Key? key}) : super(key: key);

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
    final double iconSize = SizeUtil.evaluationIconSize;
    final ThemeData themeData = Theme.of(context);
    final Color splashColor = StyleUtil.iconSplash(themeData);

    return Material(
      borderRadius: BorderRadius.circular(iconSize),
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.only(left: paddingS, right: paddingS),
        child: InkWell(
          splashColor: splashColor,
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
    return StreamBuilder<Rating>(
      stream: dataBloc.rating,
      builder: (final BuildContext context, AsyncSnapshot<Rating> snapshot) {
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
      },
    );
  }
}
