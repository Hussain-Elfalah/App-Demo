import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class SimpleBenghaziMap extends StatelessWidget {
  final double height;
  final bool showRoute;
  final bool isDarkTheme;

  const SimpleBenghaziMap({
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
        color: isDarkTheme ? const Color(0xFF1A1A1A) : Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                // Custom painted map background with explicit size
                SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: constraints.maxWidth > 0 && constraints.maxHeight > 0
                    ? CustomPaint(
                        painter: BenghaziMapPainter(isDarkTheme: isDarkTheme),
                        size: Size(constraints.maxWidth, constraints.maxHeight),
                      )
                    : Container(
                        color: isDarkTheme ? const Color(0xFF2A2A2A) : const Color(0xFFE0E0E0),
                        child: Center(
                          child: Text(
                            'Benghazi Map Loading...',
                            style: TextStyle(
                              color: isDarkTheme ? Colors.white : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                ),
                
                // Route line if needed
                if (showRoute)
                  SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    child: CustomPaint(
                      painter: RouteLinePainter(),
                      size: Size(constraints.maxWidth, constraints.maxHeight),
                    ),
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
            );
          },
        ),
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
}

class RouteLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF4811E)
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    // Draw a curved route line from pickup to destination
    final path = ui.Path();
    path.moveTo(100 + 25, 140 + 25); // Pickup center
    path.quadraticBezierTo(
      size.width * 0.5, size.height * 0.3, // Control point
      140 + 25, 90 + 25, // Destination center
    );
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BenghaziMapPainter extends CustomPainter {
  final bool isDarkTheme;

  BenghaziMapPainter({required this.isDarkTheme});

  @override
  void paint(Canvas canvas, Size size) {
    // Ensure we have a valid size
    if (size.width <= 0 || size.height <= 0) return;
    
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