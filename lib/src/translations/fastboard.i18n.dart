import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static final _t = Translations.byLocale('en') +
      {
        'en': {
          'Retry': 'Retry',
          'Exit': 'Exit',
          'Loading': 'loading…',
          'Init Sdk Error': 'init sdk error, check your config',
          'Room Error': 'room error, click and retry',
        },
        'zh_CN': {
          'Retry': '重试',
          'Exit': '退出',
          'Loading': '加载中…',
          'Init Sdk Error': '初始化失败，请检查配置',
          'Room Error': '房间异常，点击重试',
        },
      };

  String get i18n => localize(this, _t);
}
