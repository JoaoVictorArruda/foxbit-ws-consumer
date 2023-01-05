import 'package:flutter_test/flutter_test.dart';
import 'package:joao_foxbit_test/data/repositories/currency_detail_repository.dart';
import 'package:joao_foxbit_test/domain/entities/currency/currency.dart';
import 'package:joao_foxbit_test/domain/usecases/currency_detail_usecase.dart';

import '../connections/test_websocket.dart';
import '../utils/default_test_observer.dart';

void main() {
  TestFoxbitWebSocket webSocket = TestFoxbitWebSocket();
  CurrencyDetailUseCase useCase;
  DefaultTestObserver observer;

  final CurrencyDetailUseCaseParams params = CurrencyDetailUseCaseParams([
    CurrencyModel(instrumentId: 1, symbol: "asd"),
    CurrencyModel(instrumentId: 1, symbol: "asd"),
    CurrencyModel(instrumentId: 1, symbol: "asd"),
  ], webSocket);
  setUp(() {
    webSocket = TestFoxbitWebSocket();
    useCase = CurrencyDetailUseCase(CurrencyDetailsRepository());
    observer = DefaultTestObserver();
  });

  tearDown(() {
    useCase.dispose();
  });

  test('Validate correct execution', () async {
    useCase.execute(observer, params);
    while (!observer.ended) {
      await Future<dynamic>.delayed(const Duration(milliseconds: 3000));
    }

    expect(observer.done, true);
    expect(observer.error, false);
  });

  test('Validate correct execution with empty params', () async {
    useCase.execute(observer, CurrencyDetailUseCaseParams([], webSocket));
    while (!observer.ended) {
      await Future<dynamic>.delayed(const Duration(milliseconds: 3000));
    }

    expect(observer.done, true);
    expect(observer.error, false);
  });

  test('Validate correct execution with empty params and null ws', () async {
    useCase.execute(observer, CurrencyDetailUseCaseParams([], null));
    while (!observer.ended) {
      await Future<dynamic>.delayed(const Duration(milliseconds: 3000));
    }

    expect(observer.done, true);
    expect(observer.error, false);
  });

  test('Validate correct execution with empty params and empty ws', () async {
    useCase.execute(observer, CurrencyDetailUseCaseParams([], TestFoxbitWebSocket()));
    while (!observer.ended) {
      await Future<dynamic>.delayed(const Duration(milliseconds: 3000));
    }

    expect(observer.done, true);
    expect(observer.error, false);
  });
}
