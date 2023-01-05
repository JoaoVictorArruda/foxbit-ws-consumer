import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:joao_foxbit_test/data/helpers/websocket.dart';
import 'package:joao_foxbit_test/data/repositories/currency_detail_repository.dart';
import 'package:joao_foxbit_test/data/repositories/currency_repository.dart';
import 'package:joao_foxbit_test/data/repositories/ping_repository.dart';
import 'package:joao_foxbit_test/domain/entities/currency/currency.dart';
import 'package:joao_foxbit_test/domain/entities/currency/currency_detail.dart';
import 'package:joao_foxbit_test/domain/usecases/currency_detail_usecase.dart';
import 'package:joao_foxbit_test/domain/usecases/currency_usecase.dart';
import 'package:joao_foxbit_test/domain/usecases/ping_usecase.dart';

class HomePresenter extends Presenter {
  Function pingOnComplete;
  Function(dynamic) pingOnError;

  Function currencyOnComplete;
  Function currencyOnNext;
  Function(dynamic) currencyOnError;

  Function currencyDetailOnComplete;
  Function currencyDetailOnNext;
  Function(dynamic) currencyDetailOnError;

  final PingUseCase _pingUseCase = PingUseCase(PingRepository());
  final CurrencyUseCase _currencyUseCase = CurrencyUseCase(CurrencyRepository());
  final CurrencyDetailUseCase _currencyDetailUseCase = CurrencyDetailUseCase(CurrencyDetailsRepository());

  void sendPing(FoxbitWebSocket ws) {
    _pingUseCase.execute(_PingObserver(this), ws);
  }

  void getCurrencies(FoxbitWebSocket ws) {
    _currencyUseCase.execute(_getCurrencyObserver(this), ws);
  }

  void getCurrencyDetail(CurrencyDetailUseCaseParams params) {
    _currencyDetailUseCase.execute(_getCurrencyDetailObserver(this), params);
  }

  @override
  void dispose() {
    _pingUseCase.dispose();
    _currencyUseCase.dispose();
    _currencyDetailUseCase.dispose();
  }
}

class _PingObserver implements Observer<void> {
  HomePresenter presenter;

  _PingObserver(this.presenter);

  @override
  void onNext(_) {}

  @override
  void onComplete() {
    assert(presenter.pingOnComplete != null);
    presenter.pingOnComplete();
  }

  @override
  void onError(dynamic e) {
    assert(presenter.pingOnError != null);
    presenter.pingOnError(e);
  }
}

class _getCurrencyObserver implements Observer<List<CurrencyModel>> {
  HomePresenter presenter;

  _getCurrencyObserver(this.presenter);

  @override
  void onNext(List<CurrencyModel> data) {
    assert(data is List<CurrencyModel>);
    assert(presenter.currencyOnComplete != null);
    presenter.currencyOnNext(data);
  }

  @override
  void onComplete() {
    assert(presenter.currencyOnComplete != null);
    presenter.currencyOnComplete();
  }

  @override
  void onError(dynamic e) {
    assert(presenter.currencyOnError != null);
    presenter.currencyOnError(e);
  }
}

class _getCurrencyDetailObserver implements Observer<List<CurrencyDetail>> {
  HomePresenter presenter;

  _getCurrencyDetailObserver(this.presenter);

  @override
  void onNext(List<CurrencyDetail> data) {
    assert(data is List<CurrencyDetail>);
    assert(presenter.currencyOnComplete != null);
    presenter.currencyDetailOnNext(data);
  }

  @override
  void onComplete() {
    assert(presenter.currencyOnComplete != null);
    presenter.currencyDetailOnComplete();
  }

  @override
  void onError(dynamic e) {
    assert(presenter.currencyOnError != null);
    presenter.currencyDetailOnError(e);
  }
}
