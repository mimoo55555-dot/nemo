import 'package:nemoventrt/features/clinical/domain/entities/staff_user.dart';

class StaffModel extends StaffUser {
  const StaffModel({
    required super.id,
    required super.name,
    required super.email,
    required super.pin,
    required super.credentials,
    required super.role,
    required super.department,
    required super.badgeId,
    required super.avatarUrl,
    super.mfaEnabled = false,
    super.biometricRegistered = false,
    super.legalAccepted = true,
  });

  factory StaffModel.fromMap(Map<String, dynamic> map) {
    return StaffModel(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? 'Clinician',
      email: map['email'] as String? ?? '',
      pin: map['pin'] as String? ?? '1234',
      credentials: map['credentials'] as String? ?? 'RRT',
      role: map['role'] as String? ?? 'Respiratory Therapist',
      department: map['department'] as String? ?? 'Critical Care Services',
      badgeId: map['badgeId'] as String? ?? 'RT-100',
      avatarUrl: map['avatarUrl'] as String? ?? '',
      mfaEnabled: map['mfaEnabled'] as bool? ?? false,
      biometricRegistered: map['biometricRegistered'] as bool? ?? false,
      legalAccepted: map['legalAccepted'] as bool? ?? true,
    );
  }

  static Map<String, dynamic> toMap(StaffUser user) => {
    'id': user.id,
    'name': user.name,
    'email': user.email,
    'pin': user.pin,
    'credentials': user.credentials,
    'role': user.role,
    'department': user.department,
    'badgeId': user.badgeId,
    'avatarUrl': user.avatarUrl,
    'mfaEnabled': user.mfaEnabled,
    'biometricRegistered': user.biometricRegistered,
    'legalAccepted': user.legalAccepted,
  };
}
