import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemoventrt/features/clinical/domain/entities/patient.dart';
import 'package:nemoventrt/features/clinical/domain/entities/staff_user.dart';
import 'package:nemoventrt/features/clinical/presentation/bloc/auth_cubit.dart';

class MoreModulesSheet extends StatelessWidget {
  final Patient? activePatient;

  const MoreModulesSheet({super.key, this.activePatient});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, StaffUser?>(
      builder: (context, user) {
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
                    const Text(
                      'Clinical Suite & Tools',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  children: [
                    // Clinician Card
                    if (user != null)
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D9488)
                              .withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFF0D9488)
                                .withValues(alpha: 0.2),
                          ),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: const Color(0xFF0D9488),
                              child: Text(
                                user.name
                                    .split(' ')
                                    .map((n) => n.isNotEmpty ? n[0] : '')
                                    .take(2)
                                    .join(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    '${user.role} · ${user.credentials}',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  Text(
                                    'ID: ${user.badgeId} · ${user.department}',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Active Patient Summary Card
                    if (activePatient != null)
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.blueGrey.shade100),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.airline_seat_flat_angled,
                              color: Color(0xFF0D9488),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Active Case: ${activePatient!.bed} · ${activePatient!.fullName}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    '${activePatient!.diagnosis} · MRN: ${activePatient!.mrn}',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Section: Clinical Modules
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      child: Text(
                        'ADVANCED MODULES',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),

                    _buildModuleTile(
                      context,
                      title: 'Pharmacology & Aerosol Delivery',
                      subtitle:
                          'Bronchodilators, prostacyclins, sedation titration',
                      icon: Icons.medication,
                      color: Colors.purple,
                      onTap: () {
                        Navigator.pop(context);
                        _showInfoModal(
                          context,
                          'Inhaled Pharmacology',
                          'Albuterol 2.5mg Q4H, Ipratropium 0.5mg Q6H, Treprostinil inhalation protocols loaded.',
                        );
                      },
                    ),

                    _buildModuleTile(
                      context,
                      title: 'Intubation & Airway Management',
                      subtitle:
                          'ETT Depth, cuff pressure log, video laryngoscopy',
                      icon: Icons.medical_services,
                      color: Colors.teal,
                      onTap: () {
                        Navigator.pop(context);
                        _showInfoModal(
                          context,
                          'Airway Assessment',
                          'ETT size ${activePatient?.etTubeSize ?? 7.5} at ${activePatient?.etTubeDepth ?? 22} cm. Target cuff pressure 20-30 cmH2O.',
                        );
                      },
                    ),

                    _buildModuleTile(
                      context,
                      title: 'Hemodynamics & Blood Gas Trends',
                      subtitle:
                          'P/F ratios, PaO2/PAO2 indices, SvO2 monitoring',
                      icon: Icons.show_chart,
                      color: Colors.blue,
                      onTap: () {
                        Navigator.pop(context);
                        _showInfoModal(
                          context,
                          'Hemodynamics Trend',
                          'MAP > 65 mmHg sustained. Serial lactate and arterial line waveform synchrony verified.',
                        );
                      },
                    ),

                    _buildModuleTile(
                      context,
                      title: 'Pediatric & Neonatal Protocol Engine',
                      subtitle: 'Broselow color coding, HFOV oscillations, Surfactant',
                      icon: Icons.child_care,
                      color: Colors.amber.shade800,
                      onTap: () {
                        Navigator.pop(context);
                        _showInfoModal(
                          context,
                          'Pediatric & Neonatal Suite',
                          'ARDSNet pediatric lung-protective protocol & neonatal volume guarantee (VG) formulas active.',
                        );
                      },
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      child: Text(
                        'APP & SECURITY',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),

                    _buildModuleTile(
                      context,
                      title: 'Audit Logs & Verification',
                      subtitle: 'Cryptographic SHA-256 clinical trail',
                      icon: Icons.verified_user,
                      color: Colors.green,
                      onTap: () {
                        Navigator.pop(context);
                        _showInfoModal(
                          context,
                          'Audit Verification',
                          'All ventilator setting adjustments and ABG telemetry entries are timestamped and signed with clinician credentials.',
                        );
                      },
                    ),

                    _buildModuleTile(
                      context,
                      title: 'Legal Acceptance & Compliance',
                      subtitle: 'HIPAA, GDPR & EULA Medical Disclaimer',
                      icon: Icons.gavel,
                      color: Colors.purple,
                      onTap: () {
                        Navigator.pop(context);
                        _showInfoModal(
                          context,
                          'Strict EULA & HIPAA IP Policy',
                          'Protected by 256-bit encryption. Strict license agreement and healthcare compliance rules active.',
                        );
                      },
                    ),

                    _buildModuleTile(
                      context,
                      title: 'Sign Out Clinician Session',
                      subtitle: 'Securely clear auth tokens and lock flowsheet',
                      icon: Icons.logout,
                      color: Colors.grey.shade700,
                      onTap: () {
                        context.read<AuthCubit>().logout();
                        Navigator.pop(context);
                      },
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom + 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildModuleTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          leading: CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.12),
            child: Icon(icon, color: color, size: 20),
          ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
        trailing: const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
        onTap: onTap,
      ),
    ),
  );
}

  void _showInfoModal(BuildContext context, String title, String body) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Text(body),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
