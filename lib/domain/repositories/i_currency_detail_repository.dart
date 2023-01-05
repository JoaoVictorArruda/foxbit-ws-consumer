import 'package:joao_foxbit_test/domain/entities/currency/currency_detail.dart';
import 'package:joao_foxbit_test/domain/usecases/currency_detail_usecase.dart';

abstract class ICurrencyDetailRepository {
  Future<List<CurrencyDetail>> getCurrencyDetails(CurrencyDetailUseCaseParams params);
}
