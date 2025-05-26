import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart';
import '../../utils/font_helper.dart';
import '../../widgets/common/settings_tile.dart';
import '../../widgets/common/bottom_navigation.dart';
import '../../services/language_service.dart';
import '../../l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
          l10n.settings,
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
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                // User Profile Section
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: [
                      // Profile Avatar
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.mediumGray,
                            width: 1,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/Placeholder.jpg',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              // Fallback to icon if image fails to load
                              return Container(
                                width: 60,
                                height: 60,
                                color: AppColors.lightGray,
                                child: const Icon(
                                  Icons.person,
                                  color: AppColors.mediumGray,
                                  size: 30,
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      const SizedBox(width: AppSpacing.md),

                      // User Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.userName,
                              style: FontHelper.getBodyStyle(
                                languageCode: Localizations.localeOf(context).languageCode,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              l10n.userPhone,
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
                ),

                const SizedBox(height: AppSpacing.lg),

                // Account Section
                Text(
                  l10n.account,
                  style: FontHelper.getHeadingStyle(
                    languageCode: Localizations.localeOf(context).languageCode,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SettingsTile(
                  icon: Icons.history,
                  title: l10n.rideHistory,
                  onTap: () => _handleMenuTap(context, 'history'),
                ),
                SettingsTile(
                  icon: Icons.notifications,
                  title: l10n.notifications,
                  onTap: () => _handleMenuTap(context, 'notifications'),
                ),
                SettingsTile(
                  icon: Icons.language,
                  title: l10n.language,
                  onTap: () => _showLanguageDialog(context),
                ),

                const SizedBox(height: AppSpacing.xl),

                // Support Section
                Text(
                  l10n.support,
                  style: FontHelper.getHeadingStyle(
                    languageCode: Localizations.localeOf(context).languageCode,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: AppSpacing.md),

                SettingsTile(
                  icon: Icons.help_center,
                  title: l10n.helpCenter,
                  onTap: () => _handleMenuTap(context, 'help'),
                ),
                SettingsTile(
                  icon: Icons.contact_support,
                  title: l10n.contactUs,
                  onTap: () => _handleMenuTap(context, 'contact'),
                ),

                const SizedBox(height: AppSpacing.xl),

                // Sign Out Button
                Container(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => _showSignOutDialog(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.error),
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppBorderRadius.medium),
                      ),
                    ),
                    child: Text(
                      l10n.signOut,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.error,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),

          // Bottom Navigation
          const BottomNavigation(currentIndex: 3),
        ],
      ),
    );
  }

  void _handleMenuTap(BuildContext context, String route) {
    final l10n = AppLocalizations.of(context)!;
    
    // For demo purposes, show a placeholder dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.medium),
        ),
        title: Text(
          l10n.comingSoon,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          l10n.featureComingSoon,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
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

  void _showLanguageDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final languageService = Provider.of<LanguageService>(context, listen: false);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.medium),
        ),
        title: Text(
          l10n.selectLanguage,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Radio<String>(
                value: 'en',
                groupValue: languageService.currentLocale.languageCode,
                onChanged: (value) {
                  if (value != null) {
                    languageService.changeLanguage(value);
                    Navigator.pop(context);
                    _showLanguageChangedDialog(context);
                  }
                },
                activeColor: AppColors.primary,
              ),
              title: Text(
                l10n.english,
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () {
                languageService.changeLanguage('en');
                Navigator.pop(context);
                _showLanguageChangedDialog(context);
              },
            ),
            ListTile(
              leading: Radio<String>(
                value: 'ar',
                groupValue: languageService.currentLocale.languageCode,
                onChanged: (value) {
                  if (value != null) {
                    languageService.changeLanguage(value);
                    Navigator.pop(context);
                    _showLanguageChangedDialog(context);
                  }
                },
                activeColor: AppColors.primary,
              ),
              title: Text(
                l10n.arabic,
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () {
                languageService.changeLanguage('ar');
                Navigator.pop(context);
                _showLanguageChangedDialog(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              l10n.close,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageChangedDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.medium),
        ),
        title: Text(
          l10n.languageChanged,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          l10n.languageChangedMessage,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
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

  void _showSignOutDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.medium),
        ),
        title: Text(
          l10n.signOut,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          l10n.signOutConfirmation,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              l10n.cancel,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
            child: Text(
              l10n.signOut,
              style: const TextStyle(
                color: AppColors.error,
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