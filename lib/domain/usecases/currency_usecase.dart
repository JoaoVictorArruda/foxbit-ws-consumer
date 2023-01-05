import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:joao_foxbit_test/data/helpers/websocket.dart';
import 'package:joao_foxbit_test/domain/entities/currency/currency.dart';
import 'package:joao_foxbit_test/domain/repositories/i_currency_repository.dart';

class CurrencyUseCase extends CompletableUseCase<FoxbitWebSocket> {

  CurrencyUseCase(this._repository);

  final ICurrencyRepository _repository;

  @override
  Future<Stream<List<CurrencyModel>>> buildUseCaseStream(FoxbitWebSocket params) async {
    final StreamController<List<CurrencyModel>> controller =
    StreamController<List<CurrencyModel>>();

    try {
      final List<CurrencyModel> currencies = await _repository.getCurrencies(params);
      controller.add(currencies);
      controller.close();
    } catch (e) {
      controller.addError(e);
    }

    return controller.stream;
  }
}

