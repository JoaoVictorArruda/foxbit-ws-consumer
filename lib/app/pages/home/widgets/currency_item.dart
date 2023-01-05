import 'package:flutter/material.dart';
import 'package:joao_foxbit_test/app/utils/styles/custom_text_styles.dart';
import 'package:joao_foxbit_test/domain/entities/currency/currency.dart';
import 'package:joao_foxbit_test/domain/entities/currency/currency_detail.dart';
import 'package:joao_foxbit_test/app/utils/extensions/double_extension.dart';

class CurrencyItemContainer extends StatelessWidget {
  final CurrencyModel currencyModel;
  final CurrencyDetail currencyDetail;
  const CurrencyItemContainer({Key key, @required this.currencyModel, this.currencyDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 12,
                  spreadRadius: 1,
                )
              ]
          ),
          width: double.infinity,
          height: 80,
          child: Row(
            children: [
              Flexible(
                  flex: 2,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 22, 6, 22),
                        key: Key('asset_${currencyModel.instrumentId}'),
                        child: Image.asset('assets/images/${currencyModel.instrumentId}.png'),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(getDescriptionName(currencyModel.instrumentId),
                              style: CustomTextStyles.boldBlackText.copyWith(fontSize: 18)
                          ),
                          Text(currencyModel.symbol,
                            style: CustomTextStyles.boldBlackText.copyWith(fontSize: 16, fontWeight: FontWeight.w400)
                          )
                        ],
                      )
                    ],
                  )
              ),
              Flexible(
                flex: 1,
                child: Builder(
                    builder: (context) {
                      if(currencyDetail != null) {
                        var percentValue = currencyDetail.getPercentVariation();
                        return Text(
                          percentValue.getPercentFormat(),
                          style: CustomTextStyles.boldBlackText.copyWith(fontSize: 18, color: percentValue.getColor()),
                          textAlign: TextAlign.end,
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                }

                ),
              ),
              Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Builder(
                          builder: (context) {
                            if(currencyDetail != null) {
                              return Text(
                                currencyDetail.lastValue.formatCurrency(),
                                style: CustomTextStyles.boldBlackText.copyWith(fontSize: 22),
                                textAlign: TextAlign.end,
                              );
                            }
                            return const CircularProgressIndicator();
                          }
                      ),
                    ],
                  )
              )
            ],
          )
      ),
    );
  }

  String getDescriptionName(int id){
    switch(id) {
      case 1:
        return "Bitcoin";
      case 2:
        return "Litecoin";
      case 4:
        return "Ethereum";
      case 6:
        return "TrueUSD";
      case 10:
        return "XRP";
      default:
        return "";
    }
  }

}
