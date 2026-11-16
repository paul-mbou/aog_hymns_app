import 'package:aog_hymns_app/core/data/catalog_failure.dart';
import 'package:aog_hymns_app/core/theme/app_fonts.dart';
import 'package:aog_hymns_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class EmptyCatalog extends StatelessWidget {
  const EmptyCatalog({super.key, this.failure, this.title, this.body});

  final CatalogFailure? failure;
  final String? title;
  final String? body;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final message = switch (failure) {
      CatalogFailure.notConfigured => t.firebaseSetupBody,
      CatalogFailure.timeout || CatalogFailure.unavailable => t.offlineCatalogBody,
      null => body ?? t.emptyCatalogBody,
    };
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title ?? t.emptyCatalogTitle,
              textAlign: TextAlign.center,
              style: AppFonts.title(null, size: 24),
            ),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center, style: AppFonts.ui(null, size: 16)),
          ],
        ),
      ),
    );
  }
}
