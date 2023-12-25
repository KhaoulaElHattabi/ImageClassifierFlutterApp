

import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class WastedDataClassifier extends StatefulWidget {
  const WastedDataClassifier({super.key});

  @override
  State<WastedDataClassifier> createState() => _WastedDataClassifierState();
}

class _WastedDataClassifierState extends State<WastedDataClassifier> {
  late File pickedImage;
  late List prediction;
  bool selectedImage = false;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      runModel(image);
    }
  }

  loadModel() async {
    Tflite.close();
    String res;
    res = (await Tflite.loadModel(
      model: "assets/mobilenet_v1_1.0_224.tflite",
      labels: "assets/labels.txt",
    ))!;
    print("Models loading status: $res");
  }

  runModel(File image) async {
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      prediction = recognitions!;
      pickedImage = image;
      selectedImage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Classification'),
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: pickImage,
              child: const Text('Pick an Image',
                  style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            // Display the picked image
            if (selectedImage && pickedImage != null)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.file(
                    pickedImage,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            // Display the classification results
            if (selectedImage && prediction.isNotEmpty)
              Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  title: Text(
                    'Result : This is a ${prediction[0]['label']}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ImageClassificationPage(),
  ));
}
