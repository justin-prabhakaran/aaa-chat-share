import 'package:aaa_chat_share/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthPage extends StatelessWidget {
  static router() => MaterialPageRoute(builder: (context) => const AuthPage());
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 250,
          width: 450,
          decoration: const BoxDecoration(
              color: AppColor.darkest,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 34,
                  color: Colors.black45,
                  offset: Offset(4, 4),
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      ' Name',
                      style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors.white70,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w300,
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        border: border(),
                        enabledBorder: border(),
                        focusedBorder: border(),
                        errorBorder: border(),
                      ),
                    )
                  ],
                ),
                Container(
                  height: 45,
                  width: 100,
                  decoration: const BoxDecoration(
                      color: AppColor.violet,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          color: AppColor.darkest,
                          offset: Offset(4, 4),
                        )
                      ]),
                  child: Center(
                    child: Text(
                      "Let\'s Go",
                      style: GoogleFonts.roboto(
                          fontSize: 18,
                          color: Colors.white70,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

InputBorder border() => const OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.light),
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
    );
