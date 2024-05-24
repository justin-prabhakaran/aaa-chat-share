part of 'file_bloc.dart';

sealed class FileEvent extends Equatable {
  const FileEvent();

  @override
  List<Object> get props => [];
}

class FileGetAllEvent extends FileEvent {}

class FileUploadEvent extends FileEvent {
  final Uint8List bytes;
  final String userId;
  final String fileName;
  const FileUploadEvent(
      {required this.bytes, required this.userId, required this.fileName});
}

class FileThrowErrorEvent extends FileEvent {
  final Failure failure;

  const FileThrowErrorEvent({required this.failure});
}
