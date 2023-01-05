

import 'dart:developer';

import 'package:joao_foxbit_test/domain/entities/currency/currency_detail.dart';
import 'package:joao_foxbit_test/domain/repositories/i_currency_detail_repository.dart';
import 'package:joao_foxbit_test/domain/usecases/currency_detail_usecase.dart';

class CurrencyDetailsRepository implements ICurrencyDetailRepository {
  final String _eventName = "SubscribeLevel1";
  List<CurrencyDetail> resultList = [];

  @override
  Future<List<CurrencyDetail>> getCurrencyDetails(CurrencyDetailUseCaseParams params) async {
    for (final currency in params.currencies) {
      await Future.delayed(const Duration(milliseconds: 500));
      params.ws.send(_eventName, {"InstrumentId": currency.instrumentId});
      params.ws.stream.firstWhere((element) {
        final message = element["o"];
        // log(message.toString());
        // if([1,2,4,6,10].contains(currency.instrumentId)) {
        //   log(message.toString());
        // }
        CurrencyDetail data = CurrencyDetail.fromJsonCurrency(message as Map<String, dynamic>);
        for (int i = 0; i < resultList.length; i++) {
          final item = resultList[i];
          if (item.symbol == data.symbol) {
            resultList.removeAt(i);
          }
        }
        if (!resultList.contains(data)) {
          resultList.add(data);
        }
        return element['n'].toString().toUpperCase() == _eventName.toUpperCase() && element['i'] == params.ws.lastId;
      });
    }

    return Future.value(resultList);
  }

}
