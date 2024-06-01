import 'dart:math';

class PasswordService {
  String generatePassword({int length = 16}) {
    const lowerCase = 'abcdefghijklmnopqrstuvwxyz';
    const upperCase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const numbers = '0123456789';
    const special = '@#\$%^&*(),.?":{}|<>';

    final allChars = lowerCase + upperCase + numbers + special;
    final rand = Random.secure();
    final password = List.generate(length, (index) {
      final randomIndex = rand.nextInt(allChars.length);
      return allChars[randomIndex];
    }).join();

    return password;
  }
}
