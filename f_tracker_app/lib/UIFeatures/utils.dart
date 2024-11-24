class Global {
  static isSafe(value) {
    return value != null;
  }

  static firstCap(String val) {
    return val[0].toUpperCase() + val.substring(1);
  }

  static bool isEmpty(value) {
    if (value is String || value is List || value is Map) {
      return value.isEmpty;
    }

    return !Global.isSafe(value);
  }

  static String formattedDate(DateTime date) {
    final ref = DateTime.now();
    final elapsedDays = ref.difference(date).inDays.abs();
    var rValue = 'Several years ago';

    if (elapsedDays == 0) {
      rValue = 'Just now';
    } else if (elapsedDays < 7) {
      rValue = 'A week ago';
    } else if (elapsedDays < 31) {
      rValue = 'A month ago';
    } else if (elapsedDays < 365) {
      rValue = '${(elapsedDays / 30).ceil()} months ago';
    } else {
      final elapsedYears = (elapsedDays / 365).ceil();
      if (elapsedYears < 25) rValue = '$elapsedYears years ago';
    }
    return rValue;
  }
}
