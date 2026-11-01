import 'package:flutter/material.dart';
import 'package:nemoventrt/core/di/injection_container.dart';
import 'package:nemoventrt/features/clinical/domain/entities/patient.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/add_vital_observation_usecase.dart';

class VitalsScreen extends StatefulWidget {
  final Patient patient;

  const VitalsScreen({super.key, required this.patient});

  @override
  State<VitalsScreen> createState() => _VitalsScreenState();
}

class _VitalsScreenState extends State<VitalsScreen> {
  int _hr = 78;
  int _spo2 = 98;
  int _rr = 18;
  int _sys = 124;
  int _dia = 76;
  int _etco2 = 36;
  double _temp = 37.1;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.patient.vitalsHistory.isNotEmpty) {
      final latest = widget.patient.vitalsHistory.first;
      _hr = latest.heartRate;
      _spo2 = latest.spo2;
      _rr = latest.respiratoryRate;
      _sys = latest.systolicBp;
      _dia = latest.diastolicBp;
      _etco2 = latest.etCo2 ?? 36;
      _temp = latest.temperatureC;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header card
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
                    backgroundColor: Colors.red.shade50,
                    child: const Icon(Icons.favorite, color: Colors.red),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.patient.bed} · Vitals Telemetry',
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

            // Live Vitals Telemetry Grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.5,
              children: [
                _buildVitalCard(
                  'Heart Rate',
                  '$_hr',
                  'bpm',
                  Icons.favorite,
                  Colors.red,
                ),
                _buildVitalCard(
                  'SpO2 Pulse Ox',
                  '$_spo2',
                  '%',
                  Icons.water_drop,
                  Colors.blue,
                ),
                _buildVitalCard(
                  'Resp Rate',
                  '$_rr',
                  '/min',
                  Icons.air,
                  const Color(0xFF0D9488),
                ),
                _buildVitalCard(
                  'Blood Pressure',
                  '$_sys/$_dia',
                  'mmHg',
                  Icons.speed,
                  Colors.purple,
                ),
                _buildVitalCard(
                  'End-Tidal CO2',
                  '$_etco2',
                  'mmHg',
                  Icons.cloud,
                  Colors.amber.shade800,
                ),
                _buildVitalCard(
                  'Body Temp',
                  _temp.toStringAsFixed(1),
                  '°C',
                  Icons.thermostat,
                  Colors.orange,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Telemetry Observation Logger Button
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
                icon: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.add_chart),
                label: const Text(
                  'Log Hourly Vitals Observation',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: _isSaving ? null : _logObservation,
              ),
            ),

            const SizedBox(height: 20),

            // Vitals History Log
            const Text(
              'Telemetry History Flowsheet',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            if (widget.patient.vitalsHistory.isEmpty)
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
                    'No telemetry records logged yet',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.patient.vitalsHistory.length,
                separatorBuilder: (_, _) => const SizedBox(height: 6),
                itemBuilder: (context, index) {
                  final v = widget.patient.vitalsHistory[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          v.timestamp,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          'HR: ${v.heartRate} · SpO2: ${v.spo2}% · BP: ${v.systolicBp}/${v.diastolicBp} · RR: ${v.respiratoryRate}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
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

  Widget _buildVitalCard(
    String label,
    String value,
    String unit,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(icon, size: 16, color: color),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                unit,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _logObservation() async {
    setState(() => _isSaving = true);
    try {
      final now = DateTime.now();
      final timeStr =
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

      final newObs = VitalObservation(
        id: 'obs-${now.millisecondsSinceEpoch}',
        timestamp: timeStr,
        heartRate: _hr,
        spo2: _spo2,
        respiratoryRate: _rr,
        systolicBp: _sys,
        diastolicBp: _dia,
        temperatureC: _temp,
        etCo2: _etco2,
      );

      await sl<AddVitalObservationUseCase>()(
        widget.patient.id,
        newObs,
        widget.patient.vitalsHistory,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vital telemetry observation logged in Firestore!'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error logging observation: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}
