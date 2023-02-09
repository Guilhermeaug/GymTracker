import 'package:flutter/cupertino.dart';

class FormUtils {
  static void resetForm(GlobalKey<FormState> formKey) {
    formKey.currentState?.save();
    formKey.currentState?.reset();
  }
}
