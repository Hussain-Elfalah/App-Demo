import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:ui' as ui;

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
  bool _mapError = false;
  
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
        child: _mapError ? _buildFallbackMap() : _buildFlutterMap(),
      ),
    );
  }

  Widget _buildFlutterMap() {
    return Stack(
      children: [
        // FlutterMap with reliable tile server
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _benghaziCenter,
            initialZoom: 12.0,
            minZoom: 10.0,
            maxZoom: 18.0,
            backgroundColor: widget.isDarkTheme ? const Color(0xFF1A1A1A) : Colors.grey[100]!,
            onMapReady: () {
              // Map loaded successfully
            },
          ),
          children: [
            // More reliable tile layer with fallback
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.sixt.benghazi_demo',
              maxZoom: 18,
              backgroundColor: widget.isDarkTheme ? const Color(0xFF1A1A1A) : Colors.grey[100]!,
              errorTileCallback: (tile, error, stackTrace) {
                // Handle tile loading errors
                setState(() {
                  _mapError = true;
                });
              },
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
    );
  }

  Widget _buildFallbackMap() {
    return Container(
      decoration: BoxDecoration(
        color: widget.isDarkTheme ? const Color(0xFF1A1A1A) : Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          // Custom painted map background
          CustomPaint(
            painter: BenghaziMapPainter(isDarkTheme: widget.isDarkTheme),
            size: Size.infinite,
          ),
          
          // Overlay with location markers
          Positioned.fill(
            child: _buildStaticMarkers(),
          ),
          
          // Map label
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: widget.isDarkTheme ? Colors.black.withOpacity(0.7) : Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Benghazi Map',
                style: TextStyle(
                  color: widget.isDarkTheme ? Colors.white : Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaticMarkers() {
    return Stack(
      children: [
        // Medical Center
        Positioned(
          left: 120,
          top: 80,
          child: _buildMarker(Icons.local_hospital, 'Medical Center'),
        ),
        // Airport
        Positioned(
          right: 60,
          bottom: 100,
          child: _buildMarker(Icons.flight, 'Airport'),
        ),
        // University
        Positioned(
          left: 160,
          top: 120,
          child: _buildMarker(Icons.school, 'University'),
        ),
        // Al-Sabri
        Positioned(
          left: 80,
          top: 60,
          child: _buildMarker(Icons.home, 'Al-Sabri'),
        ),
      ],
    );
  }

  Widget _buildMarker(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFF4811E),
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
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: widget.isDarkTheme ? Colors.black.withOpacity(0.7) : Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: widget.isDarkTheme ? Colors.white : Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
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

class BenghaziMapPainter extends CustomPainter {
  final bool isDarkTheme;

  BenghaziMapPainter({required this.isDarkTheme});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDarkTheme ? const Color(0xFF2A2A2A) : const Color(0xFFE0E0E0)
      ..style = PaintingStyle.fill;

    // Draw background
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Draw coastline (Mediterranean Sea)
    final coastPaint = Paint()
      ..color = isDarkTheme ? const Color(0xFF1A4A6B) : const Color(0xFF4A90E2)
      ..style = PaintingStyle.fill;

    final coastPath = ui.Path();
    coastPath.moveTo(0, 0);
    coastPath.lineTo(size.width, 0);
    coastPath.lineTo(size.width, size.height * 0.3);
    coastPath.quadraticBezierTo(size.width * 0.7, size.height * 0.25, size.width * 0.4, size.height * 0.3);
    coastPath.quadraticBezierTo(size.width * 0.2, size.height * 0.35, 0, size.height * 0.4);
    coastPath.close();
    canvas.drawPath(coastPath, coastPaint);

    // Draw main roads
    final roadPaint = Paint()
      ..color = isDarkTheme ? const Color(0xFF404040) : const Color(0xFFBDBDBD)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    // Jamal Abdel Nasser Street (horizontal)
    canvas.drawLine(
      Offset(0, size.height * 0.6),
      Offset(size.width, size.height * 0.6),
      roadPaint,
    );

    // Omar Al-Mukhtar Street (vertical)
    canvas.drawLine(
      Offset(size.width * 0.4, 0),
      Offset(size.width * 0.4, size.height),
      roadPaint,
    );

    // Secondary roads
    final secondaryRoadPaint = Paint()
      ..color = isDarkTheme ? const Color(0xFF353535) : const Color(0xFFD0D0D0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Horizontal roads
    canvas.drawLine(Offset(0, size.height * 0.4), Offset(size.width, size.height * 0.4), secondaryRoadPaint);
    canvas.drawLine(Offset(0, size.height * 0.8), Offset(size.width, size.height * 0.8), secondaryRoadPaint);

    // Vertical roads
    canvas.drawLine(Offset(size.width * 0.2, 0), Offset(size.width * 0.2, size.height), secondaryRoadPaint);
    canvas.drawLine(Offset(size.width * 0.6, 0), Offset(size.width * 0.6, size.height), secondaryRoadPaint);
    canvas.drawLine(Offset(size.width * 0.8, 0), Offset(size.width * 0.8, size.height), secondaryRoadPaint);

    // Draw city blocks
    final blockPaint = Paint()
      ..color = isDarkTheme ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5)
      ..style = PaintingStyle.fill;

    // Draw some representative city blocks
    final blocks = [
      Rect.fromLTWH(size.width * 0.1, size.height * 0.45, size.width * 0.15, size.height * 0.1),
      Rect.fromLTWH(size.width * 0.3, size.height * 0.45, size.width * 0.08, size.height * 0.1),
      Rect.fromLTWH(size.width * 0.45, size.height * 0.45, size.width * 0.12, size.height * 0.1),
      Rect.fromLTWH(size.width * 0.65, size.height * 0.45, size.width * 0.15, size.height * 0.1),
      Rect.fromLTWH(size.width * 0.1, size.height * 0.65, size.width * 0.15, size.height * 0.1),
      Rect.fromLTWH(size.width * 0.3, size.height * 0.65, size.width * 0.08, size.height * 0.1),
      Rect.fromLTWH(size.width * 0.45, size.height * 0.65, size.width * 0.12, size.height * 0.1),
      Rect.fromLTWH(size.width * 0.65, size.height * 0.65, size.width * 0.15, size.height * 0.1),
    ];

    for (final block in blocks) {
      canvas.drawRect(block, blockPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
} 