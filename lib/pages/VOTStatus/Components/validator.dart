class Validator {
  static String? validateDropdownField(String value) {
    if (value.isEmpty || value == '-') {
      return "Required Field";
    }

    return null;
  }

}