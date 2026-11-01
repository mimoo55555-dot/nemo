import 'package:flutter/material.dart';
import 'package:nemoventrt/core/utils/constants/primary/primary_search_field_widget.dart';

class PatientCensusSearchWidget extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const PatientCensusSearchWidget({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(20, 4, 20, 4),
    child: PrimarySearchFieldWidget(
      hintKey: 'search_census_hint',
      onChanged: onChanged,
    ),
  );
}
