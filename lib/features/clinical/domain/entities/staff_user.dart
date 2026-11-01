class StaffUser {
  final String id;
  final String name;
  final String email;
  final String pin;
  final String credentials;
  final String role;
  final String department;
  final String badgeId;
  final String avatarUrl;
  final bool mfaEnabled;
  final bool biometricRegistered;
  final bool legalAccepted;

  const StaffUser({
    required this.id,
    required this.name,
    required this.email,
    required this.pin,
    required this.credentials,
    required this.role,
    required this.department,
    required this.badgeId,
    required this.avatarUrl,
    this.mfaEnabled = false,
    this.biometricRegistered = false,
    this.legalAccepted = true,
  });

  StaffUser copyWith({
    String? id,
    String? name,
    String? email,
    String? pin,
    String? credentials,
    String? role,
    String? department,
    String? badgeId,
    String? avatarUrl,
    bool? mfaEnabled,
    bool? biometricRegistered,
    bool? legalAccepted,
  }) {
    return StaffUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      pin: pin ?? this.pin,
      credentials: credentials ?? this.credentials,
      role: role ?? this.role,
      department: department ?? this.department,
      badgeId: badgeId ?? this.badgeId,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      mfaEnabled: mfaEnabled ?? this.mfaEnabled,
      biometricRegistered: biometricRegistered ?? this.biometricRegistered,
      legalAccepted: legalAccepted ?? this.legalAccepted,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StaffUser &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'StaffUser(id: $id, name: $name, role: $role)';
}
