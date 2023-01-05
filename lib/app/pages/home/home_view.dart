import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:joao_foxbit_test/app/pages/home/home_controller.dart';
import 'package:joao_foxbit_test/app/pages/home/widgets/currency_item.dart';
import 'package:joao_foxbit_test/app/utils/styles/custom_text_styles.dart';
import 'package:joao_foxbit_test/domain/entities/currency/currency.dart';
import 'package:joao_foxbit_test/domain/entities/currency/currency_detail.dart';

class HomePage extends View {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends ViewState<HomePage, HomeController> {
  HomePageState() : super(HomeController());

  @override
  Widget get view => Scaffold(
    key: globalKey,
    backgroundColor: Colors.grey[100],
    appBar: AppBar(
      title: const Text('Cotação', style: CustomTextStyles.title,),
      centerTitle: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    body: ControlledWidgetBuilder<HomeController>(builder: (_, controller) {
      if (controller.currencies.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView.builder(
          itemCount: controller.currencies.length,
          itemBuilder: (_, index) {
            final CurrencyModel asset = controller.currencies[index];
            final CurrencyDetail currencyDetail = controller.currenciesDetails.firstWhere((element) => element.instrumentId == asset.instrumentId, orElse: () => null);
            return CurrencyItemContainer(currencyModel: asset, currencyDetail: currencyDetail,);
          });
    }),
  );
}
