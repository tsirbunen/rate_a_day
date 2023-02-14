import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rate_a_day/packages/utils.dart';
import 'package:rate_a_day/packages/widgets.dart';

class CalendarStatistics extends StatelessWidget {
  const CalendarStatistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: StreamBuilder<BuiltMap<int, DayData>>(
          stream: dataBloc.monthsData,
          builder: (final BuildContext context,
              AsyncSnapshot<BuiltMap<int, DayData>> snapshot) {
            final BuiltMap<int, DayData> monthsData = snapshot.hasData
                ? snapshot.data!
                : BuiltMap.from(<int, DayData>{});
            final Statistics statistics =
                DayDataOperations.calculateStatistics(monthsData);

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Cumulated(
                    evaluation: Evaluation.satisfied,
                    value: statistics.satisfiedCount),
                Cumulated(
                    evaluation: Evaluation.dissatisfied,
                    value: statistics.dissatisfiedCount),
                Cumulated(
                    evaluation: Evaluation.didLearn,
                    value: statistics.didLearnNewCount),
              ],
            );
          }),
    );
  }
}
