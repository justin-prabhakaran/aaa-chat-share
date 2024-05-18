import 'package:aaa_chat_share/core/failure.dart';
import 'package:aaa_chat_share/core/usecase.dart';
import 'package:aaa_chat_share/features/chat/domain/entities/file.dart';
import 'package:aaa_chat_share/features/chat/domain/usecases/get_all_files.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'file_event.dart';
part 'file_state.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  final GetAllFiles _getAllFiles;
  FileBloc({required GetAllFiles getAllFiles})
      : _getAllFiles = getAllFiles,
        super(FileInitial()) {
    on<FileEvent>((event, emit) {
      emit(FileLoadingState());
    });

    on<FileGetAllEvent>(_gileGetAllEvent);
  }

  _gileGetAllEvent(FileGetAllEvent event, Emitter<FileState> emit) async {
    final res = await _getAllFiles(NoParams());

    res.fold(
      (failure) => emit(
        FileGetAllFailureState(
          Failure(failure.message),
        ),
      ),
      (files) => emit(
        FileGetAllSuccessState(files: files),
      ),
    );
  }
}
