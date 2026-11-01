import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemoventrt/core/models/staff_user.dart';

class AuthCubit extends Cubit<StaffUser?> {
  AuthCubit() : super(null);

  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> init() async {
    emit(
      const StaffUser(
        id: 'staff-rt-1',
        name: 'Marcus Vance',
        email: 'marcus.vance@example.test',
        pin: '8429',
        credentials: 'RRT, RRT-ACCS, RPFT',
        role: 'respiratory_therapist',
        department: 'adult_critical_care_department',
        badgeId: 'RT-8429',
        avatarUrl: 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=150',
        legalAccepted: true,
      ),
    );
  }

  void setUser(StaffUser? user) => emit(user);

  void logout() => emit(null);
}
