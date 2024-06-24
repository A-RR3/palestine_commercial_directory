

class ValidationUtils {
  static String? validateIsEmpty(String? value, String msg) {
    return (value == null || value.isEmpty) ? msg : null;
  }

  static String? validatePhone(String? value) {
    if (value != null) {
      int digits = value.length;
      if (digits > 15 || digits < 10) {
        return 'الرجاء ادخال رقم هاتف صحيح';
        // return LangKeys.VALID_PHONE_MSG.tr();
      }
    }
    return null;
  }
  // static bool isEmailValid(String email) {
  //   final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  //   return emailRegex.hasMatch(email);
  // }
}
