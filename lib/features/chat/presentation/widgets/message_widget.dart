import 'package:aaa_chat_share/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageWidget extends StatelessWidget {
  final bool isMe;
  final String content;
  final String date;
  const MessageWidget(
      {super.key,
      required this.content,
      required this.date,
      this.isMe = false});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.topRight : Alignment.topLeft,
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            'justin',
            style: GoogleFonts.roboto(
              color: Colors.white60,
              fontSize: 13,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            // height: 40,
            decoration: BoxDecoration(
              color: isMe ? AppColor.darkest : AppColor.light,
              // borderRadius: const BorderRadius.only(
              //   topLeft: Radius.circular(30),
              //   topRight: Radius.circular(30),
              //   bottomLeft: Radius.circular(30),
              // ),

              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Text(
              content,
              style: GoogleFonts.roboto(color: Colors.white, fontSize: 13),
            ),
          ),
          Text(
            date,
            style: GoogleFonts.roboto(fontSize: 12, color: Colors.white24),
          )
        ],
      ),
    );
  }
}
