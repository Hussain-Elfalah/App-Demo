import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../utils/font_helper.dart';
import '../../widgets/common/benghazi_map.dart';
import '../../l10n/app_localizations.dart';
import 'package:latlong2/latlong.dart';

class ChooseDriverScreen extends StatefulWidget {
  const ChooseDriverScreen({super.key});

  @override
  State<ChooseDriverScreen> createState() => _ChooseDriverScreenState();
}

class _ChooseDriverScreenState extends State<ChooseDriverScreen> {
  String? selectedDriverId;
  bool showDriverList = false;

  // Demo drivers data for Benghazi
  final List<Map<String, dynamic>> availableDrivers = [
    {
      'id': '1',
      'name': 'Omar Hassan',
      'car': 'S-Class Mercedes',
      'rating': '4.9',
      'eta': '< 3 min',
      'image': 'assets/images/Placeholder.jpg',
      'location': const LatLng(32.1165, 20.0686),
    },
    {
      'id': '2',
      'name': 'Ahmed Al-Mansouri',
      'car': 'BMW X6 xDrive',
      'rating': '4.8',
      'eta': '5-7 min',
      'image': 'assets/images/Placeholder.jpg',
      'location': const LatLng(32.1180, 20.0700),
    },
    {
      'id': '3',
      'name': 'Khalil Benghazi',
      'car': 'Audi A8 Quattro',
      'rating': '4.7',
      'eta': '8-10 min',
      'image': 'assets/images/Placeholder.jpg',
      'location': const LatLng(32.1150, 20.0650),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      body: Stack(
        children: [
          // Dark Map Background
          const BenghaziMap(
            height: double.infinity,
            showRoute: true,
            pickupLocation: LatLng(32.1165, 20.0686), // Current location
            destinationLocation: LatLng(32.1089, 20.0642), // Medical Center
            isDarkTheme: true,
          ),

          // Top Bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  // Menu Button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 24,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const Spacer(),
                  // Sixt Logo Area
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      l10n.sixtRide,
                      style: FontHelper.getHeadingStyle(
                        languageCode: Localizations.localeOf(context).languageCode,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Car Icons on Map (positioned cars on actual Benghazi streets)
          const Positioned(
            top: 380,
            left: 200,
            child: _CarIcon(),
          ),
          const Positioned(
            top: 420,
            left: 250,
            child: _CarIcon(),
          ),
          const Positioned(
            top: 360,
            left: 280,
            child: _CarIcon(),
          ),

          // Current Location Pin (also moved to land)
          const Positioned(
            top: 400,
            left: 230,
            child: Icon(
              Icons.location_on,
              color: AppColors.primary,
              size: 40,
            ),
          ),

          // Bottom Sheet - Choose Driver
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: showDriverList ? MediaQuery.of(context).size.height * 0.6 : 120,
              decoration: const BoxDecoration(
                color: Color(0xFF1A1A1A),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  // Handle bar
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  if (!showDriverList) ...[
                    // Collapsed state - Choose The Driver button
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showDriverList = true;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(AppSpacing.md),
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2A2A),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Driver avatars stack
                            SizedBox(
                              width: 60,
                              height: 40,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundImage: AssetImage(availableDrivers[0]['image']),
                                    ),
                                  ),
                                  Positioned(
                                    left: 15,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundImage: AssetImage(availableDrivers[1]['image']),
                                    ),
                                  ),
                                  Positioned(
                                    left: 30,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundImage: AssetImage(availableDrivers[2]['image']),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Text(
                                l10n.chooseTheDriver,
                                style: FontHelper.getHeadingStyle(
                                  languageCode: Localizations.localeOf(context).languageCode,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ] else ...[
                    // Expanded state - Driver list
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.chooseTheDriver,
                            style: FontHelper.getHeadingStyle(
                              languageCode: Localizations.localeOf(context).languageCode,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showDriverList = false;
                              });
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.grey,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Search bar
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            l10n.searchForDrivers,
                            style: FontHelper.getBodyStyle(
                              languageCode: Localizations.localeOf(context).languageCode,
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // Driver count
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      child: Text(
                        l10n.driversHere(availableDrivers.length),
                        style: FontHelper.getCaptionStyle(
                          languageCode: Localizations.localeOf(context).languageCode,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // Driver list
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                        itemCount: availableDrivers.length,
                        itemBuilder: (context, index) {
                          final driver = availableDrivers[index];
                          final isSelected = selectedDriverId == driver['id'];

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDriverId = driver['id'];
                              });
                              // Navigate to next screen after selection
                              Future.delayed(const Duration(milliseconds: 500), () {
                                Navigator.pushNamed(
                                  context,
                                  '/ride-summary',
                                  arguments: {
                                    'driverName': driver['name'],
                                    'driverCar': driver['car'],
                                    'driverRating': driver['rating'],
                                    'eta': driver['eta'],
                                  },
                                );
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: AppSpacing.md),
                              padding: const EdgeInsets.all(AppSpacing.md),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.primary.withOpacity(0.1) : const Color(0xFF2A2A2A),
                                borderRadius: BorderRadius.circular(16),
                                border: isSelected 
                                  ? Border.all(color: AppColors.primary, width: 2)
                                  : null,
                              ),
                              child: Row(
                                children: [
                                  // Driver photo
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage(driver['image']),
                                  ),
                                  const SizedBox(width: AppSpacing.md),
                                  // Driver info
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          driver['name'],
                                          style: FontHelper.getBodyStyle(
                                            languageCode: Localizations.localeOf(context).languageCode,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          driver['car'],
                                          style: FontHelper.getCaptionStyle(
                                            languageCode: Localizations.localeOf(context).languageCode,
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // ETA
                                  Text(
                                    driver['eta'],
                                    style: FontHelper.getBodyStyle(
                                      languageCode: Localizations.localeOf(context).languageCode,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CarIcon extends StatelessWidget {
  const _CarIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Icon(
        Icons.directions_car,
        color: Colors.black,
        size: 20,
      ),
    );
  }
} 