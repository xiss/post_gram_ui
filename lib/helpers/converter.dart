class Converter {
  static bool? intToBool(int? input) {
    if (input == null) return null;
    return input == 0 ? false : true;
  }
}
