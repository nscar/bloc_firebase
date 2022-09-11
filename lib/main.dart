import 'package:bloc_firebase1/bloc/images_bloc.dart';
import 'package:bloc_firebase1/image_upload.dart';
import 'package:bloc_firebase1/repository/image_repository.dart';
import 'package:bloc_firebase1/ui/home.dart';
//import 'package:bloc_firebase1/ui/zoom_img.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//primera parte

/* Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ImageApp());
}

class ImageApp extends StatelessWidget {
  const ImageApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image App Firebase',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Home(),
    );
  }
} */

//segunda parte
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ImageApp());
}

class ImageApp extends StatelessWidget {
  const ImageApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImagesBloc>(
      create: (context) => ImagesBloc(imageRepository: ImageRepository())
        ..add(ImagesLoadEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Image App Firebase',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        routes: {
          '/': (context) => Home(),
          //'/zoomImg': (context) => ZoomImg(index),
          '/addPost': (context) {
            return ImageUpload(
              //Creamos una funcion que recibiera 2 parametros, esta funcion la hemos llamado como un parametro en la clase ImageUpload
              onSave: ((image, description) =>
                  BlocProvider.of<ImagesBloc>(context)
                      .add(AddPostEvent(image, description))),
            );
          }
        },
      ),
    );
  }
}
