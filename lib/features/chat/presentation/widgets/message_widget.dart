// import 'package:aaa_chat_share/core/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';

// class MessageWidget extends StatelessWidget {
//   final String userName;
//   final bool isMe;
//   final String content;
//   final DateTime time;
//   const MessageWidget(
//       {super.key,
//       required this.userName,
//       required this.content,
//       required this.time,
//       this.isMe = false});

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: isMe ? Alignment.topRight : Alignment.topLeft,
//       child: Container(
//         padding: const EdgeInsets.all(15),
//         decoration: BoxDecoration(
//           color: isMe ? AppColor.darkest : AppColor.light,
//           borderRadius: const BorderRadius.all(
//             Radius.circular(12),
//           ),
//         ),
//         child: ListTile(
//           title: Text(
//             userName,
//             style: GoogleFonts.roboto(
//               color: Colors.white38,
//               fontSize: 16,
//             ),
//           ),
//           subtitle: Text(
//             content,
//             style: GoogleFonts.roboto(color: Colors.white, fontSize: 18),
//           ),
//           trailing: Text(
//             DateFormat('HH:mm').format(time),
//             style: GoogleFonts.roboto(fontSize: 14, color: Colors.white38),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Column(
// //         crossAxisAlignment:
// //             isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
// //         children: [
// //           Text(
// //             userName,
// //             style: GoogleFonts.roboto(
// //               color: Colors.white60,
// //               fontSize: 13,
// //             ),
// //           ),
// //           Container(
// //             padding: const EdgeInsets.all(15),
// //             // height: 40,
// //             decoration: BoxDecoration(
// //               color: isMe ? AppColor.darkest : AppColor.light,
// //               // borderRadius: const BorderRadius.only(
// //               //   topLeft: Radius.circular(30),
// //               //   topRight: Radius.circular(30),
// //               //   bottomLeft: Radius.circular(30),
// //               // ),

// //               borderRadius: const BorderRadius.all(
// //                 Radius.circular(10),
// //               ),
// //             ),
// //             child: Text(
// //               content,
// //               style: GoogleFonts.roboto(color: Colors.white, fontSize: 13),
// //             ),
// //           ),
// //           Text(
// //             date,
// //             style: GoogleFonts.roboto(fontSize: 12, color: Colors.white24),
// //           )
// //         ],
// //       ),

import 'package:aaa_chat_share/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
      child: IntrinsicWidth(
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
              Text(
                content,
                style: GoogleFonts.roboto(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w300,),
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  DateFormat('HH:mm').format(time),
                  style:
                      GoogleFonts.roboto(fontSize: 12, color: Colors.white38, fontWeight: FontWeight.w300,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
