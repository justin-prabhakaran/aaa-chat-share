class File {
  String fileName;
  String? fileId;
  int fileSize;
  String userName;
  String? fileLink;
  File({
    required this.fileName,
    this.fileId,
    this.fileLink,
    required this.fileSize,
    required this.userName,
  });
}
