

class AccessCodeException implements Exception {
  String cause;
  AccessCodeException(this.cause);
}

class EmptyStudentException implements Exception {
  String cause;
  EmptyStudentException(this.cause);
}