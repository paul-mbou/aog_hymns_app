import 'package:aog_hymns_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class FaqView extends StatelessWidget {
  const FaqView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.faq)),
      body: ListView(
        children: [
          ExpansionTile(title: Text(t.faqEmpty), children: [ListTile(title: Text(t.faqEmptyAnswer))]),
          ExpansionTile(title: Text(t.faqOffline), children: [ListTile(title: Text(t.faqOfflineAnswer))]),
          ExpansionTile(title: Text(t.faqLanguage), children: [ListTile(title: Text(t.faqLanguageAnswer))]),
        ],
      ),
    );
  }
}
