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
}
