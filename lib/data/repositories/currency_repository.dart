import 'package:joao_foxbit_test/data/helpers/websocket.dart';
import 'package:joao_foxbit_test/domain/entities/currency/currency.dart';
import 'package:joao_foxbit_test/domain/repositories/i_currency_repository.dart';

class CurrencyRepository implements ICurrencyRepository {
  final String _eventName = "getInstruments";
  List<CurrencyModel> resultList = [];

  @override
  Future<List<CurrencyModel>> getCurrencies(FoxbitWebSocket ws) async {
    await Future.delayed(const Duration(milliseconds: 500));

    ws.send(_eventName, {});
    ws.stream.firstWhere((message) {
      final messages = message["o"];
      final messagesLength = messages.length - 1 as int;

      if (messagesLength != 0) {
        final instruments = CurrencyModel.fromJsonList(messages as List);
        resultList = instruments;
      }
      return message['n'].toString().toUpperCase() == _eventName && message['i'] == ws.lastId;
    });

    return Future.value(resultList);
  }
}
