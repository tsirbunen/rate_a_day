library rating;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'rating.g.dart';

class Rating extends EnumClass {
  static const Rating HAPPY = _$satisfied;
  static const Rating UNHAPPY = _$dissatisfied;
  static const Rating MISSING = _$not_set;

  const Rating._(String name) : super(name);

  static BuiltSet<Rating> get values => _$ratingValues;
  static Rating valueOf(String name) => _$ratingValueOf(name);

  static Serializer<Rating> get serializer => _$ratingSerializer;
}
