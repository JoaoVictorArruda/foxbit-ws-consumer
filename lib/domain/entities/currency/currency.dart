class CurrencyModel {
  final int omsId;
  final int instrumentId;
  final String symbol;

  CurrencyModel({
    this.omsId,
    this.instrumentId,
    this.symbol,
  });

  static CurrencyModel fromJson(Map<String, dynamic> json){
    return CurrencyModel(
      omsId: json["OMSId"] != null ? json["OMSId"] as int: 0,
      instrumentId: json["InstrumentId"] != null ? json["InstrumentId"] as int: 0,
      symbol: json["Symbol"] != null ? json["Symbol"] as String: '',
    );
  }


  static List<CurrencyModel> fromJsonList(List<dynamic> json){
    var list = <CurrencyModel>[];
    for(int i = 0;i < json.length;i++) {
     if([1,2,4,6,10].contains(json[i]["InstrumentId"])) {
        var item = CurrencyModel.fromJson(json[i] as Map<String, dynamic>);
        list.add(item);
      }
    }
    list.sort((a,b) => a.instrumentId.compareTo(b.instrumentId));
    return list;
  }
}