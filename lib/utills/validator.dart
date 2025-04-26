class FieldValidator {
  static String? validateEmail(String ?value) {
    if (value!.isEmpty) {
      return "Enter email";
    }
    if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return "Invalid email";
    }
    if (value.contains(" ")) {
      return "Invalid email";
    }
    return null;
  }

  static String? validatePassword(String ?value) {
    if (value!.isEmpty) return "Please enter your password";
    return null;
  }

  static String? validateUsername(String ?value) {
    if (value!.isEmpty) return "Please enter your password";
    return null;
  }

  static String? validateFullname(String ?value) {
    if (value!.isEmpty) return "Please enter your password";
    return null;
  }
  static String? validateAddress(String ?value) {
    if (value!.isEmpty) return "Please enter address";
    return null;
  }

  static String? validatePhoneNumber(String ?value) {
    if (value!.isEmpty) return "Please enter phone number";
    if(value.length>14) return "Enter validate number";
    return null;
  }


  //;;

}