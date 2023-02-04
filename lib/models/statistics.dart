library statistics;

import 'dart:core';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'statistics.g.dart';

abstract class Statistics implements Built<Statistics, StatisticsBuilder> {
  static const FullType type = FullType(Statistics);

  int get satisfiedCount;
  int get dissatisfiedCount;
  int get didLearnNewCount;

  Statistics._();
  factory Statistics([Function(StatisticsBuilder b) updates]) = _$Statistics;
  static Serializer<Statistics> get serializer => _$statisticsSerializer;
}
