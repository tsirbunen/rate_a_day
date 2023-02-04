library day_data;

import 'dart:core';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'rating.dart';

part 'day_data.g.dart';

abstract class DayData implements Built<DayData, DayDataBuilder> {
  static const FullType type = FullType(DayData);

  Rating get rating;
  bool get didLearnNew;
  DateTime get date;

  DayData._();
  factory DayData([Function(DayDataBuilder b) updates]) = _$DayData;
  static Serializer<DayData> get serializer => _$dayDataSerializer;
}
