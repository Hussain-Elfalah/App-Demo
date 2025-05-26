import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class BenghaziMap extends StatefulWidget {
  final double height;
  final bool showRoute;
  final LatLng? pickupLocation;
  final LatLng? destinationLocation;
  final bool isDarkTheme;

  const BenghaziMap({
    super.key,
    this.height = 200,
    this.showRoute = false,
    this.pickupLocation,
    this.destinationLocation,
    this.isDarkTheme = false,
  });

  @override
  State<BenghaziMap> createState() => _BenghaziMapState();
}

class _BenghaziMapState extends State<BenghaziMap> {
  final MapController _mapController = MapController();
  
  // Benghazi coordinates
  static const LatLng _benghaziCenter = LatLng(32.1165, 20.0686);
  
  // Important locations in Benghazi
  static const List<Map<String, dynamic>> _benghaziLandmarks = [
    {
      'name': 'Benghazi Medical Center',
      'nameAr': 'المدينة الطبية',
      'location': LatLng(32.1089, 20.0642),
      'icon': Icons.local_hospital,
    },
    {
      'name': 'Benina Airport',
      'nameAr': 'مطار بنينا',
      'location': LatLng(32.0968, 20.2695),
      'icon': Icons.flight,
    },
    {
      'name': 'University of Benghazi',
      'nameAr': 'جامعة بنغازي',
      'location': LatLng(32.1147, 20.0764),
      'icon': Icons.school,
    },
    {
      'name': 'Al-Sabri District',
      'nameAr': 'حي الصابري',
      'location': LatLng(32.1203, 20.0589),
      'icon': Icons.home,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.isDarkTheme ? const Color(0xFF1A1A1A) : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // FlutterMap with dark theme
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _benghaziCenter,
                initialZoom: 12.0,
                minZoom: 10.0,
                maxZoom: 18.0,
                backgroundColor: widget.isDarkTheme ? const Color(0xFF1A1A1A) : Colors.grey[100]!,
              ),
              children: [
                // Dark themed tile layer
                TileLayer(
                  urlTemplate: widget.isDarkTheme 
                    ? 'https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png'
                    : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.sixt.benghazi_demo',
                  maxZoom: 18,
                  backgroundColor: widget.isDarkTheme ? const Color(0xFF1A1A1A) : Colors.grey[100]!,
                ),
                
                // Polylines for routes
                PolylineLayer(
                  polylines: _getPolylines(),
                ),
                
                // Markers for landmarks and locations
                MarkerLayer(
                  markers: _getMarkers(),
                ),
              ],
            ),
            
            // Dark overlay for dramatic effect (only for dark theme)
            if (widget.isDarkTheme)
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.3),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<Marker> _getMarkers() {
    List<Marker> markers = [];

    // Add landmark markers
    for (var landmark in _benghaziLandmarks) {
      markers.add(
        Marker(
          point: landmark['location'],
          width: 40,
          height: 40,
          child: Container(
            decoration: BoxDecoration(
              color: widget.isDarkTheme ? Colors.white : const Color(0xFFF4811E),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              landmark['icon'],
              color: widget.isDarkTheme ? Colors.black : Colors.white,
              size: 20,
            ),
          ),
        ),
      );
    }

    // Add pickup location marker
    if (widget.pickupLocation != null) {
      markers.add(
        Marker(
          point: widget.pickupLocation!,
          width: 50,
          height: 50,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF4811E),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.my_location,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      );
    }

    // Add destination location marker
    if (widget.destinationLocation != null) {
      markers.add(
        Marker(
          point: widget.destinationLocation!,
          width: 50,
          height: 50,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.location_on,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      );
    }

    return markers;
  }

  List<Polyline> _getPolylines() {
    if (!widget.showRoute || widget.pickupLocation == null || widget.destinationLocation == null) {
      return [];
    }

    return [
      Polyline(
        points: [widget.pickupLocation!, widget.destinationLocation!],
        strokeWidth: 4.0,
        color: const Color(0xFFF4811E),
      ),
    ];
  }
} 