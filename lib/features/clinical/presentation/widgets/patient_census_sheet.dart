import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemoventrt/features/clinical/domain/entities/patient.dart';
import 'package:nemoventrt/features/clinical/presentation/bloc/patient_bloc.dart';
import 'package:nemoventrt/features/clinical/presentation/bloc/patient_event.dart';
import 'package:nemoventrt/features/clinical/presentation/bloc/patient_state.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/admit_patient_dialog.dart';

class PatientCensusSheet extends StatefulWidget {
  const PatientCensusSheet({super.key});

  @override
  State<PatientCensusSheet> createState() => _PatientCensusSheetState();
}

class _PatientCensusSheetState extends State<PatientCensusSheet> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientBloc, PatientState>(
      builder: (context, state) {
        final patients = state.patients;
        final selectedId = state.selectedPatientId;
        final currentFilter = state.categoryFilter;

        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              // Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ICU Patient Census',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (state.status == PatientStatus.loading)
                          const Text(
                            'Connecting to Firestore...',
                            style: TextStyle(fontSize: 12),
                          )
                        else if (state.status == PatientStatus.error)
                          const Text(
                            'Offline mode',
                            style: TextStyle(fontSize: 12),
                          )
                        else
                          Text(
                            '${patients.length} active flowsheet${patients.length == 1 ? '' : 's'}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              // Search Box
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 4,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search bed, name, MRN, diagnosis...',
                    prefixIcon: const Icon(Icons.search, size: 20),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                  ),
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val.trim().toLowerCase();
                    });
                  },
                ),
              ),

              // Category Filter Tabs
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('All Units', 'all', currentFilter),
                      const SizedBox(width: 8),
                      _buildFilterChip('Adult ICU', 'adult', currentFilter),
                      const SizedBox(width: 8),
                      _buildFilterChip('PICU', 'pediatric', currentFilter),
                      const SizedBox(width: 8),
                      _buildFilterChip('NICU', 'neonate', currentFilter),
                    ],
                  ),
                ),
              ),

              const Divider(height: 1),

              // Patient List View
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (state.status == PatientStatus.loading &&
                        patients.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.status == PatientStatus.error &&
                        patients.isEmpty) {
                      return Center(
                        child: Text(
                          'Error: ${state.errorMessage ?? "Failed to load"}',
                        ),
                      );
                    }

                    final filtered = patients.where((p) {
                      final matchesCat =
                          currentFilter == 'all' ||
                          p.category.name == currentFilter;
                      final matchesSearch =
                          _searchQuery.isEmpty ||
                          p.bed.toLowerCase().contains(_searchQuery) ||
                          p.fullName.toLowerCase().contains(_searchQuery) ||
                          p.mrn.toLowerCase().contains(_searchQuery) ||
                          p.diagnosis.toLowerCase().contains(_searchQuery);
                      return matchesCat && matchesSearch;
                    }).toList();

                    if (filtered.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.airline_seat_flat,
                                size: 48,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'No matching patients found',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Admit an ICU patient or clear filters',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount: filtered.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final patient = filtered[index];
                        final isSelected = selectedId == null
                            ? index == 0
                            : patient.id == selectedId;

                        return Card(
                          elevation: isSelected ? 2 : 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: isSelected
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey.shade200,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          color: isSelected
                              ? Theme.of(context).primaryColor
                                    .withValues(alpha: 0.06)
                              : Theme.of(context).cardColor,
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            leading: CircleAvatar(
                              backgroundColor: _getCategoryColor(
                                patient.category,
                              ).withValues(alpha: 0.2),
                              child: Icon(
                                _getCategoryIcon(patient.category),
                                color: _getCategoryColor(patient.category),
                                size: 20,
                              ),
                            ),
                            title: Row(
                              children: [
                                Text(
                                  patient.bed,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  patient.fullName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const Spacer(),
                                if (patient.criticalAlerts.any(
                                  (a) => !a.acknowledged,
                                ))
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade100,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      '${patient.criticalAlerts.where((a) => !a.acknowledged).length} ALARM',
                                      style: TextStyle(
                                        color: Colors.red.shade900,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(
                                  '${patient.diagnosis} · ${patient.age}y · ${patient.sex.name.toUpperCase()} · IBW: ${patient.actualWeightKg} kg',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 1,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey.shade50,
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: Colors.blueGrey.shade200,
                                        ),
                                      ),
                                      child: Text(
                                        patient.ventilatorSettings.mode,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueGrey.shade800,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'PEEP: ${patient.ventilatorSettings.peep.toInt()}',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'FiO2: ${patient.ventilatorSettings.fio2.toInt()}%',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Vt: ${patient.ventilatorSettings.tidalVolume.toInt()} mL',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: isSelected
                                ? Icon(
                                    Icons.check_circle,
                                    color: Theme.of(context).primaryColor,
                                  )
                                : IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.redAccent,
                                      size: 20,
                                    ),
                                    onPressed: () =>
                                        _confirmDischarge(context, patient),
                                  ),
                            onTap: () {
                              context.read<PatientBloc>().add(
                                SelectPatient(patient.id),
                              );
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              // Action: Admit New Patient Button
              Padding(
                padding: EdgeInsets.fromLTRB(
                  20,
                  8,
                  20,
                  MediaQuery.of(context).padding.bottom + 12,
                ),
                child: SizedBox(
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
                    icon: const Icon(Icons.add),
                    label: const Text(
                      '+ Admit New ICU Patient',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      showDialog<void>(
                        context: context,
                        builder: (context) => const AdmitPatientDialog(),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChip(String label, String value, String current) {
    final isSelected = current == value;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) {
        context.read<PatientBloc>().add(FilterPatientsByCategory(value));
      },
      selectedColor: const Color(0xFF0D9488).withValues(alpha: 0.15),
      labelStyle: TextStyle(
        color: isSelected ? const Color(0xFF0D9488) : Colors.grey.shade700,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        fontSize: 12,
      ),
    );
  }

  Color _getCategoryColor(PatientCategory category) {
    switch (category) {
      case PatientCategory.adult:
        return const Color(0xFF0D9488);
      case PatientCategory.pediatric:
        return Colors.indigo;
      case PatientCategory.neonate:
        return Colors.purple;
    }
  }

  IconData _getCategoryIcon(PatientCategory category) {
    switch (category) {
      case PatientCategory.adult:
        return Icons.person;
      case PatientCategory.pediatric:
        return Icons.child_care;
      case PatientCategory.neonate:
        return Icons.baby_changing_station;
    }
  }

  void _confirmDischarge(BuildContext context, Patient patient) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Discharge Patient?'),
        content: Text(
          'Remove ${patient.fullName} (${patient.bed}) from active ICU flowsheet?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(ctx);
              context.read<PatientBloc>().add(
                DischargePatientEvent(patient.id),
              );
            },
            child: const Text(
              'Discharge & Remove',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
