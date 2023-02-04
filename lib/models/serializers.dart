library serializers;

import 'dart:core';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:rate_a_day/packages/models.dart';

part 'serializers.g.dart';

@SerializersFor(<Type>[DayData, Rating])
final Serializers serializers = (_$serializers.toBuilder()
      ..addPlugin(StandardJsonPlugin())
      ..addBuilderFactory(
          const FullType(BuiltList, <FullType>[FullType(DayData)]),
          () => ListBuilder<DayData>()))
    .build();
