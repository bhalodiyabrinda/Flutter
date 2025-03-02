import 'package:get/get.dart';

import 'quote_model.dart';
import 'quote_service.dart';

class QuoteController extends GetxController {
  RxList<Quote> quotes = RxList.empty();

  @override
  void onInit() {
    super.onInit();
    fetchDetails();
  }

  fetchDetails() async {
    quotes.clear();
    quotes.addAll(await QuoteService.fetchQuote());
  }
}
