import 'package:bloc_firebase1/bloc/images_bloc.dart';
import 'package:bloc_firebase1/repository/image_repository.dart';
import 'package:bloc_firebase1/ui/home_fire_page.dart';
//import 'package:bloc_firebase1/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final ImageRepository _imageRepository = ImageRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImagesBloc>(
      create: (context) =>
          ImagesBloc(imageRepository: _imageRepository)..add(ImagesLoadEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: const MakeImageGrid(),
        //segunda parte
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/addPost'),
          child: const Icon(Icons.add),
          tooltip: 'Add post',
        ),
      ),
    );
  }
}
