import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/extensions/context_extension.dart';

class ModuleInfoDialogWidget extends StatelessWidget {
  final String titleKey;
  final String bodyKey;
  final Map<String, String> replacements;

  const ModuleInfoDialogWidget({
    super.key,
    required this.titleKey,
    required this.bodyKey,
    this.replacements = const {},
  });

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(
      appTranslation().get(titleKey),
      style: TextStylesManager.subtitle,
    ),
    content: Text(_translatedBody),
    actions: [
      TextButton(
        onPressed: () => context.pop,
        child: Text(appTranslation().get('close')),
      ),
    ],
  );

  String get _translatedBody => replacements.entries.fold(
    appTranslation().get(bodyKey),
    (text, entry) => text.replaceAll('{${entry.key}}', entry.value),
  );
}
