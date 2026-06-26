import 'package:flutter/material.dart';
import 'features/Productions/production_screen.dart';
import 'core/theme/app_theme.dart';
import 'features/projects/add_project_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/dashboard/dashboard_screen.dart';
import 'features/projects/projects_screen.dart';
import 'features/machines/machines_screen.dart';
import 'features/employees/employees_screen.dart';
import 'features/profile/profile_screen.dart';
import 'features/notifications/notifications_screen.dart';
import 'features/machines/machine_details_screen.dart';
import 'package:provider/provider.dart';
import '../providers/project_provider.dart';

import 'providers/auth_provider.dart';
void main() {
  runApp(
    MultiProvider(
      providers: [
  ChangeNotifierProvider(
    create: (_) => AuthProvider(),
  ),

  ChangeNotifierProvider(
    create: (_) => ProjectProvider(),
  ),
],
      child: const CrusherTrackApp(),
    ),
  );
}
class CrusherTrackApp extends StatefulWidget {
  const CrusherTrackApp({super.key});

  static _CrusherTrackAppState of(BuildContext context) {
    return context.findAncestorStateOfType<_CrusherTrackAppState>()!;
  }

  @override
  State<CrusherTrackApp> createState() => _CrusherTrackAppState();
}

class _CrusherTrackAppState extends State<CrusherTrackApp> {
  ThemeMode themeMode = ThemeMode.system;

  void changeTheme(ThemeMode mode) {
    setState(() {
      themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'CrusherTrack',

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      // Initial page
      home: const LoginScreen(),

      // App routes
      routes: {
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/projects': (context) => const ProjectsScreen(),
        '/add-project': (context) => const AddProjectScreen(),
        '/employees': (context) => const EmployeesScreen(),
        '/production': (context) => const ProductionScreen(),
    '/machines': (context) => const MachinesScreen(),
    '/profile': (context) => const ProfileScreen(),
    '/notifications': (context) => const NotificationsScreen(),
    '/machine-details': (context) =>
    const MachineDetailsScreen(),
      },
    );
  }
}