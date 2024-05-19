import 'package:aaa_chat_share/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FileWidget extends StatelessWidget {
  final String fileName;
  final String userName;
  final int fileSize;

  const FileWidget(
      {super.key,
      required this.fileName,
      required this.userName,
      required this.fileSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        color: AppColor.blue,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            fileName,
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 19,
            ),
          ),
          Text(
            userName,
            style: GoogleFonts.roboto(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          Text(
            fileName,
            style: GoogleFonts.roboto(
              color: Colors.white54,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
