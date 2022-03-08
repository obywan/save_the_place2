// ignore_for_file: unused_element, unused_field, camel_case_types, annotate_overrides, prefer_single_quotes
// GENERATED FILE, do not edit!
import 'package:i69n/i69n.dart' as i69n;

String get _languageCode => 'en';
String get _localeName => 'en';

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

class Translations implements i69n.I69nMessageBundle {
  const Translations();
  PageTitlesTranslations get pageTitles => PageTitlesTranslations(this);
  PermissionMessagesTranslations get permissionMessages =>
      PermissionMessagesTranslations(this);
  MessagesTranslations get messages => MessagesTranslations(this);
  DialogsTranslations get dialogs => DialogsTranslations(this);
  GeneralTranslations get general => GeneralTranslations(this);
  NewPlaceFormTranslations get newPlaceForm => NewPlaceFormTranslations(this);
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
        return key;
    }
  }
}

class PageTitlesTranslations implements i69n.I69nMessageBundle {
  final Translations _parent;
  const PageTitlesTranslations(this._parent);
  String get homePageTitle => "Home page";
  String get addNewPageTitle => "Add new place";
  String get compassPageTitle => "Add new place";
  String get accountPageTitle => "Account";
  String get settingsPageTitle => "Settings";
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
        return key;
    }
  }
}

class PermissionMessagesTranslations implements i69n.I69nMessageBundle {
  final Translations _parent;
  const PermissionMessagesTranslations(this._parent);
  String get locationPermissionNeeded =>
      "We need location permission to proceed";
  String get locationShouldBeEnabled => "We need location enabled to proceed";
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
        return key;
    }
  }
}

class MessagesTranslations implements i69n.I69nMessageBundle {
  final Translations _parent;
  const MessagesTranslations(this._parent);
  String get errorMessage => "Hmmm, something wrong =/";
  String get copied => "copied";
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
        return key;
    }
  }
}

class DialogsTranslations implements i69n.I69nMessageBundle {
  final Translations _parent;
  const DialogsTranslations(this._parent);
  String get deleteTite => "Delete place";
  String get areYouSureText => "Are you sure?";
  String get positiveAnswer => "Yep";
  String get negativeAnswer => "Nope";
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
        return key;
    }
  }
}

class GeneralTranslations implements i69n.I69nMessageBundle {
  final Translations _parent;
  const GeneralTranslations(this._parent);
  String get noItemsInList => "Locations list will be here";
  String get distance => "distance";
  String get waitingForLocation => "Waiting for current location...";
  String get currentLocation => "current location";
  String get addImage => "Add image";
  String get save => "Save";
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
        return key;
    }
  }
}

class NewPlaceFormTranslations implements i69n.I69nMessageBundle {
  final Translations _parent;
  const NewPlaceFormTranslations(this._parent);
  String get lat => "Latitude";
  String get lon => "Longitude";
  String get elev => "Elevation";
  String get name => "Name";
  String get description => "Description";
  String get required => "(required)";
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
        return key;
    }
  }
}
