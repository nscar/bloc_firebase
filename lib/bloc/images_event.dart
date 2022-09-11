part of 'images_bloc.dart';

abstract class ImagesEvent extends Equatable {
  const ImagesEvent();

  @override
  List<Object> get props => [];
}

class ImagesLoadEvent extends ImagesEvent {}

//segunda parte

class AddPostEvent extends ImagesEvent {
  final File image;
  final String description;

  const AddPostEvent(this.image, this.description);
  @override
  List<Object> get props => [image, description];

  @override
  String toString() {
    return 'Inserting posts';
  }
}

//segunda parte

class ImageUpdatedEvent extends ImagesEvent {
  final List<Post> posts;

  const ImageUpdatedEvent(this.posts);
  @override
  List<Object> get props => [posts];
}
