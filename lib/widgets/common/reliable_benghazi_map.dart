import 'package:flutter/material.dart';

class ReliableBenghaziMap extends StatelessWidget {
  final double height;
  final bool showRoute;
  final bool isDarkTheme;

  const ReliableBenghaziMap({
    super.key,
    this.height = 200,
    this.showRoute = false,
    this.isDarkTheme = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDarkTheme
              ? [
                  const Color(0xFF1A4A6B), // Mediterranean Sea (top)
                  const Color(0xFF2A2A2A), // Land (bottom)
                ]
              : [
                  const Color(0xFF4A90E2), // Mediterranean Sea (top)
                  const Color(0xFFE0E0E0), // Land (bottom)
                ],
          stops: const [0.0, 0.35],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // City blocks pattern
            _buildCityBlocks(),
            
            // Road network
            _buildRoadNetwork(),
            
            // Location markers
            _buildLocationMarkers(),
            
            // Route line if needed
            if (showRoute) _buildRouteLine(),
            
            // Map label
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isDarkTheme ? Colors.black.withOpacity(0.7) : Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Benghazi Map',
                  style: TextStyle(
                    color: isDarkTheme ? Colors.white : Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCityBlocks() {
    return Stack(
      children: [
        // City blocks using positioned containers
        Positioned(
          left: 40,
          top: 120,
          child: _buildBlock(60, 30),
        ),
        Positioned(
          left: 120,
          top: 120,
          child: _buildBlock(40, 30),
        ),
        Positioned(
          left: 180,
          top: 120,
          child: _buildBlock(50, 30),
        ),
        Positioned(
          left: 260,
          top: 120,
          child: _buildBlock(60, 30),
        ),
        Positioned(
          left: 40,
          top: 170,
          child: _buildBlock(60, 30),
        ),
        Positioned(
          left: 120,
          top: 170,
          child: _buildBlock(40, 30),
        ),
        Positioned(
          left: 180,
          top: 170,
          child: _buildBlock(50, 30),
        ),
        Positioned(
          left: 260,
          top: 170,
          child: _buildBlock(60, 30),
        ),
      ],
    );
  }

  Widget _buildBlock(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isDarkTheme ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildRoadNetwork() {
    return Stack(
      children: [
        // Main horizontal road (Jamal Abdel Nasser Street)
        Positioned(
          left: 0,
          top: height * 0.6,
          child: Container(
            width: double.infinity,
            height: 3,
            color: isDarkTheme ? const Color(0xFF404040) : const Color(0xFFBDBDBD),
          ),
        ),
        // Main vertical road (Omar Al-Mukhtar Street)
        Positioned(
          left: height * 0.4,
          top: 0,
          child: Container(
            width: 3,
            height: double.infinity,
            color: isDarkTheme ? const Color(0xFF404040) : const Color(0xFFBDBDBD),
          ),
        ),
        // Secondary roads
        Positioned(
          left: 0,
          top: height * 0.4,
          child: Container(
            width: double.infinity,
            height: 2,
            color: isDarkTheme ? const Color(0xFF353535) : const Color(0xFFD0D0D0),
          ),
        ),
        Positioned(
          left: 0,
          top: height * 0.8,
          child: Container(
            width: double.infinity,
            height: 2,
            color: isDarkTheme ? const Color(0xFF353535) : const Color(0xFFD0D0D0),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationMarkers() {
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
        // Pickup location (if showing route)
        if (showRoute)
          Positioned(
            left: 100,
            top: 140,
            child: _buildMarker(Icons.my_location, 'Pickup', isPickup: true),
          ),
        // Destination (if showing route)
        if (showRoute)
          Positioned(
            left: 140,
            top: 90,
            child: _buildMarker(Icons.location_on, 'Destination', isDestination: true),
          ),
      ],
    );
  }

  Widget _buildMarker(IconData icon, String label, {bool isPickup = false, bool isDestination = false}) {
    Color markerColor = const Color(0xFFF4811E);
    if (isPickup) markerColor = const Color(0xFFF4811E);
    if (isDestination) markerColor = Colors.red;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: isPickup || isDestination ? 50 : 40,
          height: isPickup || isDestination ? 50 : 40,
          decoration: BoxDecoration(
            color: markerColor,
            shape: BoxShape.circle,
            border: isPickup || isDestination ? Border.all(color: Colors.white, width: 3) : null,
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
            size: isPickup || isDestination ? 24 : 20,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: isDarkTheme ? Colors.black.withOpacity(0.7) : Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isDarkTheme ? Colors.white : Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRouteLine() {
    return Positioned(
      left: 100,
      top: 140,
      child: Container(
        width: 65,
        height: 4,
        decoration: BoxDecoration(
          color: const Color(0xFFF4811E),
          borderRadius: BorderRadius.circular(2),
        ),
        transform: Matrix4.rotationZ(-0.5), // Slight angle to connect pickup to destination
      ),
    );
  }
} 