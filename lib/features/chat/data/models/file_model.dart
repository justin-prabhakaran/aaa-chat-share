import 'package:aaa_chat_share/features/chat/domain/entities/file.dart';

class FileModle extends File {
  FileModle(
      {required super.fileName,
      super.fileId,
      super.fileLink,
      required super.fileSize,
      required super.userName});

  FileModle copyWith({
    String? fileName,
    String? fileId,
    int? fileSize,
    String? userName,
    String? fileLink,
  }) {
    return FileModle(
      fileName: fileName ?? this.fileName,
      fileId: fileId ?? this.fileId,
      fileSize: fileSize ?? this.fileSize,
      userName: userName ?? this.userName,
      fileLink: fileLink ?? this.fileLink,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'file_name': fileName,
      'file_id': fileId,
      'file_size': fileSize,
      'user_name': userName,
      'file_link': fileLink,
    };
  }

  factory FileModle.fromMap(Map<String, dynamic> map) {
    return FileModle(
      fileName: map['file_name'] as String,
      fileId: map['file_id'] != null ? map['file_id'] as String : null,
      fileLink: map['file_link'] != null ? map['file_link'] as String : null,
      fileSize: map['file_size'] as int,
      userName: map['user_name'] as String,
    );
  }

  @override
  String toString() {
    return 'File(fileName: $fileName, fileId: $fileId, fileSize: $fileSize, userName: $userName)';
  }
}
