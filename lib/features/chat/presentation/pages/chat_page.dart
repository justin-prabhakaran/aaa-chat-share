import 'package:aaa_chat_share/features/chat/presentation/widgets/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatPage extends StatelessWidget {
  static router() => MaterialPageRoute(builder: (context) => const ChatPage());
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              const Text("Files"),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: MessageWidget(
                          isMe: index % 2 == 0,
                          content: "asdasdada dadakd adadkjad adj",
                          date: "12:00"),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        Expanded(
          flex: 6,
          child: Column(
            children: [
              const Text("chats"),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return MessageWidget(
                        isMe: index % 2 == 0,
                        content: "asdasdada dadakd adadkjad adj",
                        date: "12:00");
                  },
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}
