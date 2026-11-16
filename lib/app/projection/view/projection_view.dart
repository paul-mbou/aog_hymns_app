import 'package:aog_hymns_app/core/model/lyric.dart';
import 'package:aog_hymns_app/core/theme/app_fonts.dart';
import 'package:aog_hymns_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProjectionSlide {
  const ProjectionSlide({required this.label, required this.text});
  final String label;
  final String text;
}

List<ProjectionSlide> buildProjectionSlides(Lyric lyric, Translations t) {
  final slides = <ProjectionSlide>[];
  void addSection(String label, String raw) {
    final lines = _lines(raw);
    for (var i = 0; i < lines.length; i += 2) {
      final chunk = i + 1 < lines.length ? '${lines[i]}\n${lines[i + 1]}' : lines[i];
      slides.add(ProjectionSlide(label: label, text: chunk));
    }
  }

  if (lyric.verses.isNotEmpty) addSection(t.verse(n: 1), lyric.verses.first);
  if (_lines(lyric.chorus).isNotEmpty) addSection(t.chorus, lyric.chorus);
  for (var i = 1; i < lyric.verses.length; i++) {
    addSection(t.verse(n: i + 1), lyric.verses[i]);
  }
  return slides;
}

class ProjectionView extends StatefulWidget {
  const ProjectionView({super.key, required this.lyric});
  final Lyric lyric;

  @override
  State<ProjectionView> createState() => _ProjectionViewState();
}

class _ProjectionViewState extends State<ProjectionView> {
  final _controller = PageController();
  var _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final slides = buildProjectionSlides(widget.lyric, t);
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        title: Text(widget.lyric.songTitle),
        actions: [
          IconButton(
            onPressed: () {
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
            },
            icon: const Icon(Icons.fullscreen),
          ),
        ],
      ),
      body: slides.isEmpty
          ? Center(child: Text(t.projectionEmpty, style: AppFonts.ui(null, size: 18)))
          : PageView.builder(
              controller: _controller,
              itemCount: slides.length,
              onPageChanged: (index) => setState(() => _index = index),
              itemBuilder: (context, index) {
                final slide = slides[index];
                return Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(slide.label, style: AppFonts.ui(null, color: scheme.primary)),
                      const Spacer(),
                      Text(slide.text, style: AppFonts.title(null, size: 36)),
                      const Spacer(),
                      Text('${index + 1} / ${slides.length}', style: AppFonts.ui(null)),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: slides.length < 2
          ? null
          : NavigationBar(
              selectedIndex: _index.clamp(0, slides.length - 1),
              destinations: [
                for (var i = 0; i < slides.length && i < 5; i++)
                  NavigationDestination(icon: const Icon(Icons.circle), label: '${i + 1}'),
              ],
              onDestinationSelected: (index) {
                _controller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                );
              },
            ),
    );
  }
}

List<String> _lines(String raw) {
  return raw
      .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
      .replaceAll(RegExp(r'<[^>]*>'), '')
      .replaceAll('&nbsp;', ' ')
      .split('\n')
      .map((line) => line.trim())
      .where((line) => line.isNotEmpty)
      .toList();
}
