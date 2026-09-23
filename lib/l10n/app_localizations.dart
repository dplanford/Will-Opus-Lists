import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Will-Opus Lists'**
  String get appTitle;

  /// No description provided for @baseError.
  ///
  /// In en, this message translates to:
  /// **'ERROR'**
  String get baseError;

  /// No description provided for @standardError.
  ///
  /// In en, this message translates to:
  /// **'Error! Something went wrong!'**
  String get standardError;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteQuery.
  ///
  /// In en, this message translates to:
  /// **'Delete List \"@\"?'**
  String get deleteQuery;

  /// No description provided for @screenTitleAddItem.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get screenTitleAddItem;

  /// No description provided for @screenTitleEditItem.
  ///
  /// In en, this message translates to:
  /// **'Edit Item'**
  String get screenTitleEditItem;

  /// No description provided for @itemTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Item Title'**
  String get itemTitleLabel;

  /// No description provided for @itemTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a title'**
  String get itemTitleHint;

  /// No description provided for @itemDescLabel.
  ///
  /// In en, this message translates to:
  /// **'Item Description'**
  String get itemDescLabel;

  /// No description provided for @itemDescHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a description'**
  String get itemDescHint;

  /// No description provided for @itemDeleteQuery.
  ///
  /// In en, this message translates to:
  /// **'Delete This Item?'**
  String get itemDeleteQuery;

  /// No description provided for @listEmpty.
  ///
  /// In en, this message translates to:
  /// **'No items added to this list yet.'**
  String get listEmpty;

  /// No description provided for @listErrNoObj.
  ///
  /// In en, this message translates to:
  /// **'ERROR - no list object associated with this key!'**
  String get listErrNoObj;

  /// No description provided for @createListSelectTitle.
  ///
  /// In en, this message translates to:
  /// **'Select List Title'**
  String get createListSelectTitle;

  /// No description provided for @createListSelectColor.
  ///
  /// In en, this message translates to:
  /// **'Select List Color'**
  String get createListSelectColor;

  /// No description provided for @editListAdd.
  ///
  /// In en, this message translates to:
  /// **'Add New List'**
  String get editListAdd;

  /// No description provided for @editListUpdate.
  ///
  /// In en, this message translates to:
  /// **'Update List'**
  String get editListUpdate;

  /// No description provided for @masterNoLists.
  ///
  /// In en, this message translates to:
  /// **'No lists yet!'**
  String get masterNoLists;

  /// No description provided for @masterErrObj.
  ///
  /// In en, this message translates to:
  /// **'Error - Missing or Mismatched Master List!'**
  String get masterErrObj;

  /// No description provided for @masterMissingListForId.
  ///
  /// In en, this message translates to:
  /// **'Missing object for ID.'**
  String get masterMissingListForId;

  /// No description provided for @snackbarItemAdded.
  ///
  /// In en, this message translates to:
  /// **'Item Added!'**
  String get snackbarItemAdded;

  /// No description provided for @snackbarItemAddFailed.
  ///
  /// In en, this message translates to:
  /// **'Item failed to add...'**
  String get snackbarItemAddFailed;

  /// No description provided for @snackbarItemUpdated.
  ///
  /// In en, this message translates to:
  /// **'Item Updated!'**
  String get snackbarItemUpdated;

  /// No description provided for @snackbarItemUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Item failed to update...'**
  String get snackbarItemUpdateFailed;

  /// No description provided for @snackbarListUpdated.
  ///
  /// In en, this message translates to:
  /// **'List \"@\" Updated'**
  String get snackbarListUpdated;

  /// No description provided for @snackbarListUpdateErr.
  ///
  /// In en, this message translates to:
  /// **'List \"@\" failed to update.'**
  String get snackbarListUpdateErr;

  /// No description provided for @snackbarListDeleted.
  ///
  /// In en, this message translates to:
  /// **'List \"@\" Removed'**
  String get snackbarListDeleted;

  /// No description provided for @snackbarListDeleteErr.
  ///
  /// In en, this message translates to:
  /// **'List \"@\" failed to remove.'**
  String get snackbarListDeleteErr;

  /// No description provided for @snackbarListNoId.
  ///
  /// In en, this message translates to:
  /// **'ERROR - List has no id!'**
  String get snackbarListNoId;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
