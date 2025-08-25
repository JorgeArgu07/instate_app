// Pantalla de Mapa (simulada).
import 'package:flutter/material.dart';
import 'package:instate_app/widgets/map_widget.dart';

class MapViewScreen extends StatelessWidget {
  final List<Map<String, dynamic>> terrenos;
  final Map<String, dynamic> selectedTerreno;

  const MapViewScreen({
    Key? key,
    required this.terrenos,
    required this.selectedTerreno,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa de Terrenos: ${selectedTerreno['nombre']}'),
        backgroundColor: Colors.blue,
      ),
      body: MapWidget(terrenos: terrenos, selectedTerreno: selectedTerreno),
    );
  }
}
