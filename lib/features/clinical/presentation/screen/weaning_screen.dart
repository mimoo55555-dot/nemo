import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/utils/clinical_calculators.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/weaning_checklist_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/weaning_measurements_section_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/weaning_patient_header_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/weaning_rsbi_card_widget.dart';

class WeaningScreen extends StatefulWidget {
  final Patient patient;

  const WeaningScreen({super.key, required this.patient});

  @override
  State<WeaningScreen> createState() => _WeaningScreenState();
}

class _WeaningScreenState extends State<WeaningScreen> {
  int _spontaneousRate = 20;
  double _spontaneousVtMl = 380;
  int _nifCmH2O = -28;
  bool _gasExchangeAcceptable = true;
  bool _hemodynamicStable = true;
  bool _mentalStatusAlert = true;
  bool _airwayCuffLeakPositive = true;

  @override
  Widget build(BuildContext context) {
    final rsbi = ClinicalCalculators.calculateRSBI(
      _spontaneousRate,
      _spontaneousVtMl,
    );

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WeaningPatientHeaderWidget(patient: widget.patient),
            verticalSpace16,
            WeaningRsbiCardWidget(rsbi: rsbi),
            verticalSpace16,
            WeaningMeasurementsSectionWidget(
              respiratoryRate: _spontaneousRate,
              tidalVolume: _spontaneousVtMl,
              inspiratoryForce: _nifCmH2O,
              onRespiratoryRateChanged: (value) =>
                  setState(() => _spontaneousRate = value),
              onTidalVolumeChanged: (value) =>
                  setState(() => _spontaneousVtMl = value),
              onInspiratoryForceChanged: (value) =>
                  setState(() => _nifCmH2O = value),
            ),
            verticalSpace16,
            WeaningChecklistWidget(
              gasExchangeAcceptable: _gasExchangeAcceptable,
              hemodynamicStable: _hemodynamicStable,
              mentalStatusAlert: _mentalStatusAlert,
              airwayCuffLeakPositive: _airwayCuffLeakPositive,
              onGasExchangeChanged: (value) => setState(
                () => _gasExchangeAcceptable = value ?? false,
              ),
              onHemodynamicChanged: (value) => setState(
                () => _hemodynamicStable = value ?? false,
              ),
              onMentalStatusChanged: (value) => setState(
                () => _mentalStatusAlert = value ?? false,
              ),
              onCuffLeakChanged: (value) => setState(
                () => _airwayCuffLeakPositive = value ?? false,
              ),
            ),
            verticalSpace32,
          ],
        ),
      ),
    );
  }
}
