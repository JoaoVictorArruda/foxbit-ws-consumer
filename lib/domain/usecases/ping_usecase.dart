import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:joao_foxbit_test/data/helpers/websocket.dart';
import 'package:joao_foxbit_test/domain/repositories/i_ping_repository.dart';

class PingUseCase extends CompletableUseCase<FoxbitWebSocket> {
  PingUseCase(this._repository);

  final IPingRepository _repository;

  @override
  Future<Stream<void>> buildUseCaseStream(FoxbitWebSocket params) async {
    final StreamController<void> controller = StreamController<void>();

    try {
      final Map _ = await _repository.ping(params);

      controller.close();
    } catch (e) {
      controller.addError(e);
    }

    return controller.stream;
  }
}
