import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Background Removal App',
      home: BackgroundRemovalScreen(selectedDirectory: '/storage/emulated/0/Download/FrameExtracted/45'),
    );
  }
}

class BackgroundRemovalScreen extends StatefulWidget {
  final String selectedDirectory;

  BackgroundRemovalScreen({required this.selectedDirectory});

  @override
  _BackgroundRemovalScreenState createState() => _BackgroundRemovalScreenState();
}

class _BackgroundRemovalScreenState extends State<BackgroundRemovalScreen> {
  bool _processing = false;

void _processImages() async {
  setState(() {
    _processing = true;
  });

  List<File> images = _getImagesFromDirectory();
  for (int i = 0; i < images.length; i++) {
    File selectedImage = images[i];

    // Prepare the request to send the image to the Flask server
    var request = http.MultipartRequest('POST', Uri.parse('https://74a4-2407-d000-d-e98b-9476-1615-3dc6-e658.ngrok-free.app/process_images'));
    request.files.add(await http.MultipartFile.fromPath('image', selectedImage.path));

    // Send the request and get the response
    var response = await request.send();

    // Read the response stream as bytes
    Uint8List bytes = await response.stream.toBytes();

    // Overwrite the input image with the processed image
    await File(selectedImage.path).writeAsBytes(bytes);
  }

  setState(() {
    _processing = false;
  });
}

  List<File> _getImagesFromDirectory() {
    List<File> images = [];
    Directory directory = Directory(widget.selectedDirectory);
    List<FileSystemEntity> files = directory.listSync();
    for (int i = 0; i < files.length; i++) {
      if (files[i] is File) {
        images.add(files[i] as File);
      }
    }
    return images;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Background Removal')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Selected Directory: ${widget.selectedDirectory}'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _processing ? null : _processImages,
                child: Text('Process Images'),
              ),
              SizedBox(height: 20),
              if (_processing) CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
