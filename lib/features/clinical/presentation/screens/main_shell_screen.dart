import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemoventrt/core/di/injection_container.dart';
import 'package:nemoventrt/features/clinical/domain/entities/patient.dart';
import 'package:nemoventrt/features/clinical/domain/usecases/acknowledge_alert_usecase.dart';
import 'package:nemoventrt/features/clinical/presentation/bloc/auth_cubit.dart';
import 'package:nemoventrt/features/clinical/presentation/bloc/patient_bloc.dart';
import 'package:nemoventrt/features/clinical/presentation/bloc/patient_event.dart';
import 'package:nemoventrt/features/clinical/presentation/bloc/patient_state.dart';
import 'package:nemoventrt/features/clinical/presentation/screens/abg_screen.dart';
import 'package:nemoventrt/features/clinical/presentation/screens/more_sheet.dart';
import 'package:nemoventrt/features/clinical/presentation/screens/ventilator_screen.dart';
import 'package:nemoventrt/features/clinical/presentation/screens/vitals_screen.dart';
import 'package:nemoventrt/features/clinical/presentation/screens/weaning_screen.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/admit_patient_dialog.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/patient_census_sheet.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientBloc, PatientState>(
      builder: (context, state) {
        final patient = state.selectedPatient;
        final unacknowledgedAlerts = state.totalUnacknowledgedAlerts;

        return Scaffold(
          appBar: AppBar(
            elevation: 0.5,
            backgroundColor: Theme.of(context).cardColor,
            titleSpacing: 12,
            title: Builder(
              builder: (context) {
                if (state.status == PatientStatus.loading && patient == null) {
                  return const Text(
                    'Syncing ICU Census...',
                    style: TextStyle(fontSize: 14),
                  );
                }
                if (patient == null) {
                  return const Text(
                    'NemoVent RT ICU',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  );
                }
                return InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => _openPatientCensusSheet(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.amber,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${patient.bed} · ${patient.lastName}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              '${patient.category.name.toUpperCase()} · ${patient.ventilatorSettings.mode}',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.arrow_drop_down,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            actions: [
              // Clinical Alarms Bell
              Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_none),
                    onPressed: () => _showAlertsDialog(context),
                  ),
                  if (unacknowledgedAlerts > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$unacknowledgedAlerts',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              // Quick Patient Census Drawer Trigger
              IconButton(
                icon: const Icon(Icons.people_outline),
                tooltip: 'ICU Census',
                onPressed: () => _openPatientCensusSheet(context),
              ),
              const SizedBox(width: 4),
            ],
          ),
          body: Builder(
            builder: (context) {
              if (state.status == PatientStatus.loading && patient == null) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Color(0xFF0D9488)),
                      SizedBox(height: 16),
                      Text('Connecting to Cloud Firestore...'),
                    ],
                  ),
                );
              }

              if (state.status == PatientStatus.error && patient == null) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.cloud_off,
                          size: 48,
                          color: Colors.orange,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Firestore Connection Notice: ${state.errorMessage}',
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => context.read<PatientBloc>().add(
                            const LoadPatients(),
                          ),
                          child: const Text('Retry Connection'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (patient == null) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.air, size: 64, color: Colors.teal.shade300),
                        const SizedBox(height: 16),
                        const Text(
                          'No Active Patients in ICU',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Admit a patient to initiate ventilation monitoring and flowsheet recording.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0D9488),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          icon: const Icon(Icons.add),
                          label: const Text('Admit First Patient'),
                          onPressed: () {
                            showDialog<void>(
                              context: context,
                              builder: (context) => const AdmitPatientDialog(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }

              // Active view according to bottom nav index
              switch (_currentTabIndex) {
                case 0:
                  return VentilatorScreen(patient: patient);
                case 1:
                  return VitalsScreen(patient: patient);
                case 2:
                  return WeaningScreen(patient: patient);
                case 3:
                  return ABGScreen(patient: patient);
                default:
                  return VentilatorScreen(patient: patient);
              }
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentTabIndex.clamp(0, 4),
            type:
                const BottomNavigationBarThemeData().type ??
                BottomNavigationBarType.fixed,
            selectedItemColor: const Color(0xFF0D9488),
            unselectedItemColor: Colors.grey.shade500,
            selectedFontSize: 11,
            unselectedFontSize: 11,
            onTap: (index) {
              if (index == 4) {
                _openMoreSheet(context, patient);
              } else {
                setState(() {
                  _currentTabIndex = index;
                });
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.air),
                label: 'Vent',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                label: 'Vitals',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.psychology_outlined),
                label: 'Weaning',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.science_outlined),
                label: 'ABG Lab',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view),
                label: 'More',
              ),
            ],
          ),
        );
      },
    );
  }

  void _openPatientCensusSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const PatientCensusSheet(),
    );
  }

  void _openMoreSheet(BuildContext context, Patient? activePatient) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => MoreModulesSheet(activePatient: activePatient),
    );
  }

  void _showAlertsDialog(BuildContext context) {
    final patients = context.read<PatientBloc>().state.patients;
    final alertsWithPatient = <Map<String, dynamic>>[];

    for (final p in patients) {
      for (final a in p.criticalAlerts) {
        alertsWithPatient.add({
          'patient': p,
          'alert': a,
        });
      }
    }

    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'ICU Critical Alarms',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: alertsWithPatient.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'All patient ventilator alarms normal. No active unacknowledged alerts.',
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: alertsWithPatient.length,
                  itemBuilder: (context, idx) {
                    final item = alertsWithPatient[idx];
                    final Patient p = item['patient'];
                    final CriticalAlert a = item['alert'];

                    return ListTile(
                      leading: Icon(
                        Icons.warning,
                        color: a.severity == 'High'
                            ? Colors.red
                            : Colors.orange,
                      ),
                      title: Text('${p.bed} · ${a.parameter} (${a.value})'),
                      subtitle: Text(a.message),
                      trailing: a.acknowledged
                          ? const Icon(Icons.check, color: Colors.green)
                          : TextButton(
                              onPressed: () async {
                                final user = context.read<AuthCubit>().state;
                                await sl<AcknowledgeAlertUseCase>()(
                                  p.id,
                                  a.id,
                                  user?.name ?? 'Clinician',
                                  p.criticalAlerts,
                                );
                                if (!context.mounted) return;
                                Navigator.pop(ctx);
                              },
                              child: const Text('Acknowledge'),
                            ),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
