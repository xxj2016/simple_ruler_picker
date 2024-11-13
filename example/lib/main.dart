import 'package:flutter/material.dart';
import 'package:simple_ruler_picker/simple_ruler_picker.dart';

void main() {
  runApp(const MyApp());
}

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F8FC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              PickerCard(
                title: 'Your Height',
                height: 180,
                child: SimpleRulerPicker(
                  height: 100,
                  minValue: 0,
                  maxValue: 250,
                  initialValue: 180,
                  onValueChanged: (value) {
                    debugPrint(value.toString());
                  },
                ),
              ),
              PickerCard(
                title: 'Your Weight',
                height: 200,
                child: SimpleRulerPicker(
                  height: 130,
                  minValue: 50,
                  maxValue: 300,
                  initialValue: 100,
                  selectedColor: Colors.blue,
                  lineStroke: 3,
                  longLineHeight: 50,
                  shortLineHeight: 25,
                  scaleItemWidth: 20,
                  lineColor: Colors.grey,
                  onValueChanged: (value) {
                    debugPrint(value.toString());
                  },
                ),
              ),
              PickerCard(
                title: 'Vertical Axis Picker',
                height: 500,
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: SimpleRulerPicker(
                    height: 400,
                    minValue: 50,
                    maxValue: 300,
                    initialValue: 100,
                    selectedColor: Colors.green,
                    lineStroke: 3,
                    longLineHeight: 50,
                    shortLineHeight: 25,
                    scaleItemWidth: 20,
                    scaleLabelSize: 14,
                    scaleLabelWidth: 40,
                    axis: Axis.vertical,
                    lineColor: Colors.grey,
                    onValueChanged: (value) {
                      debugPrint(value.toString());
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Ruler Picker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ExamplePage(),
    );
  }
}

class PickerCard extends StatelessWidget {
  final String title;
  final double height;
  final double? width;
  final Widget child;

  const PickerCard({
    super.key,
    required this.title,
    required this.height,
    this.width,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          child
        ],
      ),
    );
  }
}
