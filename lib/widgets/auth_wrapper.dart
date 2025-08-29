import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instate_app/login_screen.dart';
import 'package:instate_app/search_screen.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // StreamBuilder escucha la transmisión de estado de autenticación
    return StreamBuilder<User?>(
      // `authStateChanges()` emite un evento cada vez que el estado de autenticación cambia
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Muestra un indicador de carga mientras se verifica el estado
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        // Si el usuario está autenticado, muestra la pantalla de inicio (Home)
        if (snapshot.hasData) {
          return const SearchScreen();
        }
        // Si no, muestra la pantalla de inicio de sesión (Login)
        else {
          return const LoginScreen();
        }
      },
    );
  }
}
