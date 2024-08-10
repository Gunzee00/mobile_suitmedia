import 'package:flutter/foundation.dart';

class PalindromeProvider with ChangeNotifier {
  String _name = '';
  String _sentence = '';
  bool _isPalindrome = false;

  String get name => _name;
  String get sentence => _sentence;
  bool get isPalindrome => _isPalindrome;

  void setName(String newName) {
    _name = newName;
    notifyListeners();
  }

  void setSentence(String newSentence) {
    _sentence = newSentence;
    _isPalindrome = _checkPalindrome(newSentence);
    notifyListeners();
  }

  bool _checkPalindrome(String sentence) {
    final sanitized = sentence.replaceAll(RegExp(r'[\W_]+'), '').toLowerCase();
    return sanitized == sanitized.split('').reversed.join('');
  }

 
  void updateName(String newName) {
    setName(newName);
  }
}
