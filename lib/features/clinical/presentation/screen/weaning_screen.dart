import 'package:flutter/material.dart';
import 'package:nemoventrt/core/models/patient.dart';
import 'package:nemoventrt/core/theme/text_styles.dart';
import 'package:nemoventrt/core/utils/clinical_calculators.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/weaning_checklist_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/weaning_patient_header_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/weaning_rsbi_card_widget.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/weaning_stepper_widget.dart';

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
            Text(
              appTranslation().get('spontaneous_measurements'),
              style: TextStylesManager.sectionTitle,
            ),
            verticalSpace8,
            WeaningStepperWidget(
              titleKey: 'spontaneous_rate',
              value:
                  '$_spontaneousRate ${appTranslation().get('breaths_per_minute')}',
              onDecrement: () => setState(
                () => _spontaneousRate = (_spontaneousRate - 1).clamp(6, 50),
              ),
              onIncrement: () => setState(
                () => _spontaneousRate = (_spontaneousRate + 1).clamp(6, 50),
              ),
            ),
            WeaningStepperWidget(
              titleKey: 'spontaneous_tidal_volume',
              value: '${_spontaneousVtMl.toInt()} mL',
              onDecrement: () => setState(
                () =>
                    _spontaneousVtMl = (_spontaneousVtMl - 10).clamp(100, 900),
              ),
              onIncrement: () => setState(
                () =>
                    _spontaneousVtMl = (_spontaneousVtMl + 10).clamp(100, 900),
              ),
            ),
            WeaningStepperWidget(
              titleKey: 'negative_inspiratory_force',
              value: '$_nifCmH2O cmH2O',
              onDecrement: () => setState(
                () => _nifCmH2O = (_nifCmH2O - 2).clamp(-60, 0),
              ),
              onIncrement: () => setState(
                () => _nifCmH2O = (_nifCmH2O + 2).clamp(-60, 0),
              ),
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
