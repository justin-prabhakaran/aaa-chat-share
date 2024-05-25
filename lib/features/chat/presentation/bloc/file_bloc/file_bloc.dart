import 'dart:typed_data';

import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/core/usecase.dart';
import 'package:aaa_chat_share/features/chat/domain/entities/file.dart';
import 'package:aaa_chat_share/features/chat/domain/usecases/get_all_files.dart';
import 'package:aaa_chat_share/features/chat/domain/usecases/upload_file.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'file_event.dart';
part 'file_state.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  final GetAllFiles _getAllFiles;
  final UploadFile _uploadFile;
  FileBloc({required GetAllFiles getAllFiles, required UploadFile upladFile})
      : _getAllFiles = getAllFiles,
        _uploadFile = upladFile,
        super(FileInitial()) {
    on<FileEvent>((event, emit) {
      emit(FileLoadingState());
    });

    on<FileGetAllEvent>(_fileGetAllEvent);
    on<FileUploadEvent>(_fileUploadEvent);
    on<FileThrowErrorEvent>(_fileThrowErrorEvent);
  }

  _fileGetAllEvent(FileGetAllEvent event, Emitter<FileState> emit) async {
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
    final res = await _uploadFile(
      UploadFileParams(
          userId: event.userId, file: event.bytes, fileName: event.fileName),
    );

    res.fold(
        (failure) => emit(
              FileFailureState(failure),
            ), (isUploaded) {
      if (isUploaded) {
        add(FileGetAllEvent());
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
}
