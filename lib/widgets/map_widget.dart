import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatelessWidget {
  final List<Map<String, dynamic>> terrenos;
  final Map<String, dynamic>? selectedTerreno;

  const MapWidget({Key? key, required this.terrenos, this.selectedTerreno})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Genera el conjunto de marcadores para el mapa.
    Set<Marker> markers = terrenos.map((terreno) {
      final isSelected = selectedTerreno?['id'] == terreno['id'];
      return Marker(
        markerId: MarkerId(terreno['id'].toString()),
        position: LatLng(
          terreno['coordenadas'].latitude,
          terreno['coordenadas'].longitude,
        ),
        infoWindow: InfoWindow(
          title: terreno['nombre'],
          snippet:
              'Área: ${terreno['area_m2']} m²\nPrecio: \$${terreno['precio_usd']} USD',
        ),
        icon: isSelected
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)
            : BitmapDescriptor.defaultMarker,
      );
    }).toSet();

    // Establece la posición inicial de la cámara.
    LatLng initialPosition = const LatLng(
      23.6345,
      -102.5528,
    ); // Centro de México
    if (selectedTerreno != null) {
      initialPosition = selectedTerreno!['coordenadas'];
    }

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: initialPosition,
        zoom: selectedTerreno != null
            ? 12
            : 5, // Mayor zoom para el terreno seleccionado.
      ),
      markers: markers,
    );
  }
}
