import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../utils/font_helper.dart';
import '../../widgets/common/location_tile.dart';
import '../../l10n/app_localizations.dart';

class WhereToScreen extends StatefulWidget {
  const WhereToScreen({super.key});

  @override
  State<WhereToScreen> createState() => _WhereToScreenState();
}

class _WhereToScreenState extends State<WhereToScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Auto-focus the search field when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
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
          l10n.whereToTitle,
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
          // Search Section
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
                          child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(AppBorderRadius.medium),
                ),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                style: FontHelper.getBodyStyle(
                  languageCode: Localizations.localeOf(context).languageCode,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: '123',
                  hintStyle: FontHelper.getCaptionStyle(
                    languageCode: Localizations.localeOf(context).languageCode,
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {});
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.md,
                  ),
                ),
                onChanged: (value) {
                  setState(() {});
                },
                onSubmitted: (value) {
                  _handleLocationSelection(value, 'Search Result');
                },
              ),
            ),
          ),

          // Locations List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              children: [
                // Current Location
                LocationTile(
                  icon: Icons.my_location,
                  iconColor: AppColors.primary,
                  title: l10n.currentLocation,
                  subtitle: l10n.currentLocationAddress,
                  onTap: () => _handleLocationSelection(
                    l10n.currentLocationAddress,
                    l10n.currentLocation,
                  ),
                ),

                const SizedBox(height: AppSpacing.sm),

                // Home
                LocationTile(
                  icon: Icons.home_outlined,
                  iconColor: AppColors.darkGray,
                  title: l10n.home,
                  subtitle: l10n.homeAddress,
                  onTap: () => _handleLocationSelection(
                    l10n.homeAddress,
                    l10n.home,
                  ),
                ),

                const SizedBox(height: AppSpacing.sm),

                // Work
                LocationTile(
                  icon: Icons.work_outline,
                  iconColor: AppColors.darkGray,
                  title: l10n.work,
                  subtitle: l10n.workAddress,
                  onTap: () => _handleLocationSelection(
                    l10n.workAddress,
                    l10n.work,
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // Popular nearby section
                Text(
                  l10n.popularPlaces,
                  style: FontHelper.getHeadingStyle(
                    languageCode: Localizations.localeOf(context).languageCode,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: AppSpacing.md),

                // Popular places
                LocationTile(
                  icon: Icons.local_hospital_outlined,
                  iconColor: AppColors.darkGray,
                  title: l10n.medicalCenter,
                  subtitle: l10n.medicalCenter,
                  onTap: () => _handleLocationSelection(
                    l10n.medicalCenter,
                    l10n.medicalCenter,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                LocationTile(
                  icon: Icons.flight_outlined,
                  iconColor: AppColors.darkGray,
                  title: l10n.beninaAirport,
                  subtitle: l10n.beninaAirport,
                  onTap: () => _handleLocationSelection(
                    l10n.beninaAirport,
                    l10n.beninaAirport,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                LocationTile(
                  icon: Icons.shopping_bag_outlined,
                  iconColor: AppColors.darkGray,
                  title: l10n.shoppingCenter,
                  subtitle: l10n.shoppingCenter,
                  onTap: () => _handleLocationSelection(
                    l10n.shoppingCenter,
                    l10n.shoppingCenter,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                LocationTile(
                  icon: Icons.school_outlined,
                  iconColor: AppColors.darkGray,
                  title: l10n.university,
                  subtitle: l10n.university,
                  onTap: () => _handleLocationSelection(
                    l10n.university,
                    l10n.university,
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForPlace(String iconName) {
    switch (iconName) {
      case 'local_hospital':
        return Icons.local_hospital_outlined;
      case 'flight':
        return Icons.flight_outlined;
      case 'shopping_bag':
        return Icons.shopping_bag_outlined;
      case 'school':
        return Icons.school_outlined;
      default:
        return Icons.place_outlined;
    }
  }

  void _handleLocationSelection(String address, String label) {
    // Navigate to choose driver screen with selected destination
    Navigator.pushNamed(
      context,
      '/choose-driver',
      arguments: {
        'pickup': AppConstants.currentLocationAddress,
        'destination': address,
        'destinationLabel': label,
      },
    );
  }
} 