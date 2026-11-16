import 'package:aog_hymns_app/app/shell/view/home_shell.dart';
import 'package:aog_hymns_app/app/splash/viewmodel/splash_view_model.dart';
import 'package:aog_hymns_app/core/theme/app_fonts.dart';
import 'package:aog_hymns_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashView extends ConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(splashViewModelProvider, (previous, next) {
      if (next.hasValue && previous?.hasValue != true) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder<void>(
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (_, _, _) => const HomeShell(),
            transitionsBuilder: (_, animation, _, child) =>
                FadeTransition(opacity: animation, child: child),
          ),
        );
      }
    });
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset('assets/logo.png', width: 180, height: 180),
            ),
            const SizedBox(height: 24),
            Text(Translations.of(context).appTitle, style: AppFonts.title(null, size: 32)),
          ],
        ),
      ),
    );
  }
}
