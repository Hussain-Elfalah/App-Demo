import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../utils/font_helper.dart';
import '../../l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo/Title
              Text(
                l10n.sixtRide,
                style: FontHelper.getHeadingStyle(
                  languageCode: Localizations.localeOf(context).languageCode,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              
              const SizedBox(height: AppSpacing.xxl),

              // Welcome Text
              Text(
                l10n.welcomeBack,
                style: FontHelper.getHeadingStyle(
                  languageCode: Localizations.localeOf(context).languageCode,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: AppSpacing.lg),

              // Phone Field
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(AppBorderRadius.medium),
                ),
                child: TextField(
                  controller: _emailController,
                  style: FontHelper.getBodyStyle(
                    languageCode: Localizations.localeOf(context).languageCode,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    labelText: l10n.phoneNumber,
                    hintText: l10n.enterPhoneNumber,
                    labelStyle: FontHelper.getCaptionStyle(
                      languageCode: Localizations.localeOf(context).languageCode,
                      color: Colors.grey,
                    ),
                    hintStyle: FontHelper.getCaptionStyle(
                      languageCode: Localizations.localeOf(context).languageCode,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(AppSpacing.md),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppBorderRadius.medium),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          l10n.continueButton,
                          style: FontHelper.getButtonStyle(
                            languageCode: Localizations.localeOf(context).languageCode,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // Or continue with
              Text(
                l10n.orContinueWith,
                style: FontHelper.getCaptionStyle(
                  languageCode: Localizations.localeOf(context).languageCode,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // Skip for now
              TextButton(
                onPressed: _handleDemoLogin,
                child: Text(
                  l10n.skipForNow,
                  style: FontHelper.getCaptionStyle(
                    languageCode: Localizations.localeOf(context).languageCode,
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogin() async {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.enterPhoneNumber),
          backgroundColor: const Color(0xFF2A2A2A),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate login delay
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });

    // For demo, always succeed
    Navigator.pushReplacementNamed(context, '/home');
  }

  void _handleDemoLogin() {
    Navigator.pushReplacementNamed(context, '/home');
  }
} 