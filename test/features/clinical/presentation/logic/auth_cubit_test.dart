import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nemoventrt/core/models/staff_user.dart';
import 'package:nemoventrt/features/clinical/presentation/logic/auth_cubit.dart';

void main() {
  group('AuthCubit', () {
    test('starts without a staff session', () {
      final cubit = AuthCubit();
      expect(cubit.state, isNull);
      cubit.close();
    });

    blocTest<AuthCubit, StaffUser?>(
      'initializes the default clinician',
      build: AuthCubit.new,
      act: (cubit) => cubit.init(),
      expect: () => [
        predicate<StaffUser?>(
          (user) =>
              user?.name == 'Marcus Vance' &&
              user?.role == 'respiratory_therapist',
        ),
      ],
    );

    blocTest<AuthCubit, StaffUser?>(
      'logout clears the staff session',
      build: () => AuthCubit()..init(),
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
