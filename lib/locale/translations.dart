import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

///
/// Storage related
///
const String _storageKey = "MyApplication_";
const List<String> _supportedLanguages = ['en', 'br', 'vn', 'hi'];
final GetStorage getStorage = GetStorage();

class GlobalTranslations {
  Locale _locale;
  Map<dynamic, dynamic> _localizedValues;
  VoidCallback _onLocaleChangedCallback;

  ///
  /// Returns the list of supported Locales
  ///
  Iterable<Locale> supportedLocales() =>
      _supportedLanguages.map<Locale>((lang) => new Locale(lang, ''));

  ///
  /// Returns the translation that corresponds to the [key]
  ///
  String text(String key) {
    // Return the requested string
    return (_localizedValues == null || _localizedValues[key] == null)
        ? '** $key not found'
        : _localizedValues[key];
  }

  ///
  /// Returns the current language code
  ///
  get currentLanguage => _locale == null ? '' : _locale.languageCode;

  ///
  /// Returns the current Locale
  ///
  get locale => _locale;

  ///
  /// One-time initialization
  ///
  init([String language]) async {
    if (_locale == null) {
      await setNewLanguage(language);
    }
    return null;
  }

  /// ----------------------------------------------------------
  /// Method that saves/restores the preferred language
  /// ----------------------------------------------------------
  String getPreferredLanguage() {
    return _getApplicationSavedInformation('language');
  }

  setPreferredLanguage(String lang) {
    return _setApplicationSavedInformation('language', lang);
  }

  ///
  /// Routine to change the language
  ///
  setNewLanguage([String newLanguage, bool saveInPrefs = false]) async {
    String language = newLanguage;
    if (language == null) {
      language = getPreferredLanguage();
    }

    // Set the locale
    if (language == "") {
      language = "en";
    }
    _locale = Locale(language, "");

    // Load the language strings
    String jsonContent = await rootBundle
        .loadString("lib/locale/i18n_${_locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);

    // If we are asked to save the new language in the application preferences
    if (saveInPrefs) {
      await setPreferredLanguage(language);
    }

    // If there is a callback to invoke to notify that a language has changed
    if (_onLocaleChangedCallback != null) {
      _onLocaleChangedCallback();
    }

    return null;
  }

  ///
  /// Callback to be invoked when the user changes the language
  ///
  set onLocaleChangedCallback(VoidCallback callback) {
    _onLocaleChangedCallback = callback;
  }

  ///
  /// Application Preferences related
  ///
  /// ----------------------------------------------------------
  /// Generic routine to fetch an application preference
  /// ----------------------------------------------------------
  String _getApplicationSavedInformation(String name) {
    return getStorage.read(_storageKey + name) ?? '';
  }

  /// ----------------------------------------------------------
  /// Generic routine to saves an application preference
  /// ----------------------------------------------------------
  _setApplicationSavedInformation(String name, String value) {
    return getStorage.write(_storageKey + name, value);
  }

  ///
  /// Singleton Factory
  ///
  static final GlobalTranslations _translations =
      new GlobalTranslations._internal();
  factory GlobalTranslations() {
    return _translations;
  }
  GlobalTranslations._internal();
}

GlobalTranslations string = new GlobalTranslations();
