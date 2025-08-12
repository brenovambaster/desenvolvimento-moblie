class ValidatorUtils {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Por favor, digite seu e-mail';
    }
    // Regex para validação de e-mail genérico
    final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(email)) {
      return 'E-mail inválido';
    }
    return null;
  }

}