mixin ValidatorMixin {
  String? notEmpty(String? value, [String message = 'Insira um valor']) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }

  String? lessThan(String? value, int max,
      [String message = 'Valor muito alto']) {
    if (value != null && int.tryParse(value) != null) {
      if (int.parse(value) >= max) {
        return message;
      }
    }
    return null;
  }

  String? combine(List<String? Function()> validators) {
    for (final validator in validators) {
      final result = validator();
      if (result != null) {
        return result;
      }
    }
    return null;
  }
}
