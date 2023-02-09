// GENERATED CODE - DO NOT MODIFY BY HAND

part of status;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Status _$saving = const Status._('SAVING');
const Status _$loading = const Status._('LOADING');
const Status _$ready = const Status._('READY');

Status _$statusValueOf(String name) {
  switch (name) {
    case 'SAVING':
      return _$saving;
    case 'LOADING':
      return _$loading;
    case 'READY':
      return _$ready;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<Status> _$statusValues = new BuiltSet<Status>(const <Status>[
  _$saving,
  _$loading,
  _$ready,
]);

Serializer<Status> _$statusSerializer = new _$StatusSerializer();

class _$StatusSerializer implements PrimitiveSerializer<Status> {
  @override
  final Iterable<Type> types = const <Type>[Status];
  @override
  final String wireName = 'Status';

  @override
  Object serialize(Serializers serializers, Status object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  Status deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Status.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
