import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:incident_reporter/imagesPicker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Pictures extends StatelessWidget {
  const Pictures({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      home: ImageCapture(),
    );
  }
}

class ImageCapture extends StatefulWidget {
  const ImageCapture({super.key});

  @override
  State<ImageCapture> createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  final ImagePicker _imagePicker = new ImagePicker();
  String? _imagePath;
  String? _photoPath;
  String? _videoPath;

  Future<void> _pickPhoto() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _photoPath = image.path;
    }
    setState(() {});
  }

  Future<void> _pickVideo() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _videoPath = image.path;
    }
    setState(() {});
  }

  Future<void> _pickImage() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _imagePath = image.path;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
