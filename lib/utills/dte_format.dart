import 'package:intl/intl.dart';

class DateFormatMethods {
  //14 Apiril 2024 04:44 PM
  getFormatDateTimeFromDateTime(DateTime dateTime) {
    return DateFormat('dd MMMM yyyy hh:mm a').format(dateTime.toLocal());
  }

  //14 Apiril 2024 04:44 PM
  getFormatDateTimeFromString(String dateTime) {
    return DateFormat('dd MMMM yyyy hh:mm a')
        .format(DateTime.parse(dateTime).toLocal());
  }

  //14 April 2024
  getFormatDateFromDateTime(DateTime dateTime) {
    return DateFormat('dd MMMM yyyy').format(dateTime.toLocal());
  }

  // 12:44 PM
  getFormatTimeFromDateTime(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime.toLocal());
  }

  //50,000,20,000
  getFormattedPrice({int? price, bool isTagRight = false}) {
    final formattedPrice = NumberFormat("#,##0", "en_US").format(price);
    if (isTagRight)
      return "$formattedPrice Rs";
    else
      return "Rs $formattedPrice";
  }
}
