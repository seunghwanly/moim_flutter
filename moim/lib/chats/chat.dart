import 'package:flutter/material.dart';
import 'package:moim/chats/rooms.dart';
import 'package:moim/chats/search_bar.dart';
import 'package:moim/components/components.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// background
        SizedBox.expand(
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  CColor.lightGreen.color.withOpacity(0.6),
                  CColor.lightGreen.color.withOpacity(0.3),
                  CColor.lightGreen.color.withOpacity(0.05),
                ],
              ),
            ),
          ),
        ),
        /// chatting rooms
        Align(child: PlacedChattingRoomScreen()),
        /// floating bar
        floatingSearchBar()
      ],
    );
  }
}
