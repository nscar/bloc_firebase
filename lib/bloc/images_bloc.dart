import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:bloc_firebase1/models/post.dart';
import 'package:bloc_firebase1/repository/image_repository.dart';
import 'package:equatable/equatable.dart';
part 'images_event.dart';
part 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  final ImageRepository _imageRepository;
  //segunda parte
  StreamSubscription? _subscription;
  //fin segunda parte

  ImagesBloc({required ImageRepository imageRepository})
      : _imageRepository = imageRepository,
        super(ImagesInitialLoadingState()) {

    on<ImagesLoadEvent>((event, emit) async {
      await _mapLoadImageToState(emit);
    });
    
//inicio segunda parte
    on<AddPostEvent>((event, emit) async {
      await _mapAddImageToState(event);
    });
    // fin segunda parte
    //inicio segunda parte
    on<ImageUpdatedEvent>((event, emit) async {
      await _mapUpdateImageToState(event, emit);
    });
    // fin segunda parte
  }

  Future<void> _mapLoadImageToState(
    Emitter<ImagesState> emit,
  ) async {
    //segunda parte
    _subscription?.cancel();
    //fin segunda parte
    emit(ImagesInitialLoadingState());
    try {
      //segunda parte
      _subscription = _imageRepository
          .getPost()
          .listen((posts) => add(ImageUpdatedEvent(posts)));
      //fin segunda parte

      // causa de segunda parte eliminada
/*       final List<Post> posts = await _imageRepository.getPost().first;
      emit(ImagesLoadedState(posts)); */
      // fin causa de segunda parte
    } catch (_) {
      emit(ImagesNotLoadedState());
    }
  }

//segunda parte
  Future<void> _mapAddImageToState(event) async {
    _imageRepository.addPost(event.image, event.description);
  }

  Future<void> _mapUpdateImageToState(
      ImageUpdatedEvent event, Emitter<ImagesState> emit) async {
    emit(ImagesLoadedState(event.posts));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
