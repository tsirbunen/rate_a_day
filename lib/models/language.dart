library language;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'language.g.dart';

class Language extends EnumClass {
  static const Language EN = _$en;
  static const Language FI = _$fi;

  const Language._(String name) : super(name);

  static BuiltSet<Language> get values => _$languageValues;
  static Language valueOf(String name) => _$languageValueOf(name);

  static Serializer<Language> get serializer => _$languageSerializer;
}
