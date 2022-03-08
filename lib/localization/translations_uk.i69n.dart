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
  PermissionMessagesTranslations_uk get permissionMessages =>
      PermissionMessagesTranslations_uk(this);
  MessagesTranslations_uk get messages => MessagesTranslations_uk(this);
  DialogsTranslations_uk get dialogs => DialogsTranslations_uk(this);
  GeneralTranslations_uk get general => GeneralTranslations_uk(this);
  NewPlaceFormTranslations_uk get newPlaceForm =>
      NewPlaceFormTranslations_uk(this);
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'pageTitles':
        return pageTitles;
      case 'permissionMessages':
        return permissionMessages;
      case 'messages':
        return messages;
      case 'dialogs':
        return dialogs;
      case 'general':
        return general;
      case 'newPlaceForm':
        return newPlaceForm;
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
  String get compassPageTitle => "Компас";
  String get accountPageTitle => "Обліковий запис";
  String get settingsPageTitle => "Налаштування";
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
      case 'compassPageTitle':
        return compassPageTitle;
      case 'accountPageTitle':
        return accountPageTitle;
      case 'settingsPageTitle':
        return settingsPageTitle;
      default:
        return super[key];
    }
  }
}

class PermissionMessagesTranslations_uk extends PermissionMessagesTranslations {
  final Translations_uk _parent;
  const PermissionMessagesTranslations_uk(this._parent) : super(_parent);
  String get locationPermissionNeeded =>
      "Потрібен дозвіл використовувати геолокацію";
  String get locationShouldBeEnabled =>
      "Потрібно, щоб геолокація була ввімкнутою";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'locationPermissionNeeded':
        return locationPermissionNeeded;
      case 'locationShouldBeEnabled':
        return locationShouldBeEnabled;
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
  String get save => "Зберегти";
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
      case 'save':
        return save;
      default:
        return super[key];
    }
  }
}

class NewPlaceFormTranslations_uk extends NewPlaceFormTranslations {
  final Translations_uk _parent;
  const NewPlaceFormTranslations_uk(this._parent) : super(_parent);
  String get lat => "Широта";
  String get lon => "Довгота";
  String get elev => "Висота";
  String get name => "Ім'я";
  String get description => "Опис";
  String get required => "(обов'язково)";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'lat':
        return lat;
      case 'lon':
        return lon;
      case 'elev':
        return elev;
      case 'name':
        return name;
      case 'description':
        return description;
      case 'required':
        return required;
      default:
        return super[key];
    }
  }
}
