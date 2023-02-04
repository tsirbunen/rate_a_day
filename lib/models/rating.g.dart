// GENERATED CODE - DO NOT MODIFY BY HAND

part of rating;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Rating _$satisfied = const Rating._('HAPPY');
const Rating _$dissatisfied = const Rating._('UNHAPPY');
const Rating _$not_set = const Rating._('MISSING');

Rating _$ratingValueOf(String name) {
  switch (name) {
    case 'HAPPY':
      return _$satisfied;
    case 'UNHAPPY':
      return _$dissatisfied;
    case 'MISSING':
      return _$not_set;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<Rating> _$ratingValues = new BuiltSet<Rating>(const <Rating>[
  _$satisfied,
  _$dissatisfied,
  _$not_set,
]);

Serializer<Rating> _$ratingSerializer = new _$RatingSerializer();

class _$RatingSerializer implements PrimitiveSerializer<Rating> {
  @override
  final Iterable<Type> types = const <Type>[Rating];
  @override
  final String wireName = 'Rating';

  @override
  Object serialize(Serializers serializers, Rating object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  Rating deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Rating.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
