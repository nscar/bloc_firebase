import 'package:bloc_firebase1/bloc/images_bloc.dart';
import 'package:bloc_firebase1/models/post.dart';
import 'package:bloc_firebase1/ui/zoom_img.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MakeImageGrid extends StatefulWidget {
  const MakeImageGrid({Key? key}) : super(key: key);

  @override
  State<MakeImageGrid> createState() => _HomePageState();
}

class _HomePageState extends State<MakeImageGrid> {
  List<Post> postList = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagesBloc, ImagesState>(
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
          return Container(
            child: postList.isEmpty
                ? const Center(
                    child: Text('No hay posts disponibles'),
                  )
                : GridView.builder(
                    itemCount: postList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      debugPrint('crear grid: $index');
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                            color: Colors.grey[300],
                            child: imageGridItem(postList[index].image, index)),
                      );
                    }),
          );
        }
        return Container();
      },
    );
  }

  Widget imageGridItem(String image, index) {
    return GridTile(
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => ZoomImg(index: index),
          ),
        ),
        child: Hero(
          tag: '$index',
          child: Stack(
            fit: StackFit.expand,
            children: [
                const Icon(Icons.image_rounded, color: Color.fromARGB(255, 189, 189, 189), size: 30),
              //const Center(child: CircularProgressIndicator()),
              Image.network(image, fit: BoxFit.cover, frameBuilder:
                  (context, child, frame, wasSynchronouslyLoaded) {
                return child;
              }, loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
