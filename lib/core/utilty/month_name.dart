import 'package:demo/generated/locale_keys.g.dart';

extension MonthName on int {
  String montName() {
    switch (this) {
      case 1:
        return LocaleKeys.ocak;
      case 2:
        return LocaleKeys.subat;
      case 3:
        return LocaleKeys.mart;
      case 4:
        return LocaleKeys.nisan;
      case 5:
        return LocaleKeys.mayis;
      case 6:
        return LocaleKeys.haziran;
      case 7:
        return LocaleKeys.temmuz;
      case 8:
        return LocaleKeys.agustos;
      case 9:
        return LocaleKeys.eylul;
      case 10:
        return LocaleKeys.ekim;
      case 11:
        return LocaleKeys.kasim;
      case 12:
        return LocaleKeys.aralik;
    }
    return "";
  }
}
