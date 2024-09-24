// To parse this JSON data, do
//
//     final sendOtpModel = sendOtpModelFromJson(jsonString);

// {
//     "email": email,}

import 'dart:convert';

SendOtpModel sendOtpModelFromJson(String str) => SendOtpModel.fromJson(json.decode(str));



class SendOtpModel {
  final String email;

  SendOtpModel({
    required this.email,
  });

  factory SendOtpModel.fromJson(Map<String, dynamic> json) => SendOtpModel(
    email: json["email"],
  );

  //body
  // {
  //   "email": email
  // }

}