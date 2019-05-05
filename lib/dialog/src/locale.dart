import 'package:flutter/material.dart';

class FLibDialogLocale {
  FLibDialogLocale._();

  static String cancel(BuildContext context, {Locale locale}) {
    return _LibLocale(context, locale).cancel();
  }

  static String confirm(BuildContext context, {Locale locale}) {
    return _LibLocale(context, locale).confirm();
  }

  static String tips(BuildContext context, {Locale locale}) {
    return _LibLocale(context, locale).tips();
  }
}

abstract class _LibLocale {
  factory _LibLocale(BuildContext context, Locale locale) {
    if (locale == null && context != null) {
      locale = Localizations.localeOf(context);
    }

    if (locale != null) {
      if ('en' == locale.languageCode) {
        return _LibLocal_EN();
      } else if ('zh' == locale.languageCode) {
        if ('TW' == locale.countryCode || 'HK' == locale.countryCode) {
          return _LibLocale_ZH_TW();
        }
      }
    }

    return _LibLocale_ZH_CN();
  }

  String cancel();

  String confirm();

  String tips();

  String pleaseSelect();
}

class _LibLocale_ZH_CN implements _LibLocale {
  String cancel() {
    return '取消';
  }

  String confirm() {
    return '确定';
  }

  String tips() {
    return '提示';
  }

  @override
  String pleaseSelect() {
    return '请选择';
  }
}

class _LibLocale_ZH_TW implements _LibLocale {
  String cancel() {
    return '取消';
  }

  String confirm() {
    return '確定';
  }

  String tips() {
    return '提示';
  }

  @override
  String pleaseSelect() {
    return '請選擇';
  }
}

class _LibLocal_EN implements _LibLocale {
  @override
  String cancel() {
    return 'Cancel';
  }

  @override
  String confirm() {
    return 'Confirm';
  }

  @override
  String tips() {
    return 'Tips';
  }

  @override
  String pleaseSelect() {
    return 'Please select';
  }
}
