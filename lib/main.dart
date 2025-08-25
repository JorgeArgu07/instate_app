import 'package:flutter/material.dart';
import 'package:instate_app/auth_screen.dart';
import 'package:instate_app/map_view_screen.dart';
import 'package:instate_app/search_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

// El widget principal de la aplicación.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diagnósticos de Terrenos MVP',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Se define la ruta inicial y las rutas nombradas.
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthScreen(),
        '/search': (context) => const SearchScreen(),
      },
      // En lugar de una ruta nombrada, la pantalla del mapa se genera
      // de forma dinámica para pasar el objeto del terreno seleccionado.
      onGenerateRoute: (settings) {
        if (settings.name == '/map') {
          // El objeto del terreno seleccionado se pasa como argumento.
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return MapViewScreen(
                terrenos: args['terrenos'],
                selectedTerreno: args['selectedTerreno'],
              );
            },
          );
        }
        return null;
      },
    );
  }
}
