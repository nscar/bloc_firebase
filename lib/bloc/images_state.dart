part of 'images_bloc.dart';

abstract class ImagesState extends Equatable {
  const ImagesState();

  @override
  List<Object> get props => [];
}

// estados de images
// 1 -> Cargando images
// 2 -> Se han cargado las images
// 3 -> No se cargaron las images

class ImagesInitialLoadingState extends ImagesState {
  @override
  String toString() => 'Images loading';
}

class ImagesLoadedState extends ImagesState {
  final List<Post> posts;

  const ImagesLoadedState(this.posts);

  @override
  List<Object> get props => [posts];

  @override
  String toString() => 'Images loaded';
}

class ImagesNotLoadedState extends ImagesState {
  @override
  String toString() => 'Images not loaded';
}



