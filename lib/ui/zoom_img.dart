import 'package:bloc_firebase1/bloc/images_bloc.dart';
import 'package:bloc_firebase1/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ZoomImg extends StatelessWidget {
  final int index;
  ZoomImg({Key? key, required this.index}) : super(key: key);

  List<Post> postList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galería de Fotos'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<ImagesBloc, ImagesState>(
            builder: (context, state) {
              if (state is ImagesInitialLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ImagesNotLoadedState) {
                return Center(
                  child: Column(
                    children: const [
                      Icon(Icons.error),
                      Text('No se pudieron cargar los posts'),
                    ],
                  ),
                );
              }
              if (state is ImagesLoadedState) {
                postList = state.posts;
                return postList.isEmpty
                    ? const Center(
                        child: Text('No hay posts disponibles'),
                      )
                    : Flexible(
                        child: Hero(
                            tag: '$index',
                            child: Image.network(
                              postList[index].image,
                              fit: BoxFit.contain,
                            )),
                      );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
