import 'package:flutter/foundation.dart';

extension ExtensionObject on Object {
  String get inString => describeEnum(this);
}
