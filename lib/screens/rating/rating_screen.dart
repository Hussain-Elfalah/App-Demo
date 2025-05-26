import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../utils/font_helper.dart';
import '../../l10n/app_localizations.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  Map<String, dynamic>? arguments;
  String? selectedRating;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final driverName = arguments?['driverName'] ?? l10n.demoDriverName;
    final driverCar = arguments?['driverCar'] ?? l10n.demoDriverCar;

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
          l10n.rateYourDriver,
          style: FontHelper.getHeadingStyle(
            languageCode: Localizations.localeOf(context).languageCode,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.lg),

            // Driver Profile Section
            Column(
              children: [
                // Driver Avatar
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/Placeholder.jpg',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback to icon if image fails to load
                        return Container(
                          width: 120,
                          height: 120,
                          color: const Color(0xFF2A2A2A),
                          child: const Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 60,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.md),

                // Driver Name
                Text(
                  driverName,
                  style: FontHelper.getHeadingStyle(
                    languageCode: Localizations.localeOf(context).languageCode,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: AppSpacing.xs),

                // Driver Car
                Text(
                  driverCar,
                  style: FontHelper.getCaptionStyle(
                    languageCode: Localizations.localeOf(context).languageCode,
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.xl),

            // Rating Question
            Text(
              l10n.howWasYourRide,
              style: FontHelper.getHeadingStyle(
                languageCode: Localizations.localeOf(context).languageCode,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // Rating Buttons
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                _buildRatingButton(l10n.terrible),
                _buildRatingButton(l10n.bad),
                _buildRatingButton(l10n.okay),
                _buildRatingButton(l10n.good),
                _buildRatingButton(l10n.excellent),
              ],
            ),

            const SizedBox(height: AppSpacing.xl),

            // Additional Feedback Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.additionalFeedback,
                    style: FontHelper.getHeadingStyle(
                      languageCode: Localizations.localeOf(context).languageCode,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Feedback Text Field
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A2A2A),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(AppBorderRadius.medium),
                      ),
                      child: TextField(
                        controller: _feedbackController,
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        style: FontHelper.getBodyStyle(
                          languageCode: Localizations.localeOf(context).languageCode,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(AppSpacing.md),
                          hintText: l10n.tellUsAboutExperience,
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // Submit Button
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedRating != null ? _submitRating : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppBorderRadius.medium),
                  ),
                ),
                child: Text(
                  l10n.submit,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingButton(String rating) {
    final isSelected = selectedRating == rating;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRating = rating;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : const Color(0xFF2A2A2A),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(AppBorderRadius.large),
        ),
        child: Text(
          rating,
          style: FontHelper.getBodyStyle(
            languageCode: Localizations.localeOf(context).languageCode,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _submitRating() {
    final l10n = AppLocalizations.of(context)!;
    
    // Show success dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.medium),
        ),
        title: Text(
          l10n.thankYou,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          l10n.ratingSubmitted,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (route) => false,
              );
            },
            child: Text(
              l10n.ok,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 