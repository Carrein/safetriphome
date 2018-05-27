import 'package:cloud_firestore/cloud_firestore.dart';
import 'unit.dart';
import 'dart:math';

class Database {
  post(Unit unit) {
    var rng = new Random();
    final DocumentReference postRef = Firestore.instance
        .collection("posts")
        .document(rng.nextInt(10).toString());
    Firestore.instance.runTransaction((Transaction tx) async {
      await tx.set(postRef, <String, dynamic>{
        'content': unit.content,
        'id' : unit.id,
        'timestamp':unit.time,
        });
    });
  }
}
