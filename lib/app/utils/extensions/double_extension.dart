import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String getPercentFormat(){
    return (this?.toStringAsFixed(2) ?? '- ')+'%';
  }

  Color getColor() {
    if(this == null || this == 0.0){
      return Colors.grey;
    }
    else if(this < 0.0){
      return Colors.red;
    }
    else{
      return Colors.green;
    }
  }

  String formatCurrency(){
    final format = NumberFormat.currency(locale: "pt_BR",
        symbol: r"R$");
    return format.format(this);
  }
}