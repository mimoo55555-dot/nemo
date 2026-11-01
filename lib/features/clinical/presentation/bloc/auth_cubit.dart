import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemoventrt/features/clinical/domain/entities/staff_user.dart';

class AuthCubit extends Cubit<StaffUser?> {
  AuthCubit()
    : super(
        const StaffUser(
          id: 'staff-rt-1',
          name: 'Marcus Vance',
          email: 'marcus.vance@example.test',
          pin: '8429',
          credentials: 'RRT, RRT-ACCS, RPFT',
          role: 'Respiratory Therapist',
          department: 'Adult Critical Care Respiratory Services',
          badgeId: 'RT-8429',
          avatarUrl: 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=150',
          legalAccepted: true,
        ),
      );

  void setUser(StaffUser? user) {
    emit(user);
  }

  void logout() {
    emit(null);
  }
}
