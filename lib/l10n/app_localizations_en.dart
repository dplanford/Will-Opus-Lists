// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Will-Opus Lists';

  @override
  String get baseError => 'ERROR';

  @override
  String get standardError => 'Error! Something went wrong!';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get deleteQuery => 'Delete List \"@\"?';

  @override
  String get screenTitleAddItem => 'Add Item';

  @override
  String get screenTitleEditItem => 'Edit Item';

  @override
  String get itemTitleLabel => 'Item Title';

  @override
  String get itemTitleHint => 'Enter a title';

  @override
  String get itemDescLabel => 'Item Description';

  @override
  String get itemDescHint => 'Enter a description';

  @override
  String get itemDeleteQuery => 'Delete This Item?';

  @override
  String get listEmpty => 'No items added to this list yet.';

  @override
  String get listErrNoObj => 'ERROR - no list object associated with this key!';

  @override
  String get createListSelectTitle => 'Select List Title';

  @override
  String get createListSelectColor => 'Select List Color';

  @override
  String get editListAdd => 'Add New List';

  @override
  String get editListUpdate => 'Update List';

  @override
  String get masterNoLists => 'No lists yet!';

  @override
  String get masterErrObj => 'Error - Missing or Mismatched Master List!';

  @override
  String get masterMissingListForId => 'Missing object for ID.';

  @override
  String get snackbarItemAdded => 'Item Added!';

  @override
  String get snackbarItemAddFailed => 'Item failed to add...';

  @override
  String get snackbarItemUpdated => 'Item Updated!';

  @override
  String get snackbarItemUpdateFailed => 'Item failed to update...';

  @override
  String get snackbarListUpdated => 'List \"@\" Updated';

  @override
  String get snackbarListUpdateErr => 'List \"@\" failed to update.';

  @override
  String get snackbarListDeleted => 'List \"@\" Removed';

  @override
  String get snackbarListDeleteErr => 'List \"@\" failed to remove.';

  @override
  String get snackbarListNoId => 'ERROR - List has no id!';
}
