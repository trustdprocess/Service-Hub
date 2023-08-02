import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverName;

  const ChatPage({
    Key? key,
    required this.receiverEmail,
    required this.receiverName,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('messages').add({
        'senderEmail': firebaseAuth.currentUser!.email,
        'receiverEmail': widget.receiverEmail,
        'message': messageController.text,
        'timestamp': Timestamp.now(),
      });
      messageController.clear();
    }
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    bool isSentByCurrentUser =
        data['senderEmail'] == firebaseAuth.currentUser!.email;

    Color textColor = isSentByCurrentUser ? Colors.black : Colors.white;

    var alignment =
        isSentByCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isSentByCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisAlignment:
            isSentByCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Text(
            data['senderEmail'],
            style: TextStyle(color: textColor),
          ),
          Text(
            data['message'],
            style: TextStyle(color: textColor),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('messages')
          .where('chatUsers', arrayContains: firebaseAuth.currentUser!.email)
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading..');
        }

        return ListView(
          reverse: true,
          children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
        );
      },
    );
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              obscureText: false,
              controller: messageController,
              decoration: InputDecoration(
                hintText: 'Enter Message',
              ),
            ),
          ),
        ),
        IconButton(onPressed: sendMessage, icon: Icon(Icons.arrow_upward))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverName)),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }
}
