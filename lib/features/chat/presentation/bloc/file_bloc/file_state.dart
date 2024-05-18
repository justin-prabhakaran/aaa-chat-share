part of 'file_bloc.dart';

sealed class FileState extends Equatable {
  const FileState();

  @override
  List<Object> get props => [];
}

final class FileInitial extends FileState {}

class FileLoadingState extends FileState {}

class FileGetAllSuccessState extends FileState {
  final List<File> files;

  const FileGetAllSuccessState({required this.files});
}

class FileGetAllFailureState extends FileState {
  final Failure failure;

  const FileGetAllFailureState(this.failure);
}
