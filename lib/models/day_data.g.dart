// GENERATED CODE - DO NOT MODIFY BY HAND

part of day_data;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DayData> _$dayDataSerializer = new _$DayDataSerializer();

class _$DayDataSerializer implements StructuredSerializer<DayData> {
  @override
  final Iterable<Type> types = const [DayData, _$DayData];
  @override
  final String wireName = 'DayData';

  @override
  Iterable<Object?> serialize(Serializers serializers, DayData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'rating',
      serializers.serialize(object.rating,
          specifiedType: const FullType(Rating)),
      'didLearnNew',
      serializers.serialize(object.didLearnNew,
          specifiedType: const FullType(bool)),
      'date',
      serializers.serialize(object.date,
          specifiedType: const FullType(DateTime)),
    ];

    return result;
  }

  @override
  DayData deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DayDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'rating':
          result.rating = serializers.deserialize(value,
              specifiedType: const FullType(Rating)) as Rating;
          break;
        case 'didLearnNew':
          result.didLearnNew = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'date':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
      }
    }

    return result.build();
  }
}

class _$DayData extends DayData {
  @override
  final Rating rating;
  @override
  final bool didLearnNew;
  @override
  final DateTime date;

  factory _$DayData([void Function(DayDataBuilder)? updates]) =>
      (new DayDataBuilder()..update(updates)).build();

  _$DayData._(
      {required this.rating, required this.didLearnNew, required this.date})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(rating, 'DayData', 'rating');
    BuiltValueNullFieldError.checkNotNull(
        didLearnNew, 'DayData', 'didLearnNew');
    BuiltValueNullFieldError.checkNotNull(date, 'DayData', 'date');
  }

  @override
  DayData rebuild(void Function(DayDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DayDataBuilder toBuilder() => new DayDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DayData &&
        rating == other.rating &&
        didLearnNew == other.didLearnNew &&
        date == other.date;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, rating.hashCode), didLearnNew.hashCode), date.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DayData')
          ..add('rating', rating)
          ..add('didLearnNew', didLearnNew)
          ..add('date', date))
        .toString();
  }
}

class DayDataBuilder implements Builder<DayData, DayDataBuilder> {
  _$DayData? _$v;

  Rating? _rating;
  Rating? get rating => _$this._rating;
  set rating(Rating? rating) => _$this._rating = rating;

  bool? _didLearnNew;
  bool? get didLearnNew => _$this._didLearnNew;
  set didLearnNew(bool? didLearnNew) => _$this._didLearnNew = didLearnNew;

  DateTime? _date;
  DateTime? get date => _$this._date;
  set date(DateTime? date) => _$this._date = date;

  DayDataBuilder();

  DayDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _rating = $v.rating;
      _didLearnNew = $v.didLearnNew;
      _date = $v.date;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DayData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DayData;
  }

  @override
  void update(void Function(DayDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DayData build() {
    final _$result = _$v ??
        new _$DayData._(
            rating: BuiltValueNullFieldError.checkNotNull(
                rating, 'DayData', 'rating'),
            didLearnNew: BuiltValueNullFieldError.checkNotNull(
                didLearnNew, 'DayData', 'didLearnNew'),
            date:
                BuiltValueNullFieldError.checkNotNull(date, 'DayData', 'date'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
