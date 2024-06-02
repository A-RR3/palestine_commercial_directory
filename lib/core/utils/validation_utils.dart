class ValidationUtils {
  static String? validateIsEmpty(String? value, String msg) {
    return (value == null || value.isEmpty) ? msg : null;
  }
  // static bool isEmailValid(String email) {
  //   final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  //   return emailRegex.hasMatch(email);
  // }
}
