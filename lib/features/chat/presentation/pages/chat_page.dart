import 'package:aaa_chat_share/core/snack_bar.dart';
import 'package:aaa_chat_share/core/theme.dart';
import 'package:aaa_chat_share/features/auth/domain/entities/user_entity.dart';
import 'package:aaa_chat_share/features/chat/domain/entities/chat.dart';
import 'package:aaa_chat_share/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:aaa_chat_share/features/chat/presentation/bloc/file_bloc/file_bloc.dart';
import 'package:aaa_chat_share/features/chat/presentation/widgets/file_widget.dart';
import 'package:aaa_chat_share/features/chat/presentation/widgets/message_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatPage extends StatefulWidget {
  final User user;

  router() => MaterialPageRoute(builder: (context) => ChatPage(user: user));
  const ChatPage({super.key, required this.user});

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
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Flexible(
                  flex: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        "Files",
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 19,
                        ),
                      ),
                      const SizedBox(height: 10),
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
                                shrinkWrap: true,
                                itemCount: state.files.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 50),
                                    child: InkWell(
                                      onTap: () async {
                                        if (state.files[index].fileLink !=
                                            null) {
                                          launchUrl(
                                            Uri.parse(
                                                state.files[index].fileLink!),
                                            mode:
                                                LaunchMode.externalApplication,
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
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
                Flexible(
                  flex: 6,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        "Chats",
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 19,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: BlocConsumer<ChatBloc, ChatState>(
                          listener: (context, state) {
                            if (state is ChatFailureState) {
                              showSnackBar(context, state.failure.message);
                            }
                          },
                          builder: (context, state) {
                            if (state is ChatLoadingState) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is ChatRecievedState) {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.chat.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: MessageWidget(
                                      userName: widget.user.userName,
                                      isMe: state.chat[index].isMe,
                                      content: state.chat[index].message,
                                      time: state.chat[index].time,
                                    ),
                                  );
                                },
                              );
                            }

                            return Center(
                              child: Text(
                                "No Chats !!",
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 50, left: 50, right: 50, top: 10),
            child: TextField(
              maxLines: null,
              onSubmitted: (val) {
                context.read<ChatBloc>().add(
                      ChatSendMyMessage(
                        chat: Chat(
                          isMe: true,
                          message: val.trim(),
                          time: DateTime.now(),
                          userName: widget.user.userName,
                        ),
                      ),
                    );
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
