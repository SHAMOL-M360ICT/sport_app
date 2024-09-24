import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import 'package:sport_app/models/response_model.dart';

import '../configs/configs.dart';
import '../utilities/utilities.dart';


class AuthMiddleware {
  static Middleware checkAuthentication() => (innerHandler) {
    return (request) {
      print("object request.url: ${request.url}");
      if (request.url != Uri.parse("api/auth/send-otp")) {
        final token = extractToken(request);
        if (token != null) {
          final verify = JWT.tryVerify(token, SecretKey(kSecreteKey));
          if (verify != null) {
            return innerHandler(request);
          }
        }
        return Response.unauthorized(responseModelToJson(ResponseModel(success: false, message: "Unauthorized request")));
      } else {
        return innerHandler(request);
      }
    };
  };
}