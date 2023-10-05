import 'package:demo/core/utilty/month_name.dart';

extension DateTimeStr on DateTime? {
  String str() {
    DateTime time = this ?? DateTime.now();
    return "${time.day} ${time.month.montName()} ${time.year}";
  }
}
