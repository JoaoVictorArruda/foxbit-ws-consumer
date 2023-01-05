import 'package:joao_foxbit_test/data/helpers/websocket.dart';
import 'package:joao_foxbit_test/domain/entities/currency/currency.dart';

abstract class ICurrencyRepository {
  Future<List<CurrencyModel>> getCurrencies(FoxbitWebSocket ws);
}
