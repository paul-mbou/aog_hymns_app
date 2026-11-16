import 'package:aog_hymns_app/app/favorites/view/favorites_view.dart';
import 'package:aog_hymns_app/app/hymn_list/view/hymn_list_view.dart';
import 'package:aog_hymns_app/app/settings/view/settings_view.dart';
import 'package:aog_hymns_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  var _index = 0;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _index,
          children: const [HymnListView(), FavoritesView(), SettingsView()],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (index) => setState(() => _index = index),
        destinations: [
          NavigationDestination(icon: const Icon(LucideIcons.bookOpen), label: t.navHymns),
          NavigationDestination(icon: const Icon(LucideIcons.heart), label: t.navFavorites),
          NavigationDestination(icon: const Icon(LucideIcons.settings), label: t.navSettings),
        ],
      ),
    );
  }
}
