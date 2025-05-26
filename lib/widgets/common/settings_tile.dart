import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../utils/font_helper.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppBorderRadius.medium),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            // Icon
            Icon(
              icon,
              color: Colors.grey,
              size: 24,
            ),
            
            const SizedBox(width: AppSpacing.md),
            
            // Title
            Expanded(
              child: Text(
                title,
                style: FontHelper.getBodyStyle(
                  languageCode: Localizations.localeOf(context).languageCode,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            
            // Arrow
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
} 