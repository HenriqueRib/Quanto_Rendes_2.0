import 'package:intl/intl.dart';

class Formatters {
  static final _currencyFormat = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
    decimalDigits: 2,
  );

  static final _decimalFormat = NumberFormat.decimalPattern('pt_BR');
  
  static final _dateFormat = DateFormat('dd/MM/yyyy', 'pt_BR');
  static final _dateTimeFormat = DateFormat('dd/MM/yyyy HH:mm', 'pt_BR');
  static final _monthYearFormat = DateFormat('MMM/yy', 'pt_BR');

  static String currency(double value) {
    return _currencyFormat.format(value);
  }

  static String decimal(double value, {int decimalDigits = 2}) {
    return value.toStringAsFixed(decimalDigits).replaceAll('.', ',');
  }

  static String number(double value) {
    return _decimalFormat.format(value);
  }

  static String km(double value) {
    return '${_decimalFormat.format(value)} km';
  }

  static String liters(double value) {
    return '${decimal(value)} L';
  }

  static String kmPerLiter(double value) {
    return '${decimal(value)} km/L';
  }

  static String pricePerLiter(double value) {
    return '${currency(value)}/L';
  }

  static String date(DateTime date) {
    return _dateFormat.format(date);
  }

  static String dateTime(DateTime date) {
    return _dateTimeFormat.format(date);
  }

  static String monthYear(DateTime date) {
    return _monthYearFormat.format(date);
  }

  static String relativeDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      return 'Hoje';
    } else if (diff.inDays == 1) {
      return 'Ontem';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} dias atrás';
    } else if (diff.inDays < 30) {
      final weeks = (diff.inDays / 7).floor();
      return weeks == 1 ? '1 semana atrás' : '$weeks semanas atrás';
    } else if (diff.inDays < 365) {
      final months = (diff.inDays / 30).floor();
      return months == 1 ? '1 mês atrás' : '$months meses atrás';
    } else {
      return _dateFormat.format(date);
    }
  }
}
