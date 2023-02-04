// GENERATED CODE - DO NOT MODIFY BY HAND

part of statistics;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Statistics> _$statisticsSerializer = new _$StatisticsSerializer();

class _$StatisticsSerializer implements StructuredSerializer<Statistics> {
  @override
  final Iterable<Type> types = const [Statistics, _$Statistics];
  @override
  final String wireName = 'Statistics';

  @override
  Iterable<Object?> serialize(Serializers serializers, Statistics object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'satisfiedCount',
      serializers.serialize(object.satisfiedCount,
          specifiedType: const FullType(int)),
      'dissatisfiedCount',
      serializers.serialize(object.dissatisfiedCount,
          specifiedType: const FullType(int)),
      'didLearnNewCount',
      serializers.serialize(object.didLearnNewCount,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  Statistics deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new StatisticsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'satisfiedCount':
          result.satisfiedCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'dissatisfiedCount':
          result.dissatisfiedCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'didLearnNewCount':
          result.didLearnNewCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$Statistics extends Statistics {
  @override
  final int satisfiedCount;
  @override
  final int dissatisfiedCount;
  @override
  final int didLearnNewCount;

  factory _$Statistics([void Function(StatisticsBuilder)? updates]) =>
      (new StatisticsBuilder()..update(updates)).build();

  _$Statistics._(
      {required this.satisfiedCount,
      required this.dissatisfiedCount,
      required this.didLearnNewCount})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        satisfiedCount, 'Statistics', 'satisfiedCount');
    BuiltValueNullFieldError.checkNotNull(
        dissatisfiedCount, 'Statistics', 'dissatisfiedCount');
    BuiltValueNullFieldError.checkNotNull(
        didLearnNewCount, 'Statistics', 'didLearnNewCount');
  }

  @override
  Statistics rebuild(void Function(StatisticsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StatisticsBuilder toBuilder() => new StatisticsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Statistics &&
        satisfiedCount == other.satisfiedCount &&
        dissatisfiedCount == other.dissatisfiedCount &&
        didLearnNewCount == other.didLearnNewCount;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, satisfiedCount.hashCode), dissatisfiedCount.hashCode),
        didLearnNewCount.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Statistics')
          ..add('satisfiedCount', satisfiedCount)
          ..add('dissatisfiedCount', dissatisfiedCount)
          ..add('didLearnNewCount', didLearnNewCount))
        .toString();
  }
}

class StatisticsBuilder implements Builder<Statistics, StatisticsBuilder> {
  _$Statistics? _$v;

  int? _satisfiedCount;
  int? get satisfiedCount => _$this._satisfiedCount;
  set satisfiedCount(int? satisfiedCount) =>
      _$this._satisfiedCount = satisfiedCount;

  int? _dissatisfiedCount;
  int? get dissatisfiedCount => _$this._dissatisfiedCount;
  set dissatisfiedCount(int? dissatisfiedCount) =>
      _$this._dissatisfiedCount = dissatisfiedCount;

  int? _didLearnNewCount;
  int? get didLearnNewCount => _$this._didLearnNewCount;
  set didLearnNewCount(int? didLearnNewCount) =>
      _$this._didLearnNewCount = didLearnNewCount;

  StatisticsBuilder();

  StatisticsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _satisfiedCount = $v.satisfiedCount;
      _dissatisfiedCount = $v.dissatisfiedCount;
      _didLearnNewCount = $v.didLearnNewCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Statistics other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Statistics;
  }

  @override
  void update(void Function(StatisticsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Statistics build() {
    final _$result = _$v ??
        new _$Statistics._(
            satisfiedCount: BuiltValueNullFieldError.checkNotNull(
                satisfiedCount, 'Statistics', 'satisfiedCount'),
            dissatisfiedCount: BuiltValueNullFieldError.checkNotNull(
                dissatisfiedCount, 'Statistics', 'dissatisfiedCount'),
            didLearnNewCount: BuiltValueNullFieldError.checkNotNull(
                didLearnNewCount, 'Statistics', 'didLearnNewCount'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
