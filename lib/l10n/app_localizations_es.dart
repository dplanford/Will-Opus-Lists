// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Will-Opus Listas';

  @override
  String get baseError => 'ERROR';

  @override
  String get standardError => 'Error! Algo salió mal!';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get deleteQuery => '¿Eliminar \"@\"?';

  @override
  String get screenTitleAddItem => 'Añadir Elemento';

  @override
  String get screenTitleEditItem => 'Editar Elemento';

  @override
  String get itemTitleLabel => 'Título del artículo';

  @override
  String get itemTitleHint => 'Introduce un título';

  @override
  String get itemDescLabel => 'Descripción del artículo';

  @override
  String get itemDescHint => 'Introduce una descripción';

  @override
  String get itemDeleteQuery => '¿Eliminar este elemento?';

  @override
  String get listEmpty => 'Aún no se han añadido elementos a esta lista.';

  @override
  String get listErrNoObj =>
      'ERROR - No hay ningún objeto de lista asociado a este ID!';

  @override
  String get createListSelectTitle => 'Seleccionar título de la lista';

  @override
  String get createListSelectColor => 'Seleccionar color de la lista';

  @override
  String get editListAdd => 'Añadir nueva lista';

  @override
  String get editListUpdate => 'Actualizar lista';

  @override
  String get masterNoLists => '¡Todavía no hay listas!';

  @override
  String get masterErrObj => 'Error: ¡Falta la lista maestra o no coincide!';

  @override
  String get masterMissingListForId => 'Falta el objeto para el ID.';

  @override
  String get snackbarItemAdded => 'Artículo añadido!';

  @override
  String get snackbarItemAddFailed => 'No se pudo añadir el artículo...';

  @override
  String get snackbarItemUpdated => 'Elemento actualizado!';

  @override
  String get snackbarItemUpdateFailed => 'No se pudo actualizar el elemento...';

  @override
  String get snackbarListUpdated => 'Lista \"@\" actualizada';

  @override
  String get snackbarListUpdateErr => 'La lista \"@\" no se pudo actualizar.';

  @override
  String get snackbarListDeleted => 'Se ha eliminado la lista \"@\".';

  @override
  String get snackbarListDeleteErr => 'No se pudo eliminar la lista \"@\".';

  @override
  String get snackbarListNoId => 'ERROR - ¡La lista no tiene ID!';
}
