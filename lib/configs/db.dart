import 'package:postgres/postgres.dart';

class DBConfig {
  static Future<Connection> get connection async => await Connection.open(
      Endpoint(
          host: 'localhost',
          port: 5433,
          database: 'sport',
          username: 'postgres',
          password: '1234'),
      settings: ConnectionSettings(
          sslMode: SslMode.disable
      ));
}
