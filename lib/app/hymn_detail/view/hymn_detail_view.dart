import 'package:aog_hymns_app/app/hymn_detail/viewmodel/hymn_detail_view_model.dart';
import 'package:aog_hymns_app/app/projection/view/projection_view.dart';
import 'package:aog_hymns_app/app/settings/viewmodel/settings_view_model.dart';
import 'package:aog_hymns_app/core/theme/app_fonts.dart';
import 'package:aog_hymns_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_file/open_file.dart';
import 'package:pdfx_lite/pdfx_lite.dart';

class HymnDetailView extends ConsumerWidget {
  const HymnDetailView({super.key, required this.hymnId});

  final String hymnId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final detail = ref.watch(hymnDetailViewModelProvider(hymnId));
    final favorite = ref.watch(
      settingsViewModelProvider.select((s) => s.favoriteIds.contains(hymnId)),
    );
    return detail.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (_, _) => Scaffold(body: Center(child: Text(t.couldNotLoad))),
      data: (state) {
        final lyric = state.lyric;
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                lyric.displayNumber.isEmpty
                    ? lyric.songTitle
                    : lyric.displayNumber,
              ),
              actions: [
                IconButton(
                  onPressed: () => ref
                      .read(settingsViewModelProvider.notifier)
                      .toggleFavorite(hymnId),
                  icon: Icon(favorite ? Icons.favorite : Icons.favorite_border),
                ),
              ],
              bottom: TabBar(
                isScrollable: true,
                tabs: [
                  Tab(text: t.lyrics),
                  Tab(text: t.audio),
                  Tab(text: t.score),
                  Tab(text: t.projection),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                _LyricsTab(hymnId: hymnId),
                _AudioTab(hymnId: hymnId),
                _ScoreTab(hymnId: hymnId),
                _ProjectionEntry(hymnId: hymnId),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LyricsTab extends ConsumerWidget {
  const _LyricsTab({required this.hymnId});
  final String hymnId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final lyric = ref.watch(
      hymnDetailViewModelProvider(hymnId)
          .select((async) => async.asData?.value.lyric),
    );
    if (lyric == null) return const SizedBox.shrink();
    final scale = ref.watch(
      settingsViewModelProvider.select((s) => s.textScale),
    );
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(lyric.songTitle, style: AppFonts.title(null, size: 32 * scale)),
        if (lyric.author.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(lyric.author, style: AppFonts.ui(null, size: 16 * scale)),
        ],
        const SizedBox(height: 20),
        for (var i = 0; i < lyric.verses.length; i++) ...[
          Text(
            t.verse(n: i + 1),
            style: AppFonts.ui(null, weight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          _RichText(text: lyric.verses[i], scale: scale),
          const SizedBox(height: 16),
        ],
        if (lyric.chorus.trim().isNotEmpty) ...[
          Text(t.chorus, style: AppFonts.ui(null, weight: FontWeight.w700)),
          const SizedBox(height: 6),
          _RichText(text: lyric.chorus, scale: scale),
        ],
        if (lyric.hasHistory) ...[
          const SizedBox(height: 20),
          Text(t.history, style: AppFonts.ui(null, weight: FontWeight.w700)),
          _RichText(text: lyric.history, scale: scale),
        ],
      ],
    );
  }
}

class _RichText extends StatelessWidget {
  const _RichText({required this.text, required this.scale});
  final String text;
  final double scale;

  @override
  Widget build(BuildContext context) {
    if (text.contains('<')) {
      return Html(data: text);
    }
    return Text(text, style: AppFonts.ui(null, size: 18 * scale));
  }
}

class _AudioTab extends ConsumerWidget {
  const _AudioTab({required this.hymnId});
  final String hymnId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final state = ref.watch(hymnDetailViewModelProvider(hymnId)).asData?.value;
    if (state == null) return const SizedBox.shrink();
    final notifier = ref.read(hymnDetailViewModelProvider(hymnId).notifier);
    if (state.lyric.audioUrl.isEmpty && state.audioPath == null) {
      return Center(child: Text(t.noAudio));
    }
    final total = state.duration.inMilliseconds == 0
        ? 1
        : state.duration.inMilliseconds;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (state.mediaError != null) Text(t.mediaFailed),
          Slider(
            value: state.position.inMilliseconds.clamp(0, total).toDouble(),
            max: total.toDouble(),
            onChanged: (value) =>
                notifier.seek(Duration(milliseconds: value.round())),
          ),
          FilledButton(
            onPressed: state.downloadingAudio ? null : notifier.togglePlayback,
            child: Text(
              state.downloadingAudio
                  ? t.download
                  : (state.playing ? t.pause : t.play),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreTab extends ConsumerWidget {
  const _ScoreTab({required this.hymnId});
  final String hymnId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final state = ref.watch(hymnDetailViewModelProvider(hymnId)).asData?.value;
    if (state == null) return const SizedBox.shrink();
    if (state.lyric.partitionUrl.isEmpty && state.scorePath == null) {
      return Center(child: Text(t.noScore));
    }
    return Center(
      child: FilledButton(
        onPressed: state.downloadingScore
            ? null
            : () async {
                final path = await ref
                    .read(hymnDetailViewModelProvider(hymnId).notifier)
                    .ensureScore();
                if (path != null && context.mounted) {
                  await Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => ScoreReader(path: path),
                    ),
                  );
                }
              },
        child: Text(state.downloadingScore ? t.download : t.openScore),
      ),
    );
  }
}

class ScoreReader extends StatefulWidget {
  const ScoreReader({super.key, required this.path});

  final String path;

  @override
  State<ScoreReader> createState() => _ScoreReaderState();
}

class _ScoreReaderState extends State<ScoreReader> {
  late final PdfControllerPinch _controller = PdfControllerPinch(
    document: PdfDocument.openFile(widget.path),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translations.of(context).score),
        actions: [
          IconButton(
            onPressed: () => OpenFile.open(widget.path),
            icon: const Icon(Icons.open_in_new),
          ),
        ],
      ),
      body: PdfViewPinch(controller: _controller),
    );
  }
}

class _ProjectionEntry extends ConsumerWidget {
  const _ProjectionEntry({required this.hymnId});
  final String hymnId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final lyric = ref.watch(
      hymnDetailViewModelProvider(hymnId)
          .select((async) => async.asData?.value.lyric),
    );
    if (lyric == null) return const SizedBox.shrink();
    return Center(
      child: FilledButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => ProjectionView(lyric: lyric),
            ),
          );
        },
        child: Text(t.projection),
      ),
    );
  }
}
