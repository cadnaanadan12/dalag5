import 'package:flutter/foundation.dart';
import '../l10n/app_strings.dart';

/// Maamulaha luuqadda: si loo bedelo Ingiriisi <-> Soomaali meel kasta
/// oo application-ka ah, isticmaal LanguageProvider.
class LanguageProvider extends ChangeNotifier {
  String _langCode = 'en'; // 'en' = English, 'so' = Somali

  String get langCode => _langCode;
  bool get isSomali => _langCode == 'so';

  /// t('key') -> soo celisa qoraalka luuqadda hadda la doortay.
  String t(String key) {
    return AppStrings.values[_langCode]?[key] ??
        AppStrings.values['en']?[key] ??
        key;
  }

  void toggleLanguage() {
    _langCode = _langCode == 'en' ? 'so' : 'en';
    notifyListeners();
  }

  void setLanguage(String code) {
    if (_langCode == code) return;
    _langCode = code;
    notifyListeners();
  }
}