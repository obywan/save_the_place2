// ignore_for_file: unused_element, unused_field, camel_case_types, annotate_overrides, prefer_single_quotes
// GENERATED FILE, do not edit!
import 'package:i69n/i69n.dart' as i69n;
import 'translations.i69n.dart';

String get _languageCode => 'uk';
String get _localeName => 'uk';

String _plural(int count,
        {String? zero,
        String? one,
        String? two,
        String? few,
        String? many,
        String? other}) =>
    i69n.plural(count, _languageCode,
        zero: zero, one: one, two: two, few: few, many: many, other: other);
String _ordinal(int count,
        {String? zero,
        String? one,
        String? two,
        String? few,
        String? many,
        String? other}) =>
    i69n.ordinal(count, _languageCode,
        zero: zero, one: one, two: two, few: few, many: many, other: other);
String _cardinal(int count,
        {String? zero,
        String? one,
        String? two,
        String? few,
        String? many,
        String? other}) =>
    i69n.cardinal(count, _languageCode,
        zero: zero, one: one, two: two, few: few, many: many, other: other);

class Translations_uk extends Translations {
  const Translations_uk();
  PageTitlesTranslations_uk get pageTitles => PageTitlesTranslations_uk(this);
  MessagesTranslations_uk get messages => MessagesTranslations_uk(this);
  DialogsTranslations_uk get dialogs => DialogsTranslations_uk(this);
  GeneralTranslations_uk get general => GeneralTranslations_uk(this);
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'pageTitles':
        return pageTitles;
      case 'messages':
        return messages;
      case 'dialogs':
        return dialogs;
      case 'general':
        return general;
      default:
        return super[key];
    }
  }
}

class PageTitlesTranslations_uk extends PageTitlesTranslations {
  final Translations_uk _parent;
  const PageTitlesTranslations_uk(this._parent) : super(_parent);
  String get homePageTitle => "Домашня сторінка";
  String get addNewPageTitle => "Додати локацію";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'homePageTitle':
        return homePageTitle;
      case 'addNewPageTitle':
        return addNewPageTitle;
      default:
        return super[key];
    }
  }
}

class MessagesTranslations_uk extends MessagesTranslations {
  final Translations_uk _parent;
  const MessagesTranslations_uk(this._parent) : super(_parent);
  String get errorMessage => "Хммм, щось не так =/";
  String get copied => "скопійовано";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'errorMessage':
        return errorMessage;
      case 'copied':
        return copied;
      default:
        return super[key];
    }
  }
}

class DialogsTranslations_uk extends DialogsTranslations {
  final Translations_uk _parent;
  const DialogsTranslations_uk(this._parent) : super(_parent);
  String get deleteTite => "Видалити локацію";
  String get areYouSureText => "Ви впевнені?";
  String get positiveAnswer => "Так";
  String get negativeAnswer => "Ні";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'deleteTite':
        return deleteTite;
      case 'areYouSureText':
        return areYouSureText;
      case 'positiveAnswer':
        return positiveAnswer;
      case 'negativeAnswer':
        return negativeAnswer;
      default:
        return super[key];
    }
  }
}

class GeneralTranslations_uk extends GeneralTranslations {
  final Translations_uk _parent;
  const GeneralTranslations_uk(this._parent) : super(_parent);
  String get noItemsInList => "Список збережених локацій буде тут";
  String get distance => "Відстань";
  String get waitingForLocation => "Визначаємо координати...";
  String get currentLocation => "Поточні координати";
  String get addImage => "Додати зображення";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'noItemsInList':
        return noItemsInList;
      case 'distance':
        return distance;
      case 'waitingForLocation':
        return waitingForLocation;
      case 'currentLocation':
        return currentLocation;
      case 'addImage':
        return addImage;
      default:
        return super[key];
    }
  }
}
