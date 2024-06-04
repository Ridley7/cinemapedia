
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class HumanFormats{

  static String shortDate( DateTime date ) {
    initializeDateFormatting();
    final format = DateFormat.yMMMEd('es');
    return format.format(date);
  }

  static String number(double number, [int decimals = 0]){

    final String formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: decimals,
      symbol: '',
      locale: 'en'
    ).format(number);

    return formattedNumber;
  }


}