import 'package:joao_foxbit_test/domain/entities/currency/currency.dart';

class CurrencyDetail {
  final int instrumentId;
  final String symbol;
  final double lastValue;
  final double sessionOpen;
  final double sessionClose;

  CurrencyDetail(this.instrumentId, this.symbol,this.lastValue, this.sessionOpen, this.sessionClose);

  static CurrencyDetail fromJsonCurrency(Map<String, dynamic> json){
    double lastValue = 0.0;
    double sessionOpen = 0.0;
    double sessionClose = 0.0;

    if(json['LastTradedPx'] != null && json['LastTradedPx'] is double){
      lastValue = json['LastTradedPx'] as double;
    }
    if(json['SessionOpen'] != null && json['SessionOpen'] is double){
      sessionOpen = json['SessionOpen'] as double;
    }
    if(json['SessionClose'] != null && json['SessionClose'] is double){
      sessionClose = json['SessionClose'] as double;
    }

    return CurrencyDetail(json['InstrumentId'], json['MarketId'], lastValue, sessionOpen, sessionClose);
  }

  double getPercentVariation(){
    var divisionValues = sessionClose/sessionOpen;
    var percentValue = (1 - divisionValues)* 100;

    return double.tryParse(percentValue.toStringAsFixed(2));
  }
}