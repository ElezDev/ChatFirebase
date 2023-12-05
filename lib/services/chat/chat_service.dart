import 'package:chatapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  //obetenes instancias
  final _firebaseAuth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  //Send mensagge
  Future<void> sendMessges(String reciverId, String message) async {
    //obtener info de user

    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();
    //create mensaje
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      reciverId: reciverId,
      message: message,
      timestamp: timestamp,
    );
    //constructor
    List<String> ids = [currentUserId, reciverId];
    ids.sort();
    //Mesaje a la base

    String chatRommId = ids.join("_");
    await _fireStore
        .collection('chat_rooms')
        .doc(chatRommId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //obtener mensajes
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    //constructor
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false).snapshots();
  }
}
