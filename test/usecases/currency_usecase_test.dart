import 'package:flutter_test/flutter_test.dart';
import 'package:joao_foxbit_test/data/repositories/currency_repository.dart';
import 'package:joao_foxbit_test/domain/entities/currency/currency.dart';
import 'package:joao_foxbit_test/domain/usecases/currency_usecase.dart';

import '../connections/test_websocket.dart';
import '../utils/default_test_observer.dart';



void main() {
  TestFoxbitWebSocket webSocket;
  CurrencyUseCase useCase;
  DefaultTestObserver observer;

  setUp(() {
    webSocket = TestFoxbitWebSocket();
    useCase = CurrencyUseCase(CurrencyRepository());
    observer = DefaultTestObserver();
  });

  tearDown(() {
    useCase.dispose();
  });

  test('Validate correct execution', () async {
    useCase.execute(observer, webSocket);
    while (!observer.ended) {
      await Future<dynamic>.delayed(const Duration(milliseconds: 10));
    }

    expect(observer.done, true);
    expect(observer.error, false);
  });

  test('Validate websocket getInstruments message formation', () async {
    useCase.execute(observer, webSocket);
    while (!observer.ended) {
      await Future<dynamic>.delayed(const Duration(milliseconds: 10));
    }

    expect(observer.done, true);
    expect(observer.error, false);
    expect(webSocket.sendedMessages.last, '{"m":0,"i":0,"n":"getInstruments","o":"{}"}');
  });

  test('Validate retrieving list of InstrumentEntity', () async {
    useCase.execute(observer, webSocket);
    while (!observer.ended) {
      await Future<dynamic>.delayed(const Duration(milliseconds: 10));
    }

    expect(observer.done, true);
    expect(observer.error, false);
    expect(webSocket.sendedMessages.last, '{"m":0,"i":0,"n":"getInstruments","o":"{}"}');
    final result = observer.data as List<CurrencyModel>;
    expect(result, isA<List<CurrencyModel>>());
  });

  test('Validate correct execution with empty ws', () async {
    useCase.execute(observer, TestFoxbitWebSocket());
    while (!observer.ended) {
      await Future<dynamic>.delayed(const Duration(milliseconds: 10));
    }

    expect(observer.done, true);
    expect(observer.error, false);
  });
}
