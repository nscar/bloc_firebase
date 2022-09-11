import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

typedef OnSaveCallBack = Function(File image, String description);

class ImageUpload extends StatefulWidget {
  const ImageUpload({Key? key, required this.onSave}) : super(key: key);
  final OnSaveCallBack onSave;

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File? sampleImage;
  late String description;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload'),
        centerTitle: true,
      ),
      body: Center(
        child: sampleImage == null
            ? const Text('Select an image')
            : enabledUpload(),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: getImage,
          tooltip: 'Add image',
          child: const Icon(
            Icons.add_a_photo,
          ),
        ),
    );
  }

  Future getImage() async {
    var tempImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (tempImage != null) {
        sampleImage = File(tempImage.path);
      } else {
        return;
      }
    });
  }

  Widget enabledUpload() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Image.file(
                sampleImage!,
                height: 300,
                width: 600,
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  return value!.isEmpty ? 'Description is required' : null;
                },
                onSaved: (value) {
                  description = value!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                child: const Text('Add a new post'),
                onPressed: uploadPost,
              )
            ],
          ),
        ),
      ),
    );
  }

  void uploadPost() async {
    if (validateAndSave()) {
      widget.onSave(sampleImage!, description);
      Navigator.pop(context);
    }
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
