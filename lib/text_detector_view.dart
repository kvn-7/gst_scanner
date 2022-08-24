import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:gst_scanner/text_detector_painter.dart';
import 'package:no_context_navigation/no_context_navigation.dart';

import 'camera_view.dart';

class TextRecognizerView extends StatefulWidget {
  @override
  _TextRecognizerViewState createState() => _TextRecognizerViewState();
}

class _TextRecognizerViewState extends State<TextRecognizerView> {
  final TextRecognizer _textRecognizer = TextRecognizer();
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;

  @override
  void dispose() async {
    _canProcess = false;
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
      title: 'Text Detector',
      customPaint: _customPaint,
      text: _text,
      onImage: (inputImage) {
        processImage(inputImage);
      },
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final recognizedText = await _textRecognizer.processImage(inputImage);
    final iReg = RegExp(
        r'([0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}[Z]{1}[0-9A-Z]{1})');
    var gstno;
    if (iReg.firstMatch(recognizedText.text) != null) {
      gstno = iReg.firstMatch(recognizedText.text)!.group(0).toString();

      if (gstno != 'null') {
        _canProcess = false;

        _textRecognizer.close();
        gstno = gstno.replaceAll('(', '');
        gstno = gstno.replaceAll(')', '');

        navService.pushNamed('/search', args: gstno);
      }
    }

    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
