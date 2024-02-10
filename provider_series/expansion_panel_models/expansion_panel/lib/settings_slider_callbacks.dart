import 'package:expansion_panel/custom_slider_thumb_rect.dart';
import 'package:flutter/material.dart';

typedef SliderSetFieldValue = void Function(dynamic v);
typedef SliderGetFieldValue = dynamic Function();

class SettingsSlider extends StatefulWidget {
  const SettingsSlider({
    Key? key,
    required this.min,
    required this.max,
    required this.title,
    required this.setFieldValue,
    required this.getFieldValue,
  }) : super(key: key);

  final SliderSetFieldValue setFieldValue;
  final SliderGetFieldValue getFieldValue;
  final double min, max;
  final String title;

  @override
  SliderState createState() => SliderState();
}

class SliderState extends State<SettingsSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.orange,
                inactiveTrackColor: Colors.amberAccent,
                trackShape: const RectangularSliderTrackShape(),
                trackHeight: 5.0,
                thumbColor: Colors.white,
                thumbShape: CustomSliderThumbRect(
                  thumbRadius: 15.0,
                  thumbHeight: 25,
                  min: widget.min,
                  max: widget.max,
                  sliderValue: widget.getFieldValue(),
                ),
                overlayColor: Colors.blue.withAlpha(32),
                overlayShape:
                    const RoundSliderOverlayShape(overlayRadius: 28.0),
              ),
              // Wrap in Consumer<Field>
              child: Slider(
                value: widget.getFieldValue(),
                min: widget.min,
                max: widget.max,
                divisions: 200,
                onChanged: (value) {
                  setState(() {
                    // data.value = value;
                    widget.setFieldValue(value);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
