import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nemoventrt/features/clinical/domain/entities/staff_user.dart';
import 'package:nemoventrt/features/clinical/presentation/bloc/auth_cubit.dart';

void main() {
  group('AuthCubit', () {
    test('initial state has default logged-in staff user', () {
      final cubit = AuthCubit();
      expect(cubit.state, isNotNull);
      expect(cubit.state?.name, equals('Marcus Vance'));
      expect(cubit.state?.role, equals('Respiratory Therapist'));
    });

    blocTest<AuthCubit, StaffUser?>(
      'logout emits null',
      build: () => AuthCubit(),
      act: (cubit) => cubit.logout(),
      expect: () => [isNull],
    );

    blocTest<AuthCubit, StaffUser?>(
      'setUser emits updated user',
      build: () => AuthCubit(),
      act: (cubit) => cubit.setUser(
        const StaffUser(
          id: 'staff-2',
          name: 'Sarah Connor',
          email: 'sarah@example.test',
          pin: '9999',
          credentials: 'MD, Pulmonologist',
          role: 'Attending Physician',
          department: 'ICU',
          badgeId: 'MD-100',
          avatarUrl: '',
        ),
      ),
      expect: () => [
        predicate<StaffUser?>((u) => u?.name == 'Sarah Connor'),
      ],
    );
  });
}
