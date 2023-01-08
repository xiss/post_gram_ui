class Converter {
  static bool? intToNullableBool(int? input) {
    if (input == null) return null;
    return input == 0 ? false : true;
  }

  static bool intToBool(int input) {
    return input == 0 ? false : true;
  }
}
