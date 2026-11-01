import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nemoventrt/core/di/injection_container.dart';
import 'package:nemoventrt/core/utils/clinical_calculators.dart';
import 'package:nemoventrt/features/clinical/domain/entities/patient.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/update_ventilator_settings_usecase.dart';

class VentilatorScreen extends StatefulWidget {
  final Patient patient;

  const VentilatorScreen({super.key, required this.patient});

  @override
  State<VentilatorScreen> createState() => _VentilatorScreenState();
}

class _VentilatorScreenState extends State<VentilatorScreen> {
  late VentilatorSettings _settings;
  bool _isSaving = false;

  // Spontaneous Breathing Trial (SBT) timer state
  bool _sbtActive = false;
  int _sbtSecondsRemaining = 30 * 60; // 30 minutes
  Timer? _sbtTimer;

  @override
  void initState() {
    super.initState();
    _settings = widget.patient.ventilatorSettings;
  }

  @override
  void didUpdateWidget(covariant VentilatorScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.patient.id != widget.patient.id ||
        oldWidget.patient.ventilatorSettings !=
            widget.patient.ventilatorSettings) {
      _settings = widget.patient.ventilatorSettings;
    }
  }

  @override
  void dispose() {
    _sbtTimer?.cancel();
    super.dispose();
  }

  void _toggleSbt() {
    setState(() {
      _sbtActive = !_sbtActive;
      if (_sbtActive) {
        _sbtTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (_sbtSecondsRemaining <= 1) {
            timer.cancel();
            setState(() {
              _sbtActive = false;
              _sbtSecondsRemaining = 0;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'SBT 30-Minute Trial Complete! Assess RSBI & tolerance.',
                ),
              ),
            );
          } else {
            setState(() {
              _sbtSecondsRemaining--;
            });
          }
        });
      } else {
        _sbtTimer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ibw = ClinicalCalculators.calculateIBW(
      heightCm: widget.patient.heightCm,
      sex: widget.patient.sex,
      category: widget.patient.category,
      actualWeightKg: widget.patient.actualWeightKg,
    );

    final mechanics = ClinicalCalculators.calculateMechanics(_settings, ibw);
    final targetVolumes = ClinicalCalculators.calculateTargetTidalVolumes(ibw);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Patient Quick Header Card
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
                    backgroundColor: const Color(0xFF0D9488)
                        .withValues(alpha: 0.12),
                    child: const Icon(Icons.air, color: Color(0xFF0D9488)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${widget.patient.bed} · ${widget.patient.fullName}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0D9488)
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                _settings.mode,
                                style: const TextStyle(
                                  color: Color(0xFF0D9488),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'IBW: ${ibw.toStringAsFixed(1)} kg · Target 6mL/kg: ${targetVolumes['6mL_kg']?.toInt()} mL',
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

            const SizedBox(height: 12),

            // 2. Real-Time Respiratory Mechanics Telemetry Grid
            Row(
              children: [
                Expanded(
                  child: _buildMetricTile(
                    label: 'Driving Pressure',
                    value: '${mechanics['drivingPressure']} cmH2O',
                    isAlert: !(mechanics['isDrivingPressureSafe'] as bool),
                    sublabel: 'Pplat - PEEP (≤15)',
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildMetricTile(
                    label: 'Static Compliance',
                    value: '${mechanics['staticCompliance']} mL/cmH2O',
                    sublabel: 'Normal: 50-80',
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildMetricTile(
                    label: 'Vol / IBW',
                    value: '${mechanics['mlPerKg']} mL/kg',
                    sublabel: 'Target: 4-8',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 3. Ventilation Mode Selection
            const Text(
              'Ventilation Mode',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    [
                      'VC-CMV',
                      'PC-CMV',
                      'SIMV',
                      'PSV',
                      'PRVC',
                      'APRV',
                      'BiLevel',
                      'HFOV',
                    ].map((mode) {
                      final isSelected = _settings.mode == mode;
                      return Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: ChoiceChip(
                          label: Text(mode),
                          selected: isSelected,
                          selectedColor: const Color(0xFF0D9488),
                          labelStyle: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : Colors.grey.shade800,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 12,
                          ),
                          onSelected: (_) {
                            setState(() {
                              _settings = _settings.copyWith(mode: mode);
                            });
                          },
                        ),
                      );
                    }).toList(),
              ),
            ),

            const SizedBox(height: 16),

            // 4. Primary Ventilator Controls
            const Text(
              'Ventilator Settings',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Tidal Volume (mL)
            _buildSliderControl(
              label: 'Tidal Volume (Vt)',
              value: _settings.tidalVolume,
              min: 50,
              max: 900,
              unit: 'mL',
              onChanged: (val) {
                setState(
                  () => _settings = _settings.copyWith(tidalVolume: val),
                );
              },
            ),

            // Set Respiratory Rate
            _buildSliderControl(
              label: 'Respiratory Rate (f)',
              value: _settings.setRate.toDouble(),
              min: 4,
              max: 45,
              unit: 'breaths/min',
              onChanged: (val) {
                setState(
                  () => _settings = _settings.copyWith(
                    setRate: val.toInt(),
                    totalRate: val.toInt(),
                  ),
                );
              },
            ),

            // PEEP (cmH2O)
            _buildSliderControl(
              label: 'PEEP',
              value: _settings.peep,
              min: 0,
              max: 24,
              unit: 'cmH2O',
              onChanged: (val) {
                setState(() => _settings = _settings.copyWith(peep: val));
              },
            ),

            // FiO2 (%)
            _buildSliderControl(
              label: 'FiO2 (Oxygen)',
              value: _settings.fio2,
              min: 21,
              max: 100,
              unit: '%',
              onChanged: (val) {
                setState(() => _settings = _settings.copyWith(fio2: val));
              },
            ),

            // Inspiratory Time (sec)
            _buildSliderControl(
              label: 'Inspiratory Time (Ti)',
              value: _settings.inspTime,
              min: 0.4,
              max: 3.0,
              divisions: 26,
              unit: 'sec',
              onChanged: (val) {
                setState(
                  () => _settings = _settings.copyWith(
                    inspTime: double.parse(val.toStringAsFixed(2)),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // 5. Spontaneous Breathing Trial (SBT) Module
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _sbtActive
                    ? Colors.amber.shade50
                    : Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: _sbtActive
                      ? Colors.amber.shade300
                      : Colors.grey.shade200,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.timer,
                    color: _sbtActive
                        ? Colors.amber.shade800
                        : Colors.grey.shade700,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _sbtActive
                              ? 'SBT Trial In Progress'
                              : 'Spontaneous Breathing Trial (SBT)',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: _sbtActive
                                ? Colors.amber.shade900
                                : Colors.black,
                          ),
                        ),
                        Text(
                          _sbtActive
                              ? '${(_sbtSecondsRemaining ~/ 60).toString().padLeft(2, '0')}:${(_sbtSecondsRemaining % 60).toString().padLeft(2, '0')} remaining'
                              : '30-minute PSV/CPAP wean assessment',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _sbtActive
                          ? Colors.redAccent
                          : const Color(0xFF0D9488),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                    ),
                    onPressed: _toggleSbt,
                    child: Text(_sbtActive ? 'Stop' : 'Start 30m'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 6. Save & Deploy Ventilator Settings to Firestore
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D9488),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.check_circle_outline),
                label: Text(
                  _isSaving
                      ? 'Syncing to Cloud EHR...'
                      : 'Save & Sync Ventilator Settings',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                onPressed: _isSaving ? null : _saveSettings,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricTile({
    required String label,
    required String value,
    required String sublabel,
    bool isAlert = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: isAlert ? Colors.red.shade50 : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isAlert ? Colors.red.shade300 : Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isAlert ? Colors.red.shade800 : Colors.black87,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            sublabel,
            style: TextStyle(fontSize: 9, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderControl({
    required String label,
    required double value,
    required double min,
    required double max,
    required String unit,
    int? divisions,
    required ValueChanged<double> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
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
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${value.toStringAsFixed(value == value.roundToDouble() ? 0 : 2)} $unit',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D9488),
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xFF0D9488),
              thumbColor: const Color(0xFF0D9488),
              overlayColor: const Color(0xFF0D9488).withValues(alpha: 0.12),
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

  Future<void> _saveSettings() async {
    setState(() => _isSaving = true);
    try {
      await sl<UpdateVentilatorSettingsUseCase>()(
        widget.patient.id,
        _settings,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Ventilator parameters synchronized with Cloud Firestore!',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating ventilator settings: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}
