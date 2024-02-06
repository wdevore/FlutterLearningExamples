import 'package:flutter/foundation.dart';

import 'enums.dart';

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

  reset() {
    _value = rValue;
    notifyListeners();
  }

  dynamic get value {
    return _value;
  }

  void changeValue(dynamic nvalue) {
    _value = nvalue;
    debugPrint('Field: $label, Notifying listeners');
    notifyListeners();
  }
}

class EnvelopeSettings {
  final String title = "Envelope";
  // Indicates if a slider panel is visible or not.
  bool _isExpanded = false;
  final Field attack = Field(0.0, 1.0, 0.0, "Attack");
  final Field sustain = Field(0.0, 1.0, 0.0, "Sustain");
  final Field punch = Field(0.0, 1.0, 0.0, "Punch");
  final Field decay = Field(0.0, 1.0, 0.0, "Decay");

  bool get isExpanded {
    return _isExpanded;
  }

  void expand() {
    _isExpanded = true;
    // notifyListeners();
  }

  void collapse() {
    _isExpanded = false;
  }
}

class AppSettings {
  final Field name = Field.noRange("", "Name");
  final Field sfxrFile = Field.noRange("", "Sfxr File");
  final Field waveFile = Field.noRange("", "Wave File");
  final Field destEmail = Field.noRange("", "Destination Email");
  final Field autoplay = Field.noRange(true, "Auto Play");
  final Field sampleRate = Field.noRange(SampleRate.kHz44, "Sample Rate");
  final Field sampleSize = Field.noRange(8, "Sample Size");
  final Field volume = Field.noRange(0.5, "Auto Play");
  final Field generator = Field.noRange(Generator.none, "None");
  final Field wave = Field.noRange(WaveForm.none, "None");
}

class SettingsModel {
  final appSettings = AppSettings();
  final envelopeSettings = EnvelopeSettings();
}
