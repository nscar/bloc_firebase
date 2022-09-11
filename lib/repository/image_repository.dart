import 'dart:io';
import 'package:bloc_firebase1/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

//primera parte obteniendo data de firebase

/* class ImageRepository {
  final dbref = FirebaseFirestore.instance;

  Stream<List<Post>> getPost() {
    return dbref.collection('dataimages').snapshots().map((snapshot) {
      return snapshot.docs.map((e) => Post.fromSnapshot(e)).toList();
    });
  }
} */

//segunda parte
class ImageRepository {
  final dbref = FirebaseFirestore.instance.collection('dataimages');

  Stream<List<Post>> getPost() {
    return dbref.snapshots().map((snapshot) {
      return snapshot.docs.map((e) => Post.fromSnapshot(e)).toList();
    });
  }

  Future<void> addPost(File image, String description) async {
    final Reference postImageRef =
        FirebaseStorage.instance.ref().child('Post images');

    var timeKey = DateTime.now();
    final UploadTask uploadTask =
        postImageRef.child(timeKey.toString() + '.jpg').putFile(image);
//Para obtener la url de la imagen para pasarla a la bd.

    var imageURL = await (await uploadTask).ref.getDownloadURL();
    var url = imageURL.toString();

    //Almacena post

    var formatDate = DateFormat('MMM d, yyy');
    var formatTime = DateFormat('EEEE, hh:mm aaa');
    String date = formatDate.format(timeKey);
    String time = formatTime.format(timeKey);

    dbref.doc().set(
        {'image': url, 'description': description, 'date': date, 'time': time});
  }
}
