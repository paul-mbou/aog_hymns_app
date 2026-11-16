///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsFr extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsFr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fr>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsFr _root = this; // ignore: unused_field

	@override 
	TranslationsFr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsFr(meta: meta ?? this.$meta);

	// Translations
	@override String get appTitle => 'Cantiques AOG';
	@override String get navHymns => 'Cantiques';
	@override String get navFavorites => 'Favoris';
	@override String get navSettings => 'Réglages';
	@override String get searchHint => 'Numéro, titre ou paroles';
	@override String get languageEn => 'EN';
	@override String get languageFr => 'FR';
	@override String get emptyCatalogTitle => 'Aucun cantique';
	@override String get emptyCatalogBody => 'Ce recueil restera vide tant que des cantiques n’auront pas été ajoutés à la bibliothèque AOG.';
	@override String get offlineCatalogBody => 'La bibliothèque est injoignable. Tirez vers le bas pour réessayer une fois en ligne.';
	@override String get firebaseSetupBody => 'Firebase n’est pas encore configuré pour cette version. Ajoutez le projet AOG, puis actualisez.';
	@override String get favoritesEmptyTitle => 'Aucun favori';
	@override String get favoritesEmptyBody => 'Touchez le cœur d’un cantique pour le retrouver ici.';
	@override String get untitledHymn => 'Cantique sans titre';
	@override String get couldNotLoad => 'Le recueil n’a pas pu être chargé.';
	@override String get retry => 'Réessayer';
	@override String get lyrics => 'Paroles';
	@override String get audio => 'Audio';
	@override String get score => 'Partition';
	@override String get projection => 'Projection';
	@override String get chorus => 'Refrain';
	@override String verse({required Object n}) => 'Couplet ${n}';
	@override String get history => 'Histoire';
	@override String get play => 'Lecture';
	@override String get pause => 'Pause';
	@override String get noAudio => 'Pas d’enregistrement pour ce cantique.';
	@override String get noScore => 'Pas de partition pour ce cantique.';
	@override String get download => 'Télécharger';
	@override String get openScore => 'Ouvrir la partition';
	@override String get mediaFailed => 'Le fichier n’a pas pu être téléchargé.';
	@override String get settingsTheme => 'Apparence';
	@override String get themeSystem => 'Système';
	@override String get themeLight => 'Clair';
	@override String get themeDark => 'Sombre';
	@override String get settingsText => 'Taille du texte';
	@override String get textSmall => 'Petite';
	@override String get textMedium => 'Moyenne';
	@override String get textLarge => 'Grande';
	@override String get settingsLanguage => 'Langue';
	@override String get english => 'Anglais';
	@override String get french => 'Français';
	@override String get refreshLibrary => 'Actualiser la bibliothèque';
	@override String get clearDownloads => 'Effacer les téléchargements';
	@override String get about => 'À propos';
	@override String get faq => 'FAQ';
	@override String get libraryUpdated => 'Bibliothèque mise à jour.';
	@override String get libraryUpdateFailed => 'La bibliothèque n’a pas pu être actualisée. La copie enregistrée est inchangée.';
	@override String get downloadsCleared => 'Téléchargements effacés.';
	@override String get aboutBody => 'Cantiques AOG est le recueil des Assemblées de Dieu. Les cantiques restent sur l’appareil après le premier téléchargement.';
	@override String get faqEmpty => 'Et si la liste est vide ?';
	@override String get faqEmptyAnswer => 'Le catalogue vient de votre bibliothèque AOG. Une liste vide signifie qu’aucun cantique n’a encore été publié.';
	@override String get faqOffline => 'Puis-je lire hors ligne ?';
	@override String get faqOfflineAnswer => 'Oui. Après le premier téléchargement réussi, les cantiques, l’audio et les partitions déjà ouverts restent sur l’appareil.';
	@override String get faqLanguage => 'Comment changer de langue ?';
	@override String get faqLanguageAnswer => 'Utilisez EN / FR sur la liste, ou Langue dans les réglages. Un cantique n’affiche que les langues dans lesquelles il a été écrit.';
	@override String get projectionEmpty => 'Ce cantique n’a pas de paroles à projeter.';
	@override String get close => 'Fermer';
}

