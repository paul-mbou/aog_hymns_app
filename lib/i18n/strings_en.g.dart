///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	dynamic operator[](String key) => _meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations

	/// en: 'AOG Hymns'
	String get appTitle => 'AOG Hymns';

	/// en: 'Hymns'
	String get navHymns => 'Hymns';

	/// en: 'Favorites'
	String get navFavorites => 'Favorites';

	/// en: 'Settings'
	String get navSettings => 'Settings';

	/// en: 'Search number, title, or lyrics'
	String get searchHint => 'Search number, title, or lyrics';

	/// en: 'EN'
	String get languageEn => 'EN';

	/// en: 'FR'
	String get languageFr => 'FR';

	/// en: 'No hymns yet'
	String get emptyCatalogTitle => 'No hymns yet';

	/// en: 'This hymnbook is empty until songs are added to the AOG library.'
	String get emptyCatalogBody => 'This hymnbook is empty until songs are added to the AOG library.';

	/// en: 'The library could not be reached. Pull to refresh when you are back online.'
	String get offlineCatalogBody => 'The library could not be reached. Pull to refresh when you are back online.';

	/// en: 'Firebase is not configured for this build yet. Add the AOG project, then refresh.'
	String get firebaseSetupBody => 'Firebase is not configured for this build yet. Add the AOG project, then refresh.';

	/// en: 'No favorites yet'
	String get favoritesEmptyTitle => 'No favorites yet';

	/// en: 'Tap the heart on a hymn to keep it here.'
	String get favoritesEmptyBody => 'Tap the heart on a hymn to keep it here.';

	/// en: 'Untitled hymn'
	String get untitledHymn => 'Untitled hymn';

	/// en: 'The hymnbook could not be loaded.'
	String get couldNotLoad => 'The hymnbook could not be loaded.';

	/// en: 'Try again'
	String get retry => 'Try again';

	/// en: 'Lyrics'
	String get lyrics => 'Lyrics';

	/// en: 'Audio'
	String get audio => 'Audio';

	/// en: 'Score'
	String get score => 'Score';

	/// en: 'Projection'
	String get projection => 'Projection';

	/// en: 'Chorus'
	String get chorus => 'Chorus';

	/// en: 'Verse $n'
	String verse({required Object n}) => 'Verse ${n}';

	/// en: 'History'
	String get history => 'History';

	/// en: 'Play'
	String get play => 'Play';

	/// en: 'Pause'
	String get pause => 'Pause';

	/// en: 'No recording for this hymn.'
	String get noAudio => 'No recording for this hymn.';

	/// en: 'No sheet music for this hymn.'
	String get noScore => 'No sheet music for this hymn.';

	/// en: 'Download'
	String get download => 'Download';

	/// en: 'Open score'
	String get openScore => 'Open score';

	/// en: 'The file could not be downloaded.'
	String get mediaFailed => 'The file could not be downloaded.';

	/// en: 'Appearance'
	String get settingsTheme => 'Appearance';

	/// en: 'System'
	String get themeSystem => 'System';

	/// en: 'Light'
	String get themeLight => 'Light';

	/// en: 'Dark'
	String get themeDark => 'Dark';

	/// en: 'Text size'
	String get settingsText => 'Text size';

	/// en: 'Small'
	String get textSmall => 'Small';

	/// en: 'Medium'
	String get textMedium => 'Medium';

	/// en: 'Large'
	String get textLarge => 'Large';

	/// en: 'Language'
	String get settingsLanguage => 'Language';

	/// en: 'English'
	String get english => 'English';

	/// en: 'French'
	String get french => 'French';

	/// en: 'Refresh library'
	String get refreshLibrary => 'Refresh library';

	/// en: 'Clear downloads'
	String get clearDownloads => 'Clear downloads';

	/// en: 'About'
	String get about => 'About';

	/// en: 'FAQ'
	String get faq => 'FAQ';

	/// en: 'Library updated.'
	String get libraryUpdated => 'Library updated.';

	/// en: 'The library could not be refreshed. Your saved copy is unchanged.'
	String get libraryUpdateFailed => 'The library could not be refreshed. Your saved copy is unchanged.';

	/// en: 'Downloads cleared.'
	String get downloadsCleared => 'Downloads cleared.';

	/// en: 'AOG Hymns is the Assemblies of God hymnbook. Hymns stay on this device after the first download.'
	String get aboutBody => 'AOG Hymns is the Assemblies of God hymnbook. Hymns stay on this device after the first download.';

	/// en: 'What if the list is empty?'
	String get faqEmpty => 'What if the list is empty?';

	/// en: 'The catalog comes from your AOG library. An empty list means no songs have been published yet.'
	String get faqEmptyAnswer => 'The catalog comes from your AOG library. An empty list means no songs have been published yet.';

	/// en: 'Can I read offline?'
	String get faqOffline => 'Can I read offline?';

	/// en: 'Yes. After the first successful download, hymns, audio, and scores you opened stay on the device.'
	String get faqOfflineAnswer => 'Yes. After the first successful download, hymns, audio, and scores you opened stay on the device.';

	/// en: 'How do I switch language?'
	String get faqLanguage => 'How do I switch language?';

	/// en: 'Use EN / FR on the hymn list, or Language in Settings. A hymn only shows the languages it was written in.'
	String get faqLanguageAnswer => 'Use EN / FR on the hymn list, or Language in Settings. A hymn only shows the languages it was written in.';

	/// en: 'This hymn has no lyrics to project.'
	String get projectionEmpty => 'This hymn has no lyrics to project.';

	/// en: 'Close'
	String get close => 'Close';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appTitle' => 'AOG Hymns',
			'navHymns' => 'Hymns',
			'navFavorites' => 'Favorites',
			'navSettings' => 'Settings',
			'searchHint' => 'Search number, title, or lyrics',
			'languageEn' => 'EN',
			'languageFr' => 'FR',
			'emptyCatalogTitle' => 'No hymns yet',
			'emptyCatalogBody' => 'This hymnbook is empty until songs are added to the AOG library.',
			'offlineCatalogBody' => 'The library could not be reached. Pull to refresh when you are back online.',
			'firebaseSetupBody' => 'Firebase is not configured for this build yet. Add the AOG project, then refresh.',
			'favoritesEmptyTitle' => 'No favorites yet',
			'favoritesEmptyBody' => 'Tap the heart on a hymn to keep it here.',
			'untitledHymn' => 'Untitled hymn',
			'couldNotLoad' => 'The hymnbook could not be loaded.',
			'retry' => 'Try again',
			'lyrics' => 'Lyrics',
			'audio' => 'Audio',
			'score' => 'Score',
			'projection' => 'Projection',
			'chorus' => 'Chorus',
			'verse' => ({required Object n}) => 'Verse ${n}',
			'history' => 'History',
			'play' => 'Play',
			'pause' => 'Pause',
			'noAudio' => 'No recording for this hymn.',
			'noScore' => 'No sheet music for this hymn.',
			'download' => 'Download',
			'openScore' => 'Open score',
			'mediaFailed' => 'The file could not be downloaded.',
			'settingsTheme' => 'Appearance',
			'themeSystem' => 'System',
			'themeLight' => 'Light',
			'themeDark' => 'Dark',
			'settingsText' => 'Text size',
			'textSmall' => 'Small',
			'textMedium' => 'Medium',
			'textLarge' => 'Large',
			'settingsLanguage' => 'Language',
			'english' => 'English',
			'french' => 'French',
			'refreshLibrary' => 'Refresh library',
			'clearDownloads' => 'Clear downloads',
			'about' => 'About',
			'faq' => 'FAQ',
			'libraryUpdated' => 'Library updated.',
			'libraryUpdateFailed' => 'The library could not be refreshed. Your saved copy is unchanged.',
			'downloadsCleared' => 'Downloads cleared.',
			'aboutBody' => 'AOG Hymns is the Assemblies of God hymnbook. Hymns stay on this device after the first download.',
			'faqEmpty' => 'What if the list is empty?',
			'faqEmptyAnswer' => 'The catalog comes from your AOG library. An empty list means no songs have been published yet.',
			'faqOffline' => 'Can I read offline?',
			'faqOfflineAnswer' => 'Yes. After the first successful download, hymns, audio, and scores you opened stay on the device.',
			'faqLanguage' => 'How do I switch language?',
			'faqLanguageAnswer' => 'Use EN / FR on the hymn list, or Language in Settings. A hymn only shows the languages it was written in.',
			'projectionEmpty' => 'This hymn has no lyrics to project.',
			'close' => 'Close',
			_ => null,
		};
	}
}
