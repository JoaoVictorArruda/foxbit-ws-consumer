import 'package:joao_foxbit_test/data/helpers/websocket.dart';

abstract class IPingRepository {
  Future<Map> ping(FoxbitWebSocket ws);
}