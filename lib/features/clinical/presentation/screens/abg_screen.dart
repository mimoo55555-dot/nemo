import 'package:flutter/material.dart';
import 'package:nemoventrt/core/di/injection_container.dart';
import 'package:nemoventrt/core/utils/clinical_calculators.dart';
import 'package:nemoventrt/features/clinical/domain/entities/patient.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/add_abg_result_usecase.dart';

class ABGScreen extends StatefulWidget {
  final Patient patient;

  const ABGScreen({super.key, required this.patient});

  @override
  State<ABGScreen> createState() => _ABGScreenState();
}

class _ABGScreenState extends State<ABGScreen> {
  double _ph = 7.34;
  double _paCo2 = 48.0;
  double _paO2 = 68.0;
  double _hco3 = 25.0;
  double _be = -1.2;
  double _fio2 = 65.0;

  bool _isAdding = false;

  @override
  void initState() {
    super.initState();
    if (widget.patient.recentABGs.isNotEmpty) {
      final latest = widget.patient.recentABGs.first;
      _ph = latest.ph;
      _paCo2 = latest.paCo2;
      _paO2 = latest.paO2;
      _hco3 = latest.hco3;
      _be = latest.baseExcess;
      _fio2 = latest.fio2;
    } else {
      _fio2 = widget.patient.ventilatorSettings.fio2;
    }
  }

  @override
  Widget build(BuildContext context) {
    final interp = ClinicalCalculators.interpretABG(
      ph: _ph,
      paCo2: _paCo2,
      paO2: _paO2,
      hco3: _hco3,
      fio2: _fio2,
    );

    final pfRatio = interp['pfRatio'] as double;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Patient Header Card
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
                    backgroundColor: Colors.purple.shade50,
                    child: const Icon(Icons.science, color: Colors.purple),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.patient.bed} · ABG Blood Gas Lab',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '${widget.patient.fullName} (${widget.patient.mrn})',
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

            // Diagnostic Interpretation Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0D9488).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF0D9488).withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Automated Clinical Interpretation',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D9488),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D9488),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'P/F: ${pfRatio.toInt()}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    interp['primaryDiagnosis'] as String,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${interp['compensation']} · ${interp['oxygenationStatus']}',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Blood Gas Parameters Grid
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.3,
              children: [
                _buildAbgTile(
                  'pH',
                  _ph.toStringAsFixed(2),
                  '7.35-7.45',
                  _ph < 7.35 || _ph > 7.45,
                ),
                _buildAbgTile(
                  'PaCO2',
                  '${_paCo2.toInt()}',
                  '35-45 mmHg',
                  _paCo2 < 35 || _paCo2 > 45,
                ),
                _buildAbgTile(
                  'PaO2',
                  '${_paO2.toInt()}',
                  '80-100 mmHg',
                  _paO2 < 60,
                ),
                _buildAbgTile(
                  'HCO3',
                  _hco3.toStringAsFixed(1),
                  '22-26 mEq/L',
                  _hco3 < 22 || _hco3 > 26,
                ),
                _buildAbgTile(
                  'Base Excess',
                  _be.toStringAsFixed(1),
                  '-2 to +2',
                  _be.abs() > 2,
                ),
                _buildAbgTile(
                  'FiO2',
                  '${_fio2.toInt()}%',
                  'Current vent',
                  false,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Sliders for interactive simulation
            const Text(
              'Interactive ABG Values',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            _buildAbgSlider(
              label: 'pH',
              value: _ph,
              min: 6.90,
              max: 7.70,
              divisions: 80,
              onChanged: (v) =>
                  setState(() => _ph = double.parse(v.toStringAsFixed(2))),
            ),
            _buildAbgSlider(
              label: 'PaCO2 (mmHg)',
              value: _paCo2,
              min: 15,
              max: 95,
              divisions: 80,
              onChanged: (v) => setState(() => _paCo2 = v.roundToDouble()),
            ),
            _buildAbgSlider(
              label: 'PaO2 (mmHg)',
              value: _paO2,
              min: 30,
              max: 300,
              divisions: 270,
              onChanged: (v) => setState(() => _paO2 = v.roundToDouble()),
            ),
            _buildAbgSlider(
              label: 'HCO3 (mEq/L)',
              value: _hco3,
              min: 10,
              max: 45,
              divisions: 35,
              onChanged: (v) =>
                  setState(() => _hco3 = double.parse(v.toStringAsFixed(1))),
            ),

            const SizedBox(height: 16),

            // Save ABG Result Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D9488),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: _isAdding
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.save),
                label: const Text(
                  'Save ABG to Patient Flowsheet',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: _isAdding ? null : _saveABG,
              ),
            ),

            const SizedBox(height: 20),

            // Previous ABGs
            const Text(
              'Serial ABG History',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            if (widget.patient.recentABGs.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Center(
                  child: Text(
                    'No historical ABG draws on file',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.patient.recentABGs.length,
                separatorBuilder: (_, _) => const SizedBox(height: 6),
                itemBuilder: (context, index) {
                  final a = widget.patient.recentABGs[index];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              a.timestamp,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'P/F: ${a.pfRatio.toInt()}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0D9488),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'pH: ${a.ph.toStringAsFixed(2)} · PaCO2: ${a.paCo2.toInt()} · PaO2: ${a.paO2.toInt()} · HCO3: ${a.hco3.toStringAsFixed(1)} · FiO2: ${a.fio2.toInt()}%',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          a.interpretation,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildAbgTile(
    String label,
    String value,
    String refRange,
    bool isAlert,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: isAlert ? Colors.red.shade50 : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isAlert ? Colors.red.shade300 : Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isAlert ? Colors.red.shade800 : Colors.black87,
            ),
          ),
          Text(
            refRange,
            style: TextStyle(fontSize: 9, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildAbgSlider({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required ValueChanged<double> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                value.toStringAsFixed(value == value.roundToDouble() ? 0 : 2),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D9488),
                  fontSize: 13,
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xFF0D9488),
              thumbColor: const Color(0xFF0D9488),
            ),
            child: Slider(
              value: value.clamp(min, max),
              min: min,
              max: max,
              divisions: divisions,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveABG() async {
    setState(() => _isAdding = true);
    try {
      final now = DateTime.now();
      final timeStr =
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
      final interp = ClinicalCalculators.interpretABG(
        ph: _ph,
        paCo2: _paCo2,
        paO2: _paO2,
        hco3: _hco3,
        fio2: _fio2,
      );

      final newABG = ABGResult(
        id: 'abg-${now.millisecondsSinceEpoch}',
        timestamp: timeStr,
        sampleType: 'Arterial',
        ph: _ph,
        paCo2: _paCo2,
        paO2: _paO2,
        hco3: _hco3,
        baseExcess: _be,
        fio2: _fio2,
        pfRatio: interp['pfRatio'] as double,
        interpretation:
            '${interp['primaryDiagnosis']} (${interp['oxygenationStatus']})',
      );

      await sl<AddABGResultUseCase>()(
        widget.patient.id,
        newABG,
        widget.patient.recentABGs,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ABG blood gas draw added to Firestore!'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving ABG: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isAdding = false);
    }
  }
}
