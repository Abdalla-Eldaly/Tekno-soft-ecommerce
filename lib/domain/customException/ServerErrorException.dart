class ServerErrorException implements Exception{
  String? errorMessage;
  String? statusMsg;
  int? httpResponseCode;
  ServerErrorException({this.errorMessage,
  this.statusMsg,this.httpResponseCode});
}