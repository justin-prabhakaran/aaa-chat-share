import 'package:aaa_chat_share/core/theme.dart';
import 'package:aaa_chat_share/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthSuccessWidget extends StatelessWidget {
  const AuthSuccessWidget({
    super.key,
    required TextEditingController textEditingController,
  }) : _textEditingController = textEditingController;

  final TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {
    return Center(
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
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    ' Name',
                    style: GoogleFonts.roboto(
                        fontSize: 20,
                        color: Colors.white70,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _textEditingController,
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
              InkWell(
                onTap: () {
                  context.read<AuthBloc>().add(AuthCreateUserEvent(
                      userName: _textEditingController.text.trim()));
                },
                child: Container(
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
              ),
              SizedBox(
                height: 5,
              )
            ],
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
