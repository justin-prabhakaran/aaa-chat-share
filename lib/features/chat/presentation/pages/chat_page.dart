import '../../domain/entities/file.dart';

import '../../../../core/cubit/app_auth_cubit.dart';
import '../../../../core/entities/user_entity.dart';
import '../../../../core/failure.dart';
import '../../../../core/snack_bar.dart';
import '../../../../core/theme.dart';
import '../../domain/entities/chat.dart';
import '../bloc/chat_bloc/chat_bloc.dart';
import '../bloc/file_bloc/file_bloc.dart';
import '../widgets/file_widget.dart';
import '../widgets/message_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatPage extends StatefulWidget {
  static get router =>
      MaterialPageRoute(builder: (context) => const ChatPage());
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ScrollController _scrollController;
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  late User user;
  @override
  void initState() {
    final state = context.read<AppAuthCubit>().state;
    if (state is AppAuthLoggedInState) {
      user = state.user;
    } else {
      context.read<FileBloc>().add(
            FileThrowErrorEvent(
              failure: Failure('User Not Found !!! , May be Logged Out'),
            ),
          );
    }

    _textEditingController = TextEditingController();
    _scrollController = ScrollController();
    context.read<ChatBloc>().add(ChatStartedListenEvent());
    context.read<FileBloc>().add(FileStartListenEvent());
    context.read<FileBloc>().add(FileGetAllEvent());
    context.read<ChatBloc>().add(ChatGetAllChatEvent());

    _focusNode = FocusNode(
      onKeyEvent: (node, event) {
        final isShiftEnter = event is KeyDownEvent &&
            event.physicalKey == PhysicalKeyboardKey.enter &&
            HardwareKeyboard.instance.isShiftPressed;
        if (isShiftEnter) {
          final text = _textEditingController.text;
          final selection = _textEditingController.selection;

          final newtext =
              text.replaceRange(selection.start, selection.end, '\n');

          _textEditingController.value = TextEditingValue(
              text: newtext,
              selection: TextSelection.collapsed(offset: selection.start + 1));

          return KeyEventResult.handled;
        } else if (event is KeyDownEvent &&
            event.physicalKey == PhysicalKeyboardKey.enter &&
            !isShiftEnter) {
          _handleSend();

          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
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
                            return Center(
                              child: Text(
                                "No Files found !!",
                                style: GoogleFonts.roboto(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            );
                          },
                          listener: (context, state) {
                            if (state is FileFailureState) {
                              showSnackBar(context, state.failure.message);
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: InkWell(
                          onTap: () async {
                            FilePickerResult? res =
                                await FilePicker.platform.pickFiles(
                              type: FileType.any,
                              allowMultiple: false,
                              withData: true,
                              onFileLoading: (status) {
                                print(status.toString());
                              },
                            );

                            if (res != null) {
                              Uint8List bytes = res.files.first.bytes!;
                              String fileName = res.files.first.name;
                              if (context.mounted) {
                                context.read<FileBloc>().add(
                                      FileUploadEvent(
                                          bytes: bytes,
                                          userId: user.userId,
                                          fileName: fileName),
                                    );
                              }
                            } else {
                              if (context.mounted) {
                                context.read<FileBloc>().add(
                                      FileThrowErrorEvent(
                                        failure: Failure(
                                            "ERROR : Error While Selecting File !!"),
                                      ),
                                    );
                              }
                            }
                          },
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
                                  fontWeight: FontWeight.w300,
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
                          buildWhen: (previous, current) =>
                              current is ChatRecievedState,
                          listener: (context, state) {
                            if (state is ChatFailureState) {
                              showSnackBar(context, state.failure.message);
                            } else if (state is ChatRecievedState) {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((_) async {
                                if (_scrollController.hasClients) {
                                  await _scrollController.animateTo(
                                      _scrollController
                                          .position.maxScrollExtent,
                                      duration:
                                          const Duration(milliseconds: 600),
                                      curve: Curves.easeInOut);
                                }
                              });
                            }
                          },
                          builder: (context, state) {
                            if (state is ChatRecievedState) {
                              return ListView.builder(
                                controller: _scrollController,
                                shrinkWrap: true,
                                itemCount: state.chats.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: MessageWidget(
                                      userName: state.chats[index].userName,
                                      content: state.chats[index].message,
                                      time: state.chats[index].time,
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
                const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints(
                      maxHeight: 150, // Constrain the max height
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: AppColor.darkest,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          focusNode: _focusNode,
                          controller: _textEditingController,
                          maxLines: null,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                            hintText: 'Type a message..',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.white),
                  onPressed: _handleSend,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleSend() {
    final message = _textEditingController.text.trim();
    if (message.isNotEmpty) {
      context.read<ChatBloc>().add(
            ChatSendMyMessageEvent(
              chat: Chat(
                message: message,
                time: DateTime.now(),
                userName: user.userName,
              ),
            ),
          );
      _textEditingController.clear();
      _focusNode.requestFocus();
    }
  }
}
