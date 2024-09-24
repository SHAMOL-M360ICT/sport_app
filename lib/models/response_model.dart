import 'dart:convert';

//     final responseModel = responseModelFromJson(jsonString);

ResponseModel responseModelFromJson(String str) => ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
  final bool success;
  final String message;
  final dynamic data;

  ResponseModel(
      {required this.success, required this.message, this.data});

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    success: json["success"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    if(data != null)
    "data": data,
  };
}