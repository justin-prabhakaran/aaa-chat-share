import 'package:aaa_chat_share/features/chat/domain/entities/file.dart';

class FileModle extends File {
  FileModle(
      {required super.fileName,
      super.fileId,
      required super.fileSize,
      required super.userName});

  FileModle copyWith({
    String? fileName,
    String? fileId,
    int? fileSize,
    String? userName,
  }) {
    return FileModle(
      fileName: fileName ?? this.fileName,
      fileId: fileId ?? this.fileId,
      fileSize: fileSize ?? this.fileSize,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fileName': fileName,
      'fileId': fileId,
      'fileSize': fileSize,
      'userName': userName,
    };
  }

  factory FileModle.fromMap(Map<String, dynamic> map) {
    return FileModle(
      fileName: map['fileName'] as String,
      fileId: map['fileId'] != null ? map['fileId'] as String : null,
      fileSize: map['fileSize'] as int,
      userName: map['userName'] as String,
    );
  }

  @override
  String toString() {
    return 'File(fileName: $fileName, fileId: $fileId, fileSize: $fileSize, userName: $userName)';
  }

  @override
  bool operator ==(covariant File other) {
    if (identical(this, other)) return true;

    return other.fileName == fileName &&
        other.fileId == fileId &&
        other.fileSize == fileSize &&
        other.userName == userName;
  }

  @override
  int get hashCode {
    return fileName.hashCode ^
        fileId.hashCode ^
        fileSize.hashCode ^
        userName.hashCode;
  }
}
