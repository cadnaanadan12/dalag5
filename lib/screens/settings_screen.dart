import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/city.dart';
import '../providers/city_provider.dart';
import '../providers/language_provider.dart';
import '../providers/notification_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';
import 'add_price_screen.dart';
import 'help_support_screen.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'markets_screen.dart';
import 'privacy_policy_screen.dart';
import 'profile_edit_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _onNavTap(BuildContext context, int index) {
    if (index == 3) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) {
          switch (index) {
            case 0:
              return const HomeScreen();
            case 1:
              return const MarketsScreen();
            default:
              return const AddPriceScreen();
          }
        },
      ),
    );
  }

  void _showLanguageSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) {
        return Consumer<LanguageProvider>(
          builder: (context, lang, _) => Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(lang.t('language'),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700)),
                const SizedBox(height: 16),
                RadioListTile<String>(
                  value: 'en',
                  groupValue: lang.langCode,
                  activeColor: AppColors.primaryGreen,
                  title: const Text('English'),
                  onChanged: (v) => lang.setLanguage('en'),
                ),
                RadioListTile<String>(
                  value: 'so',
                  groupValue: lang.langCode,
                  activeColor: AppColors.primaryGreen,
                  title: const Text('Soomaali'),
                  onChanged: (v) => lang.setLanguage('so'),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCityPreferencesSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) {
        return Consumer2<LanguageProvider, CityProvider>(
          builder: (context, lang, cityProvider, _) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    lang.t('select_preferred_city'),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 16),
                  ...availableCities.map((c) {
                    return RadioListTile<String>(
                      value: c.id,
                      groupValue: cityProvider.currentCity.id,
                      activeColor: AppColors.primaryGreen,
                      title: Text(c.name),
                      onChanged: (_) {
                        cityProvider.setCity(c);
                        Navigator.pop(context);
                      },
                    );
                  }),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final user = context.watch<UserProvider>();
    final theme = context.watch<ThemeProvider>();
    final notification = context.watch<NotificationProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.agriculture, color: AppColors.primaryGreen),
            SizedBox(width: 6),
            Text('Dalag'),
          ],
        ),
      ),
      bottomNavigationBar:
          DalagBottomNav(currentIndex: 3, onTap: (i) => _onNavTap(context, i)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ProfileEditScreen())),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.lightGreenChip,
                        backgroundImage: user.user?.photoPath != null
                            ? FileImage(File(user.user!.photoPath!))
                            : null,
                        child: user.user?.photoPath == null
                            ? const Icon(Icons.person,
                                size: 32, color: AppColors.primaryGreen)
                            : null,
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: AppColors.primaryGreen,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.edit,
                              size: 12, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.user?.name ?? lang.t('guest'),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          user.user?.city ?? 'Hargeisa',
                          style: const TextStyle(color: AppColors.textGrey),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: AppColors.textGrey),
                ],
              ),
            ),
          ),
          const SizedBox(height: 22),
          Text(
            lang.t('preferences'),
            style: const TextStyle(
              color: AppColors.primaryGreen,
              fontWeight: FontWeight.w700,
              fontSize: 12,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _settingsTile(
                  context,
                  icon: Icons.notifications_outlined,
                  title: lang.t('notification_settings'),
                  subtitle: lang.t('notification_sub'),
                  trailing: Switch(
                    value: notification.priceAlerts,
                    onChanged: (_) => notification.togglePriceAlerts(),
                    activeColor: AppColors.primaryGreen,
                  ),
                  onTap: () {},
                ),
                const Divider(height: 1, indent: 60),
                _settingsTile(
                  context,
                  icon: Icons.translate,
                  title: lang.t('language'),
                  subtitle: lang.t('language_sub'),
                  trailingLabel: lang.isSomali ? 'SOOMAALI' : 'ENGLISH',
                  onTap: () => _showLanguageSheet(context),
                ),
                const Divider(height: 1, indent: 60),
                _settingsTile(
                  context,
                  icon: Icons.map_outlined,
                  title: lang.t('city_preferences'),
                  subtitle: lang.t('city_pref_sub'),
                  onTap: () => _showCityPreferencesSheet(context),
                ),
                const Divider(height: 1, indent: 60),
                _settingsTile(
                  context,
                  icon: theme.isDark ? Icons.light_mode : Icons.dark_mode,
                  title: lang.t('dark_mode'),
                  subtitle: theme.isDark
                      ? lang.t('dark_mode_on')
                      : lang.t('dark_mode_off'),
                  trailing: Switch(
                    value: theme.isDark,
                    onChanged: (_) => theme.toggleTheme(),
                    activeColor: AppColors.primaryGreen,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Text(
            lang.t('support'),
            style: const TextStyle(
              color: AppColors.primaryGreen,
              fontWeight: FontWeight.w700,
              fontSize: 12,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _settingsTile(
                  context,
                  icon: Icons.help_outline,
                  title: lang.t('help_support'),
                  subtitle: lang.t('help_sub'),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const HelpSupportScreen())),
                ),
                const Divider(height: 1, indent: 60),
                _settingsTile(
                  context,
                  icon: Icons.privacy_tip_outlined,
                  title: lang.t('privacy_policy'),
                  subtitle: lang.t('privacy_sub'),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const PrivacyPolicyScreen())),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.danger,
              side: const BorderSide(color: AppColors.danger),
            ),
            icon: const Icon(Icons.logout),
            label: Text(lang.t('logout')),
            onPressed: () {
              context.read<UserProvider>().logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              lang.t('app_version'),
              style: const TextStyle(color: AppColors.textGrey, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    String? trailingLabel,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: AppColors.beige,
        foregroundColor: AppColors.primaryGreen,
        child: Icon(icon, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle,
          style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
      trailing: trailing ??
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (trailingLabel != null) ...[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.lightGreenChip,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    trailingLabel,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.primaryGreen,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
              ],
              const Icon(Icons.chevron_right, color: AppColors.textGrey),
            ],
          ),
    );
  }
}
