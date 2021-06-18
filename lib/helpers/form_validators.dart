class FormValidators {
  static String? notEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }
}
