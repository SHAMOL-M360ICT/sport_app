import 'package:postgres/postgres.dart';
import 'package:shelf_router/shelf_router.dart';

import '../handlers/handlers.dart';

class AuthRoutes{

  final Connection connection;
  AuthRoutes(this.connection);

  AuthHandler get _authHandler => AuthHandler(connection);

  Router get router => Router()
    ..post('/auth/send-otp', _authHandler.sendOtp);
}