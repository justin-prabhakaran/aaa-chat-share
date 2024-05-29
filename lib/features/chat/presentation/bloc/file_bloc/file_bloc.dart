import 'dart:typed_data';

import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/core/usecase.dart';
import 'package:aaa_chat_share/features/chat/domain/entities/file.dart';
import 'package:aaa_chat_share/features/chat/domain/usecases/get_all_files.dart';
import 'package:aaa_chat_share/features/chat/domain/usecases/listen_files.dart';
import 'package:aaa_chat_share/features/chat/domain/usecases/upload_file.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'file_event.dart';
part 'file_state.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  final GetAllFiles _getAllFiles;
  final UploadFile _uploadFile;
  final ListenOnFiles _listenOnFiles;
  FileBloc(
      {required GetAllFiles getAllFiles,
      required UploadFile upladFile,
      required ListenOnFiles listenOnFiles})
      : _getAllFiles = getAllFiles,
        _uploadFile = upladFile,
        _listenOnFiles = listenOnFiles,
        super(FileInitial()) {
    on<FileGetAllEvent>(_fileGetAllEvent);
    on<FileUploadEvent>(_fileUploadEvent);
    on<FileThrowErrorEvent>(_fileThrowErrorEvent);
    on<FileStartListenEvent>(_fileStartListenEvent);
  }

  _fileGetAllEvent(FileGetAllEvent event, Emitter<FileState> emit) async {
    emit(FileLoadingState());
    final res = await _getAllFiles(
      NoParams(),
    );

    res.fold(
      (failure) => emit(
        FileFailureState(
          Failure(failure.message),
        ),
      ),
      (files) => emit(
        FileGetAllSuccessState(files: files),
      ),
    );
  }

  _fileUploadEvent(FileUploadEvent event, Emitter<FileState> emit) async {
    emit(FileLoadingState());
    final res = await _uploadFile(
      UploadFileParams(
          userId: event.userId, file: event.bytes, fileName: event.fileName),
    );

    res.fold(
        (failure) => emit(
              FileFailureState(failure),
            ), (isUploaded) {
      if (isUploaded) {
        emit(
          FileFailureState(
            Failure('File Upload Successfully !!!!'),
          ),
        );
      } else {
        emit(
          FileFailureState(
            Failure('File Upload failed !!!!'),
          ),
        );
      }
    });
  }

  _fileThrowErrorEvent(FileThrowErrorEvent event, Emitter<FileState> emit) {
    emit(
      FileFailureState(event.failure),
    );
  }

  _fileStartListenEvent(FileStartListenEvent event, Emitter<FileState> emit) {
    final res = _listenOnFiles(NoParams());

    res.fold((failure) => emit(FileFailureState(failure)), (stream) {
      stream.listen((_) {
        add(FileGetAllEvent());
      });
    });
  }
}
