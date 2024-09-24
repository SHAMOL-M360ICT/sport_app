import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:sport_app/models/models.dart';

import '../configs/configs.dart';
import '../utilities/utilities.dart';

class AuthHandler {
  final Connection connection;

  AuthHandler(this.connection);

  Future<Response> sendOtp(Request request) async {
    try{
      final sendOtpModel = sendOtpModelFromJson(await request.readAsString());
      
      await connection.execute(
            Sql.named(
                "INSERT INTO otp_store (email, otp_code, send_time) VALUES (@email, @otp_code, @send_time)"),
            parameters: {
              "email": sendOtpModel.email,
              "otp_code": hashString(generateOTP()),
              "send_time": DateTime.now().toString(),
            });
        final sent = await sendOTPSMTP(sendOtpModel.email, generateOTP());

        if(!sent){
          return Response.notFound(responseModelToJson(ResponseModel(success: false, message: "Failed to send otp code")));
        }

      return Response.ok(responseModelToJson(ResponseModel(success: true, message: "Otp code has been sent")));
    }catch(e){
      return Response.internalServerError(body: responseModelToJson(ResponseModel(success: false, message: kExceptionMsg)));
    }
    
  }
}