import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tflite/tflite.dart';

class Loadimage extends StatefulWidget {
  const Loadimage({super.key});

  @override
  State<Loadimage> createState() => _LoadimageState();
}

class _LoadimageState extends State<Loadimage> {


final ImagePicker picker = ImagePicker();
XFile? image;
File? uploaded_image;
List? outputs;
bool isModelBusy=false;


load_model() async {
  await Tflite.close();
  await Tflite.loadModel(
    model: "assets/mobilenet_v1_1.0_224.tflite",
    labels: "assets/labels.txt",
    numThreads: 1,
  );
}
run_model(File image) async {

  try {
    setState(() {
      isModelBusy = true;
    });

    var prediction = await Tflite.runModelOnImage(
      path: image.path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 2,
      threshold: 0.2,
    );
    setState(() {
      outputs = prediction;
    });
    print(outputs);
  }finally{
    setState(() {
      isModelBusy=false;
    });
  }
}

pickimage() async {
  try {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    setState(() {
      image = pickedImage;
      uploaded_image = File(image!.path);
      run_model(uploaded_image!);
    });
  } catch (e) {
    print("error,$e");
  }
}





// Pick an image.
@override
void initState() {
  pickimage();
  load_model();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() async {
    await Tflite.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isModelBusy
        ? CircularProgressIndicator()
        : uploaded_image == null
        ? Text("No image selected")
        : Image.file(uploaded_image!)




      ),
    )



    ;
  }
}