/// The flat map containing all translations for locale <fr>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsFr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appTitle' => 'Cantiques AOG',
			'navHymns' => 'Cantiques',
			'navFavorites' => 'Favoris',
			'navSettings' => 'Réglages',
			'searchHint' => 'Numéro, titre ou paroles',
			'languageEn' => 'EN',
			'languageFr' => 'FR',
			'emptyCatalogTitle' => 'Aucun cantique',
			'emptyCatalogBody' => 'Ce recueil restera vide tant que des cantiques n’auront pas été ajoutés à la bibliothèque AOG.',
			'offlineCatalogBody' => 'La bibliothèque est injoignable. Tirez vers le bas pour réessayer une fois en ligne.',
			'firebaseSetupBody' => 'Firebase n’est pas encore configuré pour cette version. Ajoutez le projet AOG, puis actualisez.',
			'favoritesEmptyTitle' => 'Aucun favori',
			'favoritesEmptyBody' => 'Touchez le cœur d’un cantique pour le retrouver ici.',
			'untitledHymn' => 'Cantique sans titre',
			'couldNotLoad' => 'Le recueil n’a pas pu être chargé.',
			'retry' => 'Réessayer',
			'lyrics' => 'Paroles',
			'audio' => 'Audio',
			'score' => 'Partition',
			'projection' => 'Projection',
			'chorus' => 'Refrain',
			'verse' => ({required Object n}) => 'Couplet ${n}',
			'history' => 'Histoire',
			'play' => 'Lecture',
			'pause' => 'Pause',
			'noAudio' => 'Pas d’enregistrement pour ce cantique.',
			'noScore' => 'Pas de partition pour ce cantique.',
			'download' => 'Télécharger',
			'openScore' => 'Ouvrir la partition',
			'mediaFailed' => 'Le fichier n’a pas pu être téléchargé.',
			'settingsTheme' => 'Apparence',
			'themeSystem' => 'Système',
			'themeLight' => 'Clair',
			'themeDark' => 'Sombre',
			'settingsText' => 'Taille du texte',
			'textSmall' => 'Petite',
			'textMedium' => 'Moyenne',
			'textLarge' => 'Grande',
			'settingsLanguage' => 'Langue',
			'english' => 'Anglais',
			'french' => 'Français',
			'refreshLibrary' => 'Actualiser la bibliothèque',
			'clearDownloads' => 'Effacer les téléchargements',
			'about' => 'À propos',
			'faq' => 'FAQ',
			'libraryUpdated' => 'Bibliothèque mise à jour.',
			'libraryUpdateFailed' => 'La bibliothèque n’a pas pu être actualisée. La copie enregistrée est inchangée.',
			'downloadsCleared' => 'Téléchargements effacés.',
			'aboutBody' => 'Cantiques AOG est le recueil des Assemblées de Dieu. Les cantiques restent sur l’appareil après le premier téléchargement.',
			'faqEmpty' => 'Et si la liste est vide ?',
			'faqEmptyAnswer' => 'Le catalogue vient de votre bibliothèque AOG. Une liste vide signifie qu’aucun cantique n’a encore été publié.',
			'faqOffline' => 'Puis-je lire hors ligne ?',
			'faqOfflineAnswer' => 'Oui. Après le premier téléchargement réussi, les cantiques, l’audio et les partitions déjà ouverts restent sur l’appareil.',
			'faqLanguage' => 'Comment changer de langue ?',
			'faqLanguageAnswer' => 'Utilisez EN / FR sur la liste, ou Langue dans les réglages. Un cantique n’affiche que les langues dans lesquelles il a été écrit.',
			'projectionEmpty' => 'Ce cantique n’a pas de paroles à projeter.',
			'close' => 'Fermer',
			_ => null,
		};
	}
}
