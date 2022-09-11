import 'package:bloc_firebase1/bloc/images_bloc.dart';
import 'package:bloc_firebase1/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  : ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (_, index) {
                        return postUI(
                            postList[index].image,
                            postList[index].description,
                            postList[index].date,
                            postList[index].time);
                      },
                    ));
        }
        return Container();
      },
    );
  }

  Widget postUI(String image, String description, String date, String time) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
                Text(
                  time,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Image.network(
              image,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              description,
              style: Theme.of(context).textTheme.subtitle2,
            )
          ],
        ),
      ),
    );
  }
}
