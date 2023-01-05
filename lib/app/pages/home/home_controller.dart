import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:joao_foxbit_test/app/pages/home/home_presenter.dart';
import 'package:joao_foxbit_test/data/helpers/websocket.dart';
import 'package:joao_foxbit_test/domain/entities/currency/currency.dart';
import 'package:joao_foxbit_test/domain/entities/currency/currency_detail.dart';
import 'package:joao_foxbit_test/domain/usecases/currency_detail_usecase.dart';

class HomeController extends Controller {
  final HomePresenter presenter;
  final FoxbitWebSocket ws;
  final FoxbitWebSocket detailWs;
  List<CurrencyModel> _currencies = [];
  List<CurrencyDetail> _currenciesDetails = [];

  List<CurrencyModel> get currencies => _currencies;
  List<CurrencyDetail> get currenciesDetails => _currenciesDetails;

  HomeController() : presenter = HomePresenter(), detailWs = FoxbitWebSocket(), ws = FoxbitWebSocket() {
    ws.connect();
    detailWs.connect();
    presenter.sendPing(ws);
    presenter.getCurrencies(ws);
    presenter.getCurrencyDetail(CurrencyDetailUseCaseParams(_currencies, detailWs));
  }

  @override
  void onDisposed() {
    ws.disconnect();
    detailWs.disconnect();

    super.onDisposed();
  }

  @override
  void initListeners() {
    presenter.pingOnComplete = pingOnComplete;
    presenter.pingOnError = pingOnError;

    presenter.currencyOnComplete = currencyOnComplete;
    presenter.currencyOnError = currencyOnError;
    presenter.currencyOnNext = (List<CurrencyModel> instruments) {
      return _currencies = instruments;
    };

    presenter.currencyDetailOnComplete = currencyDetailOnComplete;
    presenter.currencyDetailOnError = currencyDetailOnError;
    presenter.currencyDetailOnNext = (List<CurrencyDetail> assets) {
      return _currenciesDetails = assets;
    };
  }

  void pingOnComplete() {
    _schedulePing();
  }

  void currencyOnComplete() {
    _scheduleNextCurrency();
    refreshUI();
  }

  void currencyDetailOnComplete() {
    _scheduleNextCurrencyDetail();
    refreshUI();
  }

  void pingOnError(dynamic e) {
    _schedulePing();
  }

  void currencyOnError(dynamic e) {
    _schedulePing();
  }

  void currencyDetailOnError(dynamic e) {
    _schedulePing();
  }

  void _schedulePing() {
    Timer(const Duration(seconds: 30), () {
      presenter.sendPing(ws);
    });
  }

  void _scheduleNextCurrency() {
    Timer(const Duration(seconds: 10), () {
      presenter.getCurrencies(ws);
    });
  }

  void _scheduleNextCurrencyDetail() {
    Timer(const Duration(seconds: 30), () {
      presenter.getCurrencyDetail(CurrencyDetailUseCaseParams(_currencies, ws));
    });
  }
}
