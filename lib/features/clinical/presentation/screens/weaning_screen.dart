import 'package:flutter/material.dart';
import 'package:nemoventrt/core/utils/clinical_calculators.dart';
import 'package:nemoventrt/features/clinical/domain/entities/patient.dart';

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
    final isRsbiReady = rsbi < 105;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Patient Weaning Banner
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.amber.shade50,
                    child: Icon(Icons.psychology, color: Colors.amber.shade800),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.patient.bed} · Weaning & SBT Assessment',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '${widget.patient.fullName} · Intubation: ${widget.patient.intubationDate}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // RSBI Gauge Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isRsbiReady ? Colors.teal.shade50 : Colors.red.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isRsbiReady
                      ? Colors.teal.shade300
                      : Colors.red.shade300,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Rapid Shallow Breathing Index',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'RSBI = f / Vt(L) (Threshold < 105)',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isRsbiReady ? Colors.teal : Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          isRsbiReady ? 'READY TO WEAN' : 'NOT READY',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${rsbi.toInt()}',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: isRsbiReady
                          ? Colors.teal.shade800
                          : Colors.red.shade800,
                    ),
                  ),
                  Text(
                    isRsbiReady
                        ? 'Patient exhibits favorable mechanical efficiency for trial.'
                        : 'Rapid shallow breathing present; elevated work of breathing risk.',
                    style: TextStyle(
                      fontSize: 12,
                      color: isRsbiReady
                          ? Colors.teal.shade900
                          : Colors.red.shade900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Spontaneous Mechanics Sliders
            const Text(
              'Spontaneous Breathing Mechanics',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Spontaneous Rate
            _buildStepper(
              label: 'Spontaneous Rate (f)',
              value: '$_spontaneousRate breaths/min',
              onDecrement: () => setState(
                () => _spontaneousRate = (_spontaneousRate - 1).clamp(6, 50),
              ),
              onIncrement: () => setState(
                () => _spontaneousRate = (_spontaneousRate + 1).clamp(6, 50),
              ),
            ),

            // Spontaneous Tidal Volume
            _buildStepper(
              label: 'Spontaneous Tidal Volume (Vt)',
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

            // Negative Inspiratory Force (NIF)
            _buildStepper(
              label: 'Negative Inspiratory Force (NIF)',
              value: '$_nifCmH2O cmH2O',
              onDecrement: () =>
                  setState(() => _nifCmH2O = (_nifCmH2O - 2).clamp(-60, 0)),
              onIncrement: () =>
                  setState(() => _nifCmH2O = (_nifCmH2O + 2).clamp(-60, 0)),
            ),

            const SizedBox(height: 16),

            // Readiness Checklist
            const Text(
              'Extubation Readiness Criteria',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            CheckboxListTile(
              title: const Text(
                'Adequate Gas Exchange (PaO2 ≥ 60 on FiO2 ≤ 40%, PEEP ≤ 8)',
                style: TextStyle(fontSize: 13),
              ),
              value: _gasExchangeAcceptable,
              onChanged: (v) =>
                  setState(() => _gasExchangeAcceptable = v ?? false),
              activeColor: const Color(0xFF0D9488),
            ),
            CheckboxListTile(
              title: const Text(
                'Hemodynamic Stability (No vasopressors or low-dose stable)',
                style: TextStyle(fontSize: 13),
              ),
              value: _hemodynamicStable,
              onChanged: (v) => setState(() => _hemodynamicStable = v ?? false),
              activeColor: const Color(0xFF0D9488),
            ),
            CheckboxListTile(
              title: const Text(
                'Neurological Readiness (Arousal, obeys commands, cough present)',
                style: TextStyle(fontSize: 13),
              ),
              value: _mentalStatusAlert,
              onChanged: (v) => setState(() => _mentalStatusAlert = v ?? false),
              activeColor: const Color(0xFF0D9488),
            ),
            CheckboxListTile(
              title: const Text(
                'Positive Cuff Leak Test (Patent subglottic airway)',
                style: TextStyle(fontSize: 13),
              ),
              value: _airwayCuffLeakPositive,
              onChanged: (v) =>
                  setState(() => _airwayCuffLeakPositive = v ?? false),
              activeColor: const Color(0xFF0D9488),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildStepper({
    required String label,
    required String value,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline, size: 22),
                onPressed: onDecrement,
              ),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color(0xFF0D9488),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline, size: 22),
                onPressed: onIncrement,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
