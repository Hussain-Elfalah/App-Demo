import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../../utils/constants.dart';
import '../../utils/font_helper.dart';
import '../../widgets/common/benghazi_map.dart';
import '../../l10n/app_localizations.dart';

class RideSummaryScreen extends StatefulWidget {
  const RideSummaryScreen({super.key});

  @override
  State<RideSummaryScreen> createState() => _RideSummaryScreenState();
}

class _RideSummaryScreenState extends State<RideSummaryScreen> {
  Map<String, dynamic>? arguments;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final pickup = arguments?['pickup'] ?? l10n.currentLocationAddress;
    final destination = arguments?['destination'] ?? l10n.workAddress;
    final destinationLabel = arguments?['destinationLabel'] ?? l10n.destination;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.rideSummary,
          style: FontHelper.getHeadingStyle(
            languageCode: Localizations.localeOf(context).languageCode,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Map Preview Section
          Container(
            height: 200,
            margin: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppBorderRadius.medium),
              color: const Color(0xFF1A1A1A),
            ),
            child: BenghaziMap(
              height: 200,
              showRoute: true,
              pickupLocation: const LatLng(32.1165, 20.0686), // Jamal Abdel Nasser Street
              destinationLocation: _getDestinationCoordinates(destination),
              isDarkTheme: true,
            ),
          ),

          // Ride Details Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.rideDetails,
                    style: FontHelper.getHeadingStyle(
                      languageCode: Localizations.localeOf(context).languageCode,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  
                  const SizedBox(height: AppSpacing.lg),

                  // Pickup Location
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2A2A),
                          borderRadius: BorderRadius.circular(AppBorderRadius.small),
                        ),
                        child: const Icon(
                          Icons.my_location,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.pickup,
                              style: FontHelper.getBodyStyle(
                                languageCode: Localizations.localeOf(context).languageCode,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              pickup,
                              style: FontHelper.getCaptionStyle(
                                languageCode: Localizations.localeOf(context).languageCode,
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // Destination Location
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2A2A),
                          borderRadius: BorderRadius.circular(AppBorderRadius.small),
                        ),
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.destination,
                              style: FontHelper.getBodyStyle(
                                languageCode: Localizations.localeOf(context).languageCode,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              destination,
                              style: FontHelper.getCaptionStyle(
                                languageCode: Localizations.localeOf(context).languageCode,
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  // Estimated Fee
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.estimatedFee,
                        style: FontHelper.getBodyStyle(
                          languageCode: Localizations.localeOf(context).languageCode,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '\$15',
                        style: FontHelper.getBodyStyle(
                          languageCode: Localizations.localeOf(context).languageCode,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Estimated Time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.estimatedTimeOfArrival,
                        style: FontHelper.getBodyStyle(
                          languageCode: Localizations.localeOf(context).languageCode,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '5 min',
                        style: FontHelper.getBodyStyle(
                          languageCode: Localizations.localeOf(context).languageCode,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Confirm Ride Button
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                    child: ElevatedButton(
                      onPressed: () => _confirmRide(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppBorderRadius.medium),
                        ),
                      ),
                      child: Text(
                        l10n.confirmRide,
                        style: FontHelper.getButtonStyle(
                          languageCode: Localizations.localeOf(context).languageCode,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  LatLng _getDestinationCoordinates(String destination) {
    // Map destination addresses to coordinates
    switch (destination) {
      case 'المدينة الطبية، بنغازي':
        return const LatLng(32.1089, 20.0642); // Medical Center
      case 'مطار بنينا الدولي، بنغازي':
        return const LatLng(32.0968, 20.2695); // Benina Airport
      case 'مركز البركة التجاري، بنغازي':
        return const LatLng(32.1200, 20.0700); // Al-Berka Shopping Center
      case 'جامعة بنغازي، بنغازي':
        return const LatLng(32.1147, 20.0764); // University of Benghazi
      case 'حي الصابري، بنغازي':
        return const LatLng(32.1203, 20.0589); // Sabri District
      default:
        return const LatLng(32.1165, 20.0686); // Default to city center
    }
  }

  void _confirmRide() {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Simulate ride confirmation delay
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Close loading dialog
      
      // Navigate to rating screen after "ride completion"
      Navigator.pushNamed(
        context,
        '/rating',
        arguments: {
          'driverName': AppConstants.demoDriverName,
          'driverCar': AppConstants.demoDriverCar,
          'pickup': arguments?['pickup'],
          'destination': arguments?['destination'],
        },
      );
    });
  }
}

 