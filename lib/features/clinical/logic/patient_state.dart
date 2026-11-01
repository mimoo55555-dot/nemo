import 'package:collection/collection.dart';
import 'package:nemoventrt/core/models/patient.dart';

enum PatientStatus { initial, loading, loaded, empty, error }

class PatientState {
  final PatientStatus status;
  final List<Patient> patients;
  final String? selectedPatientId;
  final String categoryFilter;
  final String? errorMessage;

  const PatientState({
    this.status = PatientStatus.initial,
    this.patients = const [],
    this.selectedPatientId,
    this.categoryFilter = 'all',
    this.errorMessage,
  });

  Patient? get selectedPatient {
    if (patients.isEmpty) return null;
    if (selectedPatientId == null) return patients.first;
    return patients.firstWhereOrNull((p) => p.id == selectedPatientId) ??
        patients.first;
  }

  List<Patient> get filteredPatients {
    if (categoryFilter == 'all') return patients;
    return patients.where((p) => p.category.name == categoryFilter).toList();
  }

  int get totalUnacknowledgedAlerts {
    return patients.fold<int>(
      0,
      (acc, p) => acc + p.criticalAlerts.where((a) => !a.acknowledged).length,
    );
  }

  PatientState copyWith({
    PatientStatus? status,
    List<Patient>? patients,
    String? selectedPatientId,
    bool clearSelectedPatientId = false,
    String? categoryFilter,
    String? errorMessage,
  }) {
    return PatientState(
      status: status ?? this.status,
      patients: patients ?? this.patients,
      selectedPatientId: clearSelectedPatientId
          ? null
          : (selectedPatientId ?? this.selectedPatientId),
      categoryFilter: categoryFilter ?? this.categoryFilter,
      errorMessage: errorMessage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PatientState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          const ListEquality<Patient>().equals(patients, other.patients) &&
          selectedPatientId == other.selectedPatientId &&
          categoryFilter == other.categoryFilter &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode => Object.hash(
    status,
    const ListEquality<Patient>().hash(patients),
    selectedPatientId,
    categoryFilter,
    errorMessage,
  );

  @override
  String toString() =>
      'PatientState(status: $status, count: ${patients.length}, selected: $selectedPatientId, filter: $categoryFilter)';
}
