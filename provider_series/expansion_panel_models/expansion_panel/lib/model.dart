import 'package:flutter/foundation.dart';

class Field {
  double min = 0.0;
  double max = 1.0;

  dynamic value = 0;
  dynamic rValue = 0;

  String label = "";

  Field(this.min, this.max, this.value, this.label) {
    rValue = value;
  }
  Field.noRange(this.value, this.label) {
    rValue = value;
  }

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

// class EnvelopeSettings {
//   final String title = "Envelope";
//   // Indicates if a slider panel is visible or not.
//   bool _isExpanded = false;

//   bool get isExpanded {
//     // debugPrint('env isExpanded $_isExpanded');
//     return _isExpanded;
//   }

//   void expanded() {
//     _isExpanded = true;
//     // debugPrint('env expanded');
//     // notifyListeners();
//   }

//   void collapsed() {
//     _isExpanded = false;
//     // debugPrint('env collapsed');
//     // notifyListeners();
//   }
// }

// class SettingsModel with ChangeNotifier {
//   final envelopeSettings = EnvelopeSettings();

//   String get title => envelopeSettings.title;
//   bool get isExpanded {
//     debugPrint('env isExpanded ${envelopeSettings._isExpanded}');
//     return envelopeSettings.isExpanded;
//   }

//   void expanded() {
//     envelopeSettings.expanded();
//     debugPrint('env expanded');
//     notifyListeners();
//   }

//   void collapsed() {
//     envelopeSettings.collapsed();
//     debugPrint('env collapsed');
//     notifyListeners();
//   }
// }
