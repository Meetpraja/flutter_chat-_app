import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/theams/theme_provider.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {super.key, required this.message, required this.isCurrentUser});
  final String message;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser
            ? (isDarkMode ? Colors.green : Colors.grey.shade800)
            : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade700),
        borderRadius: isCurrentUser
            ? const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20))
            : const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight : Radius.circular(20))
      ),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
      child: Text(
        message,
        style: TextStyle(
          fontSize: 14,
          color: isCurrentUser
              ? Colors.white
              : (isDarkMode ? Colors.white : Colors.white),
        ),
      ),
    );
  }
}
