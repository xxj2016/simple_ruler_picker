library simple_ruler_picker;

import 'package:flutter/material.dart';

/// A widget that displays a ruler-like picker for selecting numeric values.
class SimpleRulerPicker extends StatefulWidget {
  /// The minimum value that can be selected.
  final int minValue;

  /// The maximum value that can be selected.
  final int maxValue;

  /// The initial value displayed when the picker is first shown. Must be between `minValue` and `maxValue`.
  final int initialValue;

  /// The size of the text for the scale labels.
  final double scaleLabelSize;

  /// Padding below the scale labels, creating space between the labels and the bottom of the picker.
  final double scaleBottomPadding;

  /// The width of each scale item (i.e., the distance between the lines on the ruler).
  final int scaleItemWidth;

  /// Callback triggered whenever the selected value changes.
  final ValueChanged<int>? onValueChanged;

  /// Height of the long lines in the ruler (typically for major units).
  final double longLineHeight;

  /// Height of the short lines in the ruler (typically for minor units).
  final double shortLineHeight;

  /// Color of the ruler's lines (both long and short).
  final Color lineColor;

  /// Color of the selected item on the ruler.
  final Color selectedColor;

  /// Color of the scale labels.
  final Color labelColor;

  /// The thickness (stroke width) of the ruler's lines.
  final double lineStroke;

  /// The overall height of the ruler picker.
  final double height;

  /// Creates a [SimpleRulerPicker] widget.
  ///
  /// The [minValue] must be less than or equal to [initialValue],
  /// and [initialValue] must be less than or equal to [maxValue].
  const SimpleRulerPicker({
    super.key,
    this.minValue = 0,
    this.maxValue = 200,
    this.initialValue = 100,
    this.onValueChanged,
    this.scaleLabelSize = 14,
    this.scaleBottomPadding = 6,
    this.scaleItemWidth = 10,
    this.longLineHeight = 24,
    this.shortLineHeight = 12,
    this.lineColor = Colors.grey,
    this.selectedColor = Colors.orange,
    this.labelColor = Colors.grey,
    this.lineStroke = 2,
    this.height = 100,
  }) : assert(
          minValue <= initialValue &&
              initialValue <= maxValue &&
              minValue < maxValue,
        );

  @override
  _SimpleRulerPickerState createState() => _SimpleRulerPickerState();
}

class _SimpleRulerPickerState extends State<SimpleRulerPicker> {
  late ScrollController _scrollController;
  late int _selectedValue;
  bool _isPosFixed = false;

  int getScrolledItemIndex(double scrolledPixels, int itemWidth) {
    return scrolledPixels ~/ itemWidth;
  }

  bool onNotification(ScrollNotification scrollNotification) {
    if (scrollNotification is ScrollEndNotification) {
      final scrollPixels = scrollNotification.metrics.pixels;
      if (!_isPosFixed) {
        final jumpIndex =
            getScrolledItemIndex(scrollPixels, widget.scaleItemWidth);

        final jumpPixels =
            (jumpIndex * widget.scaleItemWidth) + (widget.scaleItemWidth / 2);

        Future.delayed(const Duration(milliseconds: 100)).then((_) {
          _isPosFixed = true;
          _scrollController.jumpTo(
            jumpPixels,
          );
        });
      }
    }
    return true;
  }

  void calculateNewValue(double scrollPixels) {
    final scrollPixels = _scrollController.position.pixels;
    final jumpIndex = getScrolledItemIndex(scrollPixels, widget.scaleItemWidth);
    final jumpValue = jumpIndex + widget.minValue;
    final newValue = jumpValue.clamp(widget.minValue, widget.maxValue);
    if (newValue != _selectedValue) {
      setState(() {
        _selectedValue = newValue.toInt();
      });
      widget.onValueChanged?.call(_selectedValue);
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
    final rangeFromMinValue = widget.initialValue - widget.minValue;

    final initialItemMiddlePixels =
        (rangeFromMinValue * widget.scaleItemWidth) +
            (widget.scaleItemWidth / 2);

    _scrollController = ScrollController(
      initialScrollOffset: initialItemMiddlePixels,
    );

    _scrollController.addListener(() {
      calculateNewValue(_scrollController.position.pixels);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Listener(
            onPointerDown: (event) {
              FocusScope.of(context).requestFocus(FocusNode());
              _isPosFixed = false;
            },
            child: NotificationListener(
              onNotification: onNotification,
              child: LayoutBuilder(
                builder: (context, constraints) => ListView.builder(
                  padding: EdgeInsets.only(
                    left: constraints.maxWidth / 2,
                    right: constraints.maxWidth / 2,
                  ),
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: (widget.maxValue - widget.minValue) + 1,
                  itemBuilder: (context, index) {
                    final int value = widget.minValue + index;
                    return SizedBox(
                      width: widget.scaleItemWidth.toDouble(),
                      child: CustomPaint(
                        painter: _RulerPainter(
                          value: value,
                          selectedValue: _selectedValue,
                          scaleLabelSize: widget.scaleLabelSize,
                          scaleBottomPadding: widget.scaleBottomPadding,
                          longLineHeight: widget.longLineHeight,
                          shortLineHeight: widget.shortLineHeight,
                          lineColor: widget.lineColor,
                          selectedColor: widget.selectedColor,
                          labelColor: widget.labelColor,
                          lineStroke: widget.lineStroke,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _selectedValue.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: widget.selectedColor,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: widget.selectedColor,
                  size: 24,
                ),
                Container(
                  height: widget.longLineHeight,
                  width: 2,
                  color: widget.selectedColor,
                ),
                SizedBox(
                  height: widget.scaleLabelSize + widget.scaleBottomPadding,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RulerPainter extends CustomPainter {
  final int value;
  final int selectedValue;
  final double scaleLabelSize;
  final double scaleBottomPadding;
  final double longLineHeight;
  final double shortLineHeight;
  final Color lineColor;
  final Color selectedColor;
  final Color labelColor;
  final double lineStroke;

  _RulerPainter({
    required this.value,
    required this.selectedValue,
    required this.scaleLabelSize,
    required this.scaleBottomPadding,
    this.longLineHeight = 24,
    this.shortLineHeight = 12,
    this.lineColor = Colors.grey,
    this.selectedColor = Colors.orange,
    this.labelColor = Colors.grey,
    this.lineStroke = 2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Highlight the selected scale in orange, otherwise keep it black/grey
    final Paint paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineStroke;

    // Draw scale line: Long line every 5 cm, short line every 1 cm
    final double lineHeight = value % 5 == 0 ? longLineHeight : shortLineHeight;
    canvas.drawLine(
      Offset(
        size.width / 2,
        size.height - scaleLabelSize - scaleBottomPadding,
      ),
      Offset(
        size.width / 2,
        size.height - lineHeight - scaleLabelSize - scaleBottomPadding,
      ),
      paint,
    );

    // Draw height text for every 10 cm, below the scale line
    if (value % 10 == 0) {
      final TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: '$value',
          style: TextStyle(
            color: value == selectedValue ? selectedColor : labelColor,
            fontSize: scaleLabelSize,
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          size.width / 2 - textPainter.width / 2,
          size.height - scaleLabelSize,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
