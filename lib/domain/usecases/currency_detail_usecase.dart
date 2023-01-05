import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:joao_foxbit_test/data/helpers/websocket.dart';
import 'package:joao_foxbit_test/domain/entities/currency/currency.dart';
import 'package:joao_foxbit_test/domain/entities/currency/currency_detail.dart';
import 'package:joao_foxbit_test/domain/repositories/i_currency_detail_repository.dart';

class CurrencyDetailUseCase extends CompletableUseCase<CurrencyDetailUseCaseParams> {
  CurrencyDetailUseCase(
    this._repository,
  );

  final ICurrencyDetailRepository _repository;

  @override
  Future<Stream<List<CurrencyDetail>>> buildUseCaseStream(CurrencyDetailUseCaseParams params) async {
    final StreamController<List<CurrencyDetail>> controller = StreamController<List<CurrencyDetail>>();

    try {
      final List<CurrencyDetail> assets = await _repository.getCurrencyDetails(params);
      controller.add(assets);
      controller.close();
    } catch (e) {
      controller.addError(e);
    }

    return controller.stream;
  }
}

class CurrencyDetailUseCaseParams {
  final List<CurrencyModel> currencies;
  final FoxbitWebSocket ws;

  CurrencyDetailUseCaseParams(this.currencies, this.ws);
}
