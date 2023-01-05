import 'package:flutter_test/flutter_test.dart';
import 'package:joao_foxbit_test/data/repositories/ping_repository.dart';
import 'package:joao_foxbit_test/domain/usecases/ping_usecase.dart';

import 'connections/test_websocket.dart';
import 'utils/default_test_observer.dart';

void main() {
  TestFoxbitWebSocket webSocket;
  PingUseCase useCase;
  DefaultTestObserver observer;

  setUp(() {
    webSocket = TestFoxbitWebSocket();
    useCase = PingUseCase(PingRepository());
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

  test('Validate websocket ping message formation', () async {
    useCase.execute(observer, webSocket);
    while (!observer.ended) {
      await Future<dynamic>.delayed(const Duration(milliseconds: 10));
    }

    expect(observer.done, true);
    expect(observer.error, false);
    expect(webSocket.sendedMessages.last, '{"m":0,"i":0,"n":"PING","o":"{}"}');
  });
}