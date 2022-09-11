import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String image;
  final String description;
  final String date;
  final String time;
  final String id;

  const Post(this.image, this.description, this.date, this.time, this.id);

  static Post fromSnapshot(DocumentSnapshot snapshot) {
    return Post(snapshot['image'], snapshot['description'], snapshot['date'],
        snapshot['time'], snapshot.id);
  }
}
