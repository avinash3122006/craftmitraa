import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/typography.dart';
import 'role_selection_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _otpSent = false;
  final TextEditingController _otpController = TextEditingController();
  String _selectedLang = 'English';

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmCream,
      appBar: AppBar(
        title: const Text('CraftMitra AI'),
        actions: [
          PopupMenuButton<String>(
            initialValue: _selectedLang,
            onSelected: (val) {
              setState(() => _selectedLang = val);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.language_rounded, size: 18, color: AppColors.terracotta),
                  const SizedBox(width: 4),
                  Text(
                    _selectedLang,
                    style: AppTypography.labelSm.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.terracotta,
                    ),
                  ),
                ],
              ),
            ),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'English', child: Text('English')),
              const PopupMenuItem(value: 'हिन्दी', child: Text('हिन्दी (Hindi)')),
              const PopupMenuItem(value: 'राजस्थानी', child: Text('राजस्थानी (Rajasthani)')),
              const PopupMenuItem(value: 'मैथिली', child: Text('मैथिली (Maithili)')),
              const PopupMenuItem(value: 'বাংলা', child: Text('বাংলা (Bengali)')),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppDimensions.paddingPage,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back',
                style: AppTypography.headlineLg,
              ),
              const SizedBox(height: 6),
              Text(
                'Enter your mobile number to sign in or register as an artisan or buyer.',
                style: AppTypography.bodyMd,
              ),
              const SizedBox(height: AppDimensions.spaceLg),

              // Phone number input
              Container(
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: AppDimensions.roundedLg,
                  boxShadow: const [AppColors.pressedShadow],
                ),
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  style: AppTypography.bodyLg,
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                      child: Text(
                        '+91',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.onSurface,
                        ),
                      ),
                    ),
                    hintText: 'Enter 10-digit mobile number',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.spaceMd),

              if (_otpSent) ...[
                Text(
                  'Enter 4-digit OTP sent via SMS / WhatsApp',
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.pureWhite,
                    borderRadius: AppDimensions.roundedLg,
                    boxShadow: const [AppColors.pressedShadow],
                  ),
                  child: TextField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    style: AppTypography.headlineSm.copyWith(letterSpacing: 8),
                    decoration: const InputDecoration(
                      counterText: '',
                      hintText: '••••',
                      prefixIcon: Icon(Icons.lock_outline_rounded, color: AppColors.outline),
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.spaceMd),
              ],

              ElevatedButton(
                onPressed: () {
                  if (!_otpSent) {
                    setState(() => _otpSent = true);
                  } else {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const RoleSelectionScreen(),
                      ),
                    );
                  }
                },
                child: Text(_otpSent ? 'Verify OTP & Continue' : 'Get OTP on Phone'),
              ),
              const SizedBox(height: AppDimensions.spaceMd),

              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const RoleSelectionScreen(),
                      ),
                    );
                  },
                  child: const Text('Skip Login for Now (Explore Guest Mode)'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
