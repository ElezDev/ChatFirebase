import 'package:chatapp/components/chat_bubble.dart';
import 'package:chatapp/components/texfielMessage.dart';
import 'package:chatapp/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String userEmail;
  final String userId;

  const ChatPage({super.key, required this.userEmail, required this.userId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void senderMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessges(widget.userId, _messageController.text);
      //clear controller
      _messageController.clear();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userEmail),
      ),
      body: Column(
        children: [
          //mesages
          Expanded(
            child: _buildMessagesList(),
          ),
          //userImput
          const Divider(),
          _buildMessageInput(),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }

//mesage list
  Widget _buildMessagesList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
        widget.userId,
        _firebaseAuth.currentUser!.uid,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("loading..");
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessagesItem(document))
              .toList(),
        );
      },
    );
  }

  //mesage ietem
  Widget _buildMessagesItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    //alinear mensajes
    var alingment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      alignment: alingment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          mainAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          children: [
            Text(data['senderEmail']),
            const SizedBox(
              height: 6,
            ),
            ChatBubble(message: data['message'])
          ],
        ),
      ),
    );
  }
Widget _buildMessageInput() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Row(
      children: [
        Expanded(
          child: TextFieldMessage(
            controller: _messageController,
            hintText: 'Enviar mensaje',
            obscureText: false,
          ),
        ),
        GestureDetector(
          onTap: senderMessage,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              'assets/images/enviar.png', // Reemplaza con la ruta de tu imagen
              width: 40,
              height: 40,
            ),
          ),
        ),
      ],
    ),
  );
}
}
