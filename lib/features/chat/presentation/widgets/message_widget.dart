import 'package:aaa_chat_share/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MessageWidget extends StatelessWidget {
  final String userName;
  final String content;
  final DateTime time;

  const MessageWidget({
    super.key,
    required this.userName,
    required this.content,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IntrinsicWidth(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: AppColor.darkest,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  '@$userName',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w300,
                    color: Colors.white38,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                content,
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  DateFormat('HH:mm').format(time),
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: Colors.white38,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
