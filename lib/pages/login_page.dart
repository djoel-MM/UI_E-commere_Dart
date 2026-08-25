import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  UserRole _role = UserRole.user;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<Auth>().login(_emailController.text, _role);
      Navigator.pushReplacementNamed(
          context, _role == UserRole.admin ? '/admin' : '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHeader(),
                const SizedBox(height: 28.0),
                _buildRolePicker(),
                const SizedBox(height: 24.0),
                _buildEmailField(),
                const SizedBox(height: 16.0),
                _buildPasswordField(),
                const SizedBox(height: 8.0),
                _buildForgotLink(context),
                const SizedBox(height: 16.0),
                _buildLoginButton(),
                const SizedBox(height: 12.0),
                _buildSignupLink(context),
                const SizedBox(height: 20.0),
                _buildDemoHint(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0F766E), Color(0xFF14B8A6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Icon(Icons.storefront, size: 44, color: Colors.white),
        ),
        const SizedBox(height: 16),
        const Text(
          'TealShop',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F766E),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          _role == UserRole.admin
              ? 'Masuk sebagai Admin Toko'
              : 'Masuk untuk melanjutkan belanja',
          style: TextStyle(fontSize: 14.0, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildRolePicker() {
    return SegmentedButton<UserRole>(
      segments: const [
        ButtonSegment(
          value: UserRole.user,
          icon: Icon(Icons.person_outline, size: 18),
          label: Text('Pembeli'),
        ),
        ButtonSegment(
          value: UserRole.admin,
          icon: Icon(Icons.admin_panel_settings_outlined, size: 18),
          label: Text('Admin'),
        ),
      ],
      selected: {_role},
      showSelectedIcon: false,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const Color(0xFF0D9488);
          }
          return Colors.white;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return Colors.grey.shade700;
        }),
        side: WidgetStateProperty.all(
            const BorderSide(color: Color(0xFF0D9488))),
      ),
      onSelectionChanged: (roles) => setState(() => _role = roles.first),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        prefixIcon: const Icon(Icons.email, color: Color(0xFF0D9488)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        final emailRegex = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');
        if (!emailRegex.hasMatch(value)) {
          return 'Please enter a valid email format';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: const Icon(Icons.lock, color: Color(0xFF0D9488)),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: const Color(0xFF0D9488),
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }

  Widget _buildForgotLink(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Reset password terkirim ke email kamu (demo)')),
          );
        },
        child: const Text(
          'Lupa password?',
          style: TextStyle(color: Color(0xFF0D9488)),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0D9488),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text('Login',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildSignupLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Baru di TealShop? ',
          style: TextStyle(color: Colors.grey.shade600),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/register'),
          child: const Text(
            'Daftar',
            style: TextStyle(
              color: Color(0xFF0D9488),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDemoHint() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0D9488).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: const Color(0xFF0D9488).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, size: 18, color: Color(0xFF0D9488)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Demo: email & password apa pun yang valid formatnya diterima. Pilih role Admin untuk masuk ke dashboard.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.teal.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
