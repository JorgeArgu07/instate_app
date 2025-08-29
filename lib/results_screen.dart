import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:instate_app/map_view_screen.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  // Estado para alternar entre la vista de lista y de mapa.
  bool _isListView = true;

  // Datos simulados de los 50 terrenos.
  late final List<Map<String, dynamic>> _terrenos;

  @override
  void initState() {
    super.initState();
    // Generar datos simulados con coordenadas aleatorias.
    _terrenos = List.generate(
      50,
      (index) => {
        'id': index,
        'nombre': 'Terreno #${index + 1}',
        'ubicacion': 'Ubicación simulada ${index + 1}',
        'area_m2': 500 + index * 10,
        'precio_usd': 50000 + index * 200,
        'coordenadas':
            _generateRandomCoordinates(), // Se añade el campo de coordenadas.
      },
    );
  }

  // Función para generar coordenadas aleatorias dentro de México.
  LatLng _generateRandomCoordinates() {
    // Rango de latitud para México (~14°N a ~32°N)
    final double minLat = 14.5;
    final double maxLat = 32.7;
    // Rango de longitud para México (~86°O a ~118°O)
    final double minLng = -118.5;
    final double maxLng = -86.7;

    final Random random = Random();
    final double latitude = minLat + (maxLat - minLat) * random.nextDouble();
    final double longitude = minLng + (maxLng - minLng) * random.nextDouble();

    return LatLng(latitude, longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados de la Búsqueda'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(_isListView ? Icons.map : Icons.list),
            onPressed: () {
              setState(() {
                _isListView = !_isListView;
              });
            },
          ),
        ],
      ),
      body: _isListView ? _buildListView() : _buildMapView(),
    );
  }

  // Widget para la vista de lista.
  Widget _buildListView() {
    return ListView.builder(
      itemCount: _terrenos.length,
      itemBuilder: (context, index) {
        final terreno = _terrenos[index];
        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(terreno['nombre']),
            subtitle: Text(
              'Área: ${terreno['area_m2']} m²\nUbicación: ${terreno['ubicacion']}',
            ),
            trailing: Text(
              '\$${terreno['precio_usd']} USD',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            onTap: () {
              // Navega a la pantalla del mapa y pasa el terreno seleccionado y todos los terrenos.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapViewScreen(
                    terrenos: _terrenos,
                    selectedTerreno: terreno,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Widget para la vista del mapa (marcador de posición).
  Widget _buildMapView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.map_outlined, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Aquí se mostrará el mapa con los resultados',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
