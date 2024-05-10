import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/components/bubble.dart';
import 'package:social_media/components/myslidable.dart';
import 'package:social_media/services/caht/chat_service.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.username,
    required this.receiverUserId,
  });
  final String username;
  final String receiverUserId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserId, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Theme.of(context).colorScheme.background,
        title:
            Text(widget.username, overflow: TextOverflow.ellipsis, maxLines: 1),
      ),
      body: Column(
        children: [
          //messages
          Expanded(child: _messageList()),
          _messageInput(),
        ],
      ),
    );
  }

  //message List
  Widget _messageList() {
    String senderId = _firebaseAuth.currentUser!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(
        widget.receiverUserId,
        senderId,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          const Text('loading..');
        }
        if (snapshot.hasData) {
          return ListView(
            children:
                snapshot.data!.docs.map((docs) => _messageItem(docs)).toList(),
          );
        }
        return Container();
      },
    );
  }

  //message Item
  Widget _messageItem(DocumentSnapshot docs) {
    Map<String, dynamic> data = docs.data() as Map<String, dynamic>;
    bool isCurrentUser =
        data['senderId'] == _firebaseAuth.currentUser!.uid.toString();
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return MySlidable(
      isCurrentUser: isCurrentUser,
      child: Container(
        alignment: alignment,
        child: InkWell(
          onLongPress: () {
            print(data['message']);
          },
          child: ChatBubble(
            message: data['message'],
            isCurrentUser: isCurrentUser,
          ),
        ),
      ),
    );
  }

  //message input
  Widget _messageInput() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 60,
                child: TextField(
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                  controller: _messageController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.inversePrimary),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.inversePrimary),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                    hintText: 'Enter message',
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: sendMessage,
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
