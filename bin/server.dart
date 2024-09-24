import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:sport_app/configs/db.dart';
import 'package:sport_app/middleware/middleware.dart';
import 'package:sport_app/routes/routes.dart';



void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  await DBConfig.connection.then((connection)async{
    final router = Router();
    router.mount('/api', AuthRoutes(connection).router.call);

    final handler = Pipeline()
        .addMiddleware(logRequests())
        .addMiddleware(AuthMiddleware.checkAuthentication())
        .addHandler(router.call);

    // For running in containers, we respect the PORT environment variable.
    final port = int.parse(Platform.environment['PORT'] ?? '8080');
    final server = await serve(handler, ip, port);
    print('Server listening on port ${server.port}');
  });

  

  // Configure a pipeline that logs requests.
  // final handler =
  //     Pipeline().addMiddleware(logRequests()).addHandler(_router.call);

  // // For running in containers, we respect the PORT environment variable.
  // final port = int.parse(Platform.environment['PORT'] ?? '8080');
  // final server = await serve(handler, ip, port);
  // print('Server listening on ip ${ip} port ${server.port}');
}


// Configure routes.
// final _router = Router()
//   ..get('/', _rootHandler)
//   ..get('/echo/<message>', _echoHandler);

// Response _rootHandler(Request req) {
//   return Response.ok('Hello, World!\n');
// }

// Response _echoHandler(Request request) {
//   final message = request.params['message'];
//   return Response.ok('$message\n');
// }