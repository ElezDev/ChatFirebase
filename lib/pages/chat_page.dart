import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {

  final String userEmail;
    final String userId;

  const ChatPage({super.key, required this.userEmail,  required this.userId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text(widget.userEmail),
      ),
    );
  }
}