import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemoventrt/core/di/injection_container.dart';
import 'package:nemoventrt/features/clinical/domain/entities/patient.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/save_patient_usecase.dart';
import 'package:nemoventrt/features/clinical/presentation/bloc/patient_bloc.dart';
import 'package:nemoventrt/features/clinical/presentation/bloc/patient_event.dart';

class AdmitPatientDialog extends StatefulWidget {
  const AdmitPatientDialog({super.key});

  @override
  State<AdmitPatientDialog> createState() => _AdmitPatientDialogState();
}

class _AdmitPatientDialogState extends State<AdmitPatientDialog> {
  final _formKey = GlobalKey<FormState>();

  String _firstName = '';
  String _lastName = '';
  String _bed = 'Bed 01';
  String _mrn = 'MRN-100201';
  final int _age = 58;
  PatientCategory _category = PatientCategory.adult;
  BiologicalSex _sex = BiologicalSex.male;
  double _heightCm = 175.0;
  double _actualWeightKg = 75.0;
  String _diagnosis = 'Acute Respiratory Distress Syndrome (ARDS)';
  String _ventMode = 'VC-CMV';
  double _tidalVolume = 450.0;
  int _setRate = 16;
  double _peep = 10.0;
  double _fio2 = 60.0;

  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Admit New ICU Patient',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: _firstName,
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                        ),
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Required' : null,
                        onSaved: (v) => _firstName = v ?? '',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        initialValue: _lastName,
                        decoration: const InputDecoration(
                          labelText: 'Last Name',
                        ),
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Required' : null,
                        onSaved: (v) => _lastName = v ?? '',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: _bed,
                        decoration: const InputDecoration(
                          labelText: 'Bed / Unit',
                        ),
                        onSaved: (v) => _bed = v ?? 'Bed 1',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        initialValue: _mrn,
                        decoration: const InputDecoration(
                          labelText: 'MRN Number',
                        ),
                        onSaved: (v) => _mrn = v ?? '',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<PatientCategory>(
                        initialValue: _category,
                        decoration: const InputDecoration(
                          labelText: 'Category',
                        ),
                        items: PatientCategory.values.map((c) {
                          return DropdownMenuItem(
                            value: c,
                            child: Text(c.name.toUpperCase()),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _category = val);
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<BiologicalSex>(
                        initialValue: _sex,
                        decoration: const InputDecoration(labelText: 'Sex'),
                        items: BiologicalSex.values.map((s) {
                          return DropdownMenuItem(
                            value: s,
                            child: Text(s.name.toUpperCase()),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _sex = val);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: _diagnosis,
                  decoration: const InputDecoration(
                    labelText: 'Primary ICU Diagnosis',
                  ),
                  onSaved: (v) => _diagnosis = v ?? '',
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: _heightCm.toString(),
                        decoration: const InputDecoration(
                          labelText: 'Height (cm)',
                        ),
                        keyboardType: TextInputType.number,
                        onSaved: (v) =>
                            _heightCm = double.tryParse(v ?? '') ?? 170.0,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        initialValue: _actualWeightKg.toString(),
                        decoration: const InputDecoration(
                          labelText: 'Weight (kg)',
                        ),
                        keyboardType: TextInputType.number,
                        onSaved: (v) =>
                            _actualWeightKg = double.tryParse(v ?? '') ?? 70.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Initial Ventilator Settings',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: _ventMode,
                        decoration: const InputDecoration(labelText: 'Mode'),
                        items:
                            ['VC-CMV', 'PC-CMV', 'SIMV', 'PSV', 'PRVC', 'APRV']
                                .map(
                                  (m) => DropdownMenuItem(
                                    value: m,
                                    child: Text(m),
                                  ),
                                )
                                .toList(),
                        onChanged: (v) =>
                            setState(() => _ventMode = v ?? 'VC-CMV'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        initialValue: _tidalVolume.toInt().toString(),
                        decoration: const InputDecoration(labelText: 'Vt (mL)'),
                        keyboardType: TextInputType.number,
                        onSaved: (v) =>
                            _tidalVolume = double.tryParse(v ?? '') ?? 450.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: _setRate.toString(),
                        decoration: const InputDecoration(
                          labelText: 'Rate (/min)',
                        ),
                        keyboardType: TextInputType.number,
                        onSaved: (v) => _setRate = int.tryParse(v ?? '') ?? 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        initialValue: _peep.toInt().toString(),
                        decoration: const InputDecoration(labelText: 'PEEP'),
                        keyboardType: TextInputType.number,
                        onSaved: (v) => _peep = double.tryParse(v ?? '') ?? 5.0,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        initialValue: _fio2.toInt().toString(),
                        decoration: const InputDecoration(
                          labelText: 'FiO2 (%)',
                        ),
                        keyboardType: TextInputType.number,
                        onSaved: (v) =>
                            _fio2 = double.tryParse(v ?? '') ?? 40.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0D9488),
            foregroundColor: Colors.white,
          ),
          onPressed: _isSaving ? null : _savePatient,
          child: _isSaving
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text('Admit Patient'),
        ),
      ],
    );
  }

  Future<void> _savePatient() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => _isSaving = true);

    try {
      final newId = 'pat-${DateTime.now().millisecondsSinceEpoch}';
      final newPatient = Patient(
        id: newId,
        mrn: _mrn,
        bed: _bed,
        unit: 'Medical ICU',
        firstName: _firstName,
        lastName: _lastName,
        age: _age,
        category: _category,
        sex: _sex,
        heightCm: _heightCm,
        actualWeightKg: _actualWeightKg,
        diagnosis: _diagnosis,
        ventilatorSettings: VentilatorSettings(
          mode: _ventMode,
          tidalVolume: _tidalVolume,
          setRate: _setRate,
          totalRate: _setRate,
          peep: _peep,
          fio2: _fio2,
          peakPressure: 22.0,
          plateauPressure: 18.0,
          inspTime: 0.9,
          ieRatio: '1:2.0',
          peakFlow: 60.0,
        ),
        admissionDate: DateTime.now().toIso8601String().substring(0, 10),
        intubationDate: DateTime.now().toIso8601String().substring(0, 10),
        etTubeSize: 7.5,
        etTubeDepth: 22,
        criticalAlerts: const [],
        recentABGs: const [],
        vitalsHistory: const [],
      );

      await sl<SavePatientUseCase>()(newPatient);
      if (mounted) {
        context.read<PatientBloc>().add(SelectPatient(newId));
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Patient $_lastName admitted to $_bed')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error admitting patient: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}
