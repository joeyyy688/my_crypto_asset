// ignore_for_file: file_names

class GenericResponse {
  final bool isError;
  final int statusCode;
  final dynamic body;

  GenericResponse({
    required this.isError,
    required this.statusCode,
    required this.body,
  });
}
