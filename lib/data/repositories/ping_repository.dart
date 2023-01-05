import 'package:joao_foxbit_test/data/helpers/websocket.dart';
import 'package:joao_foxbit_test/domain/repositories/i_ping_repository.dart';

class PingRepository implements IPingRepository {
  final String _eventName = "PING";

  @override
  Future<Map> ping(FoxbitWebSocket ws) {
    ws.send(_eventName, {});
    return ws.stream.firstWhere((message) =>
        message['n'].toString().toUpperCase() == _eventName && message['i'] == ws.lastId);
  }
}
