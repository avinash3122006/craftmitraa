import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../providers/auth_provider.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/typography.dart';
import '../customer/customer_home.dart';
import 'register_screen.dart';
import 'role_selection_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthProvider _authProvider = AuthProvider();
  bool _isSubmitting = false;
  String? _errorMessage;

  Future<void> _submitLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = 'Email and password are required.');
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    try {
      await _authProvider.login(email: email, password: password);
      if (!mounted) return;

      if (_authProvider.isAuthenticated) {
        final route = _authProvider.currentUserOrFallback.role == UserRole.artisan
            ? const RoleSelectionScreen()
            : const CustomerHomeScreen();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => route),
        );
        return;
      }

      setState(() => _errorMessage = 'Authentication failed. Please try again.');
    } catch (error) {
      setState(() => _errorMessage = error.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmCream,
      appBar: AppBar(
        title: const Text('CraftMitra AI'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppDimensions.paddingPage,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome Back', style: AppTypography.headlineLg),
              const SizedBox(height: 6),
              Text(
                'Sign in with your email and password to continue.',
                style: AppTypography.bodyMd,
              ),
              const SizedBox(height: AppDimensions.spaceLg),
              Container(
                padding: const EdgeInsets.all(AppDimensions.spaceMd),
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: AppDimensions.roundedLg,
                  boxShadow: const [AppColors.pressedShadow],
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spaceMd),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                      ),
                    ),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: AppDimensions.spaceMd),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.error.withValues(alpha: 0.08),
                          borderRadius: AppDimensions.roundedMd,
                        ),
                        child: Text(
                          _errorMessage!,
                          style: AppTypography.bodySm.copyWith(color: AppColors.error),
                        ),
                      ),
                    ],
                    const SizedBox(height: AppDimensions.spaceMd),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isSubmitting ? null : _submitLogin,
                        child: _isSubmitting
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('Login'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimensions.spaceMd),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                    );
                  },
                  child: const Text('Create account'),
                ),
              ),
              const SizedBox(height: AppDimensions.spaceMd),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
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
