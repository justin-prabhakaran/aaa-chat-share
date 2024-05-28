import 'package:aaa_chat_share/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:markdown/markdown.dart' as md;

class MessageWidget extends StatelessWidget {
  final String userName;
  final bool isMe;
  final String content;
  final DateTime time;

  const MessageWidget({
    super.key,
    required this.userName,
    required this.content,
    required this.time,
    this.isMe = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isMe ? AppColor.darkest : AppColor.light,
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: isMe ? Alignment.topRight : Alignment.topLeft,
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
            MarkdownBody(
              data: content,
              styleSheet: MarkdownStyleSheet(
                p: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
                code: GoogleFonts.anonymousPro(
                  color: Colors.white60,
                  fontSize: 14,
                ),
                h1: GoogleFonts.roboto(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                h2: GoogleFonts.roboto(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                h3: GoogleFonts.roboto(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                em: GoogleFonts.roboto(
                  color: Colors.white70,
                  fontStyle: FontStyle.italic,
                ),
                strong: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                blockquote: GoogleFonts.roboto(
                  color: Colors.white70,
                  fontSize: 16,
                ),
                codeblockDecoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(color: AppColor.lightblue),
                ),
                codeblockPadding: const EdgeInsets.all(8),
              ),
              // builders: {
              //   'code': CodeElementBuilder(),
              // },
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
    );
  }
}

// class CodeElementBuilder extends MarkdownElementBuilder {
//   @override
//   Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
//     final String code = element.textContent;
//     return Stack(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: Colors.black54,
//             borderRadius: const BorderRadius.all(Radius.circular(8)),
//             border: Border.all(color: AppColor.lightblue),
//           ),
//           child: Text(
//             code,
//             style: GoogleFonts.anonymousPro(
//               color: Colors.white60,
//               fontSize: 14,
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 2,
//           right: 2,
//           child: IconButton(
//             icon: const Icon(Icons.copy_rounded, size: 16),
//             color: Colors.white,
//             onPressed: () {
//               print(code); // Replace with clipboard copy functionality if needed
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
