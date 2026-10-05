import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/auth_cubit.dart';
import '../../../../core/constants/colors.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _otpController = TextEditingController();
  final _nameController = TextEditingController();
  
  bool _isSignUp = false;
  bool _otpSent = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _otpController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _submit() {
    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();
    
    if (phone.isNotEmpty && password.isNotEmpty) {
      if (_isSignUp) {
        if (!_otpSent) {
          setState(() {
            _otpSent = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('OTP Code sent to your phone!'),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
          return;
        }
        if (_otpController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter the OTP code')),
          );
          return;
        }
      }
      
      // Call Cubit
      context.read<AuthCubit>().login(phone: phone, password: password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo
              Image.asset(
                'assets/images/logo.png',
                height: 100,
              ),
              const SizedBox(height: 32),
              
              // Title
              Text(
                _isSignUp ? 'Create Account' : 'Welcome Back',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _isSignUp ? 'Sign up to get started' : 'Sign in to continue',
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 16),
              ),
              const SizedBox(height: 40),

              // Name Field (Only on Sign Up)
              if (_isSignUp) ...[
                _buildTextField(
                  controller: _nameController,
                  icon: Icons.person_outline,
                  hint: 'Full Name',
                ),
                const SizedBox(height: 16),
              ],

              // Phone Field
              _buildTextField(
                controller: _phoneController,
                icon: Icons.phone_android,
                hint: 'Phone Number (e.g. 0555...)',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),

              // Password Field (Mot de Passe)
              _buildTextField(
                controller: _passwordController,
                icon: Icons.lock_outline,
                hint: 'Mot de passe',
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
              
              // OTP Field (Only if Sign Up and OTP Sent)
              if (_isSignUp && _otpSent) ...[
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _otpController,
                  icon: Icons.message_outlined,
                  hint: 'Enter 6-digit OTP',
                  keyboardType: TextInputType.number,
                ),
              ],
              
              // Forgot Password
              if (!_isSignUp)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Forgot Password?', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
                  ),
                ),

              SizedBox(height: _isSignUp ? 32 : 16),

              // Submit Button
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 5,
                    shadowColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                  ),
                  child: Text(
                    _isSignUp 
                        ? (_otpSent ? 'Verify & Register' : 'Send OTP')
                        : 'Sign In',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Toggle Sign In / Sign Up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isSignUp ? 'Already have an account?' : "Don't have an account?",
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isSignUp = !_isSignUp;
                        _otpSent = false;
                      });
                    },
                    child: Text(
                      _isSignUp ? 'Sign In' : 'Sign Up',
                      style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
        prefixIcon: Icon(icon, color: Theme.of(context).colorScheme.onSurfaceVariant),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.black.withValues(alpha: 0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.white10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.white10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 20),
      ),
    );
  }
}
