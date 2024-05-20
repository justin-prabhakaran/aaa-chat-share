import 'package:aaa_chat_share/core/snack_bar.dart';
import 'package:aaa_chat_share/core/theme.dart';
import 'package:aaa_chat_share/features/chat/presentation/bloc/file_bloc/file_bloc.dart';
import 'package:aaa_chat_share/features/chat/presentation/widgets/file_widget.dart';
import 'package:aaa_chat_share/features/chat/presentation/widgets/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatPage extends StatefulWidget {
  static router() => MaterialPageRoute(builder: (context) => const ChatPage());
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    context.read<FileBloc>().add(FileGetAllEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                "Files",
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 19,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: BlocConsumer<FileBloc, FileState>(
                  builder: (context, state) {
                    if (state is FileLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is FileGetAllSuccessState) {
                      return ListView.builder(
                        itemCount: state.files.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 50),
                            child: InkWell(
                              onTap: () async {
                                if (state.files[index].fileLink != null) {
                                  launchUrl(
                                    Uri.parse(state.files[index].fileLink!),
                                    mode: LaunchMode.externalApplication,
                                  );
                                }
                              },
                              child: FileWidget(
                                fileName: state.files[index].fileName,
                                userName: state.files[index].userName,
                                fileSize: state.files[index].fileSize,
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const Center(
                      child: Text("No Files found !!"),
                    );
                  },
                  listener: (context, state) {
                    if (state is FileGetAllFailureState) {
                      print(state.failure.message);
                      showSnackBar(context, state.failure.message);
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: InkWell(
                  child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                      color: AppColor.violet,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Upload',
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
        Expanded(
          flex: 6,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                "Chats",
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 19,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
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
