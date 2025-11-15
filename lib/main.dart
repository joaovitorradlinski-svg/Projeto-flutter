import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'theme/app_theme.dart';
import 'services/firebase_auth_service.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/campanha/campanha_form.dart';
import 'screens/campanha/campanha_details.dart';
import 'screens/personagem/personagem_form.dart';
import 'screens/personagem/personagem_edit.dart';
import 'screens/local/local_form.dart';
import 'screens/local/local_edit.dart';
import 'models/campanha.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const RPGManagerApp());
}

class RPGManagerApp extends StatelessWidget {
  const RPGManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RPG Manager',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (_) => _initialScreen(),
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/dashboard': (_) => const DashboardScreen(),
        '/campanha/new': (_) => const CampanhaFormScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/campanha/details') {
          final campanha = settings.arguments as Campanha;
          return MaterialPageRoute(
            builder: (_) => CampanhaDetailsScreen(campanha: campanha),
          );
        }

        if (settings.name == '/campanha/edit') {
          final campanha = settings.arguments as Campanha;
          return MaterialPageRoute(
            builder: (_) => CampanhaFormScreen(campanha: campanha),
          );
        }

        if (settings.name == '/personagem/new') {
          final campId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (_) => PersonagemFormScreen(campanhaId: campId),
          );
        }

        if (settings.name == '/personagem/edit') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => PersonagemEditScreen(
              campanhaId: args['campanhaId'],
              personagem: args['personagem'],
            ),
          );
        }

        if (settings.name == '/local/new') {
          final campId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (_) => LocalFormScreen(campanhaId: campId),
          );
        }

        if (settings.name == '/local/edit') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => LocalEditScreen(
              campanhaId: args['campanhaId'],
              local: args['local'],
            ),
          );
        }

        return null;
      },
    );
  }

  Widget _initialScreen() {
    final user = FirebaseAuthService().currentUser;
    if (user != null) return const DashboardScreen();
    return const LoginScreen();
  }
}
