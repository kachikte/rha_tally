class ResponseModel {

  late bool isError;
  late dynamic data;

  ResponseModel.empty() {
    isError = false;
    data = "";
  }

  ResponseModel({required this.isError, required this.data});
}