import 'package:flutter/foundation.dart';

class Field with ChangeNotifier {
  double min = 0.0;
  double max = 1.0;

  dynamic _value = 0;
  dynamic rValue = 0;

  String label = "";

  Field(this.min, this.max, this._value, this.label) {
    rValue = _value;
  }
  Field.noRange(this._value, this.label) {
    rValue = _value;
  }

  set value(dynamic v) {
    _value = v;
    notifyListeners();
  }

  dynamic get value => _value;

  reset() {
    value = rValue;
  }
}

class EnvelopeSettings with ChangeNotifier {
  final String title = "Envelope";
  // Indicates if a slider panel is visible or not.
  bool _isExpanded = false;

  final Field attack = Field(0.0, 1.0, 0.0, "Attack");
  final Field sustain = Field(0.0, 1.0, 0.0, "Sustain");
  final Field punch = Field(0.0, 1.0, 0.0, "Punch");
  final Field decay = Field(0.0, 1.0, 0.0, "Decay");

  void modify(Field f, dynamic v) {
    f.value = v;
    notifyListeners();
  }

  bool get isExpanded {
    return _isExpanded;
  }

  void expanded() {
    _isExpanded = true;
    notifyListeners();
  }

  void collapsed() {
    _isExpanded = false;
    notifyListeners();
  }
}

class SettingsModel with ChangeNotifier {
  final envelopeSettings = EnvelopeSettings();
}
