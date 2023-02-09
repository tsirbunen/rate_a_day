library status;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'status.g.dart';

class Status extends EnumClass {
  static const Status SAVING = _$saving;
  static const Status LOADING = _$loading;
  static const Status READY = _$ready;

  const Status._(String name) : super(name);

  static BuiltSet<Status> get values => _$statusValues;
  static Status valueOf(String name) => _$statusValueOf(name);

  static Serializer<Status> get serializer => _$statusSerializer;
}
