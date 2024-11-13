<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# Simple Ruler Picker

`SimpleRulerPicker` is a customizable ruler-style number picker for Flutter, allowing users to scroll through and select a number between a minimum and maximum value.

## Features

- **Scrollable Number Picker**: Allows users to scroll through a range of numbers, from `minValue` to `maxValue`.
- **Customizable Scale**: You can adjust the size of scale labels, the width between scale items, and the heights of the ruler lines.

## Preview

| Portrait                                                                      | Landscape                                                                                |
| ----------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| ![demo](https://github.com/yujune/simple_ruler_picker/raw/main/demo/demo.gif) | ![demo](https://github.com/yujune/simple_ruler_picker/raw/main/demo/demo_horizontal.gif) |

## Getting started

### Installation

Add `simple_ruler_picker` to your project's `pubspec.yaml` file:

```yaml
dependencies:
  simple_ruler_picker: ^0.0.4
```

Or

```
flutter pub add simple_ruler_picker
```

## Usage

```dart
SimpleRulerPicker(
  minValue: 0,
  maxValue: 100,
  initialValue: 50,
  onValueChanged: (value) {
    print("Selected value: $value");
  },
  scaleLabelSize: 16,
  scaleBottomPadding: 8,
  scaleItemWidth: 12,
  longLineHeight: 30,
  shortLineHeight: 15,
  lineColor: Colors.black,
  selectedColor: Colors.blue,
  labelColor: Colors.black,
  lineStroke: 3,
  height: 120,
)

```

## Properties

| Property             | Type                | Default         | Description                                                                                            | Example                                   |
| -------------------- | ------------------- | --------------- | ------------------------------------------------------------------------------------------------------ | ----------------------------------------- |
| `minValue`           | `int`               | 0               | The minimum value that can be selected.                                                                | `minValue: 0`                             |
| `maxValue`           | `int`               | 200             | The maximum value that can be selected.                                                                | `maxValue: 100`                           |
| `initialValue`       | `int`               | 100             | The initial value displayed when the picker is first shown. Must be between `minValue` and `maxValue`. | `initialValue: 50`                        |
| `scaleLabelSize`     | `double`            | `14`            | The size of the text for the scale labels.                                                             | `scaleLabelSize: 16`                      |
| `scaleLabelWidth`    | `double`            | `40`            | The width of the text for the scale labels when axis is vertical.                                      | `scaleLabelWidth: 40`                     |
| `scaleBottomPadding` | `double`            | `6`             | Padding below the scale labels, creating space between the labels and the bottom of the picker.        | `scaleBottomPadding: 8`                   |
| `scaleItemWidth`     | `int`               | `10`            | The width of each scale item (i.e., the distance between the lines on the ruler).                      | `scaleItemWidth: 15`                      |
| `onValueChanged`     | `ValueChanged<int>` | null            | Callback triggered whenever the selected value changes.                                                | `onValueChanged: (value) => print(value)` |
| `longLineHeight`     | `double`            | `24`            | Height of the long lines in the ruler (typically for major units).                                     | `longLineHeight: 30`                      |
| `shortLineHeight`    | `double`            | `12`            | Height of the short lines in the ruler (typically for minor units).                                    | `shortLineHeight: 15`                     |
| `lineColor`          | `Color`             | `Colors.grey`   | Color of the ruler's lines (both long and short).                                                      | `lineColor: Colors.black`                 |
| `selectedColor`      | `Color`             | `Colors.orange` | Color of the selected item on the ruler.                                                               | `selectedColor: Colors.blue`              |
| `labelColor`         | `Color`             | `Colors.grey`   | Color of the scale labels.                                                                             | `labelColor: Colors.black`                |
| `lineStroke`         | `double`            | `2`             | The thickness (stroke width) of the ruler's lines.                                                     | `lineStroke: 3`                           |
| `height`             | `double`            | `100`           | The overall height of the ruler picker.                                                                | `height: 120`                             |

## Additional information

### Contributing

We welcome contributions! If you want to improve the `SimpleRulerPicker` or add more features, feel free to fork the repository and submit a pull request.

### Filing Issues

Found a bug or need an enhancement? Open an issue on our GitHub repository [here](https://github.com/yujune/simple_ruler_picker/issues).
