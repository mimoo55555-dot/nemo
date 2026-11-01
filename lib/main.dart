import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nemoventrt/core/bloc/app_bloc_observer.dart';
import 'package:nemoventrt/core/di/injection_container.dart';
import 'package:nemoventrt/features/clinical/presentation/bloc/auth_cubit.dart';
import 'package:nemoventrt/features/clinical/presentation/bloc/patient_bloc.dart';
import 'package:nemoventrt/features/clinical/presentation/bloc/patient_event.dart';
import 'package:nemoventrt/features/clinical/presentation/screens/main_shell_screen.dart';
import 'package:nemoventrt/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Bloc Observer for monitoring state transitions and events
  Bloc.observer = AppBlocObserver();

  // Initialize Firebase (Firestore & Authentication)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Clean Architecture Service Locator (GetIt)
  await initDependencies();

  runApp(const NemoVentApp());
}

class NemoVentApp extends StatelessWidget {
  const NemoVentApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryTeal = Color(0xFF0D9488);

    return MultiBlocProvider(
      providers: [
        BlocProvider<PatientBloc>(
          create: (_) => sl<PatientBloc>()..add(const LoadPatients()),
        ),
        BlocProvider<AuthCubit>(
          create: (_) => sl<AuthCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'NemoVent RT ICU Suite',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryTeal,
            primary: primaryTeal,
            brightness: Brightness.light,
          ),
          scaffoldBackgroundColor: const Color(0xFFF8FAFC),
          cardColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Color(0xFF0F172A),
            elevation: 0.5,
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryTeal,
            primary: primaryTeal,
            brightness: Brightness.dark,
          ),
          scaffoldBackgroundColor: const Color(0xFF090D16),
          cardColor: const Color(0xFF162032),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF162032),
            foregroundColor: Color(0xFFF1F5F9),
            elevation: 0.5,
          ),
        ),
        home: const MainShellScreen(),
      ),
    );
  }
}
