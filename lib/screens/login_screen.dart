import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/city.dart';
import '../models/user_profile.dart';
import '../providers/city_provider.dart';
import '../providers/language_provider.dart';
import '../providers/market_data_provider.dart';
import '../providers/user_provider.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isSignUp = false;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _staySignedIn = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _goHome(UserProfile user) {
    context.read<UserProvider>().login(user);
    context.read<CityProvider>().setCity(availableCities.first);
    context.read<MarketDataProvider>().updateCity(availableCities.first.name);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  Future<void> _handleLogin() async {
    final lang = context.read<LanguageProvider>();
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(lang.t('enter_username_password'))),
      );
      return;
    }

    try {
      final profile = await AuthService().login(username, password);
      _goHome(UserProfile(
        username: profile['username'] ?? username,
        email: profile['email'] ?? '$username@dalag.com',
        name: profile['name'] ?? username,
        city: profile['city'] ?? 'Hargeisa',
      ));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Login failed')),
      );
    }
  }

  Future<void> _handleSignUp() async {
    final lang = context.read<LanguageProvider>();
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    final confirm = _confirmPasswordController.text.trim();
    final email = _emailController.text.trim();
    final name = _nameController.text.trim();

    if (username.isEmpty || password.isEmpty || email.isEmpty || name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(lang.t('fill_all_fields'))),
      );
      return;
    }
    if (password != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(lang.t('passwords_not_match'))),
      );
      return;
    }

    try {
      final profile = await AuthService().register(
        username: username,
        password: password,
        name: name,
        city: 'Hargeisa',
      );
      _goHome(UserProfile(
        username: profile['username'],
        email: profile['email'],
        name: profile['name'],
        city: profile['city'],
      ));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Sign up failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(Icons.eco,
                        color: AppColors.primaryGreen, size: 40),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  _isSignUp
                      ? lang.t('create_account_title')
                      : lang.t('welcome_back'),
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primaryGreen),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  _isSignUp
                      ? lang.t('create_account_subtitle')
                      : lang.t('login_subtitle'),
                  textAlign: TextAlign.center,
                  style:
                      const TextStyle(color: AppColors.textGrey, height: 1.4),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_isSignUp) ...[
                      Text(lang.t('name'),
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: lang.t('full_name'),
                          prefixIcon: const Icon(Icons.person_outline),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(lang.t('email'),
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: lang.t('email_hint'),
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                      ),
                      const SizedBox(height: 18),
                    ],
                    Text(lang.t('username'),
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        hintText: lang.t('username_hint'),
                        prefixIcon: const Icon(Icons.person_outline),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(lang.t('password'),
                            style:
                                const TextStyle(fontWeight: FontWeight.w600)),
                        if (!_isSignUp)
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              lang.t('forgot_password'),
                              style: const TextStyle(
                                  color: AppColors.primaryGreen,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                          onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                    ),
                    if (_isSignUp) ...[
                      const SizedBox(height: 18),
                      Text(lang.t('confirm_password'),
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirm,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureConfirm
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                            onPressed: () => setState(
                                () => _obscureConfirm = !_obscureConfirm),
                          ),
                        ),
                      ),
                    ],
                    if (!_isSignUp) ...[
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Checkbox(
                            value: _staySignedIn,
                            activeColor: AppColors.primaryGreen,
                            onChanged: (v) =>
                                setState(() => _staySignedIn = v ?? false),
                          ),
                          Expanded(child: Text(lang.t('stay_signed_in'))),
                        ],
                      ),
                    ],
                    const SizedBox(height: 14),
                    ElevatedButton.icon(
                      onPressed: _isSignUp ? _handleSignUp : _handleLogin,
                      icon: Icon(
                          _isSignUp ? Icons.person_add : Icons.arrow_forward),
                      label: Text(_isSignUp
                          ? lang.t('create_account')
                          : lang.t('login')),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            lang.t('or_continue_with'),
                            style: const TextStyle(
                                color: AppColors.textGrey, fontSize: 12),
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(_isSignUp
                          ? lang.t('already_have_account')
                          : lang.t('new_to_dalag')),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () => setState(() => _isSignUp = !_isSignUp),
                      child: Text(_isSignUp
                          ? lang.t('sign_in')
                          : lang.t('create_account')),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.shield_outlined,
                        size: 16, color: AppColors.textGrey),
                    const SizedBox(width: 6),
                    Text(
                      lang.t('secure_access'),
                      style: const TextStyle(
                          color: AppColors.textGrey,
                          fontSize: 11,
                          letterSpacing: 0.6),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Center(
                child: Text(
                  lang.t('rights_reserved'),
                  style:
                      const TextStyle(color: AppColors.textGrey, fontSize: 11),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
