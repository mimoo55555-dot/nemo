import 'package:flutter/material.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/more_modules_section_header_widget.dart';

class MoreModulesSectionWidget extends StatelessWidget {
  final String titleKey;
  final List<Widget> tiles;

  const MoreModulesSectionWidget({
    super.key,
    required this.titleKey,
    required this.tiles,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      MoreModulesSectionHeaderWidget(titleKey: titleKey),
      Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var index = 0; index < tiles.length; index++) ...[
              if (index > 0)
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(72, 0, 16, 0),
                  child: Divider(height: 1),
                ),
              tiles[index],
            ],
          ],
        ),
      ),
    ],
  );
}
