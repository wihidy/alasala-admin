import 'dart:ui';
import 'package:flutter/material.dart';

class LanguageManager {
  static final ValueNotifier<Locale> localeNotifier = ValueNotifier(const Locale('ar'));

  static void setLocale(String languageCode) {
    localeNotifier.value = Locale(languageCode);
  }

  static bool isArabic() => localeNotifier.value.languageCode == 'ar';
}

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'العربية (Arabic)';
  String _selectedCurrency = 'SAR (Riyal)';

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: LanguageManager.localeNotifier,
      builder: (context, currentLocale, child) {
        bool isArabic = currentLocale.languageCode == 'ar';
        Color textColor = const Color(0xFF1A3365);
        Color cardColor = Colors.white;
        Color scaffoldBg = const Color(0xFFF5F7FB);

        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            backgroundColor: scaffoldBg,
            appBar: AppBar(
              backgroundColor: const Color(0xFF1A3365),
              elevation: 0,
              title: Text(
                isArabic ? 'إعدادات النظام' : 'System Settings',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildSectionHeader(isArabic ? "التفضيلات العامة" : "General Preferences", textColor),
                const SizedBox(height: 12),
                _buildSettingsCard([
                  _buildDropdownTile(
                    isArabic ? "اللغة" : "Language",
                    _selectedLanguage,
                    Icons.language,
                    ['العربية (Arabic)', 'English'],
                    (val) {
                      setState(() {
                        _selectedLanguage = val!;
                        if (val.contains('Arabic')) {
                          LanguageManager.setLocale('ar');
                        } else {
                          LanguageManager.setLocale('en');
                        }
                      });
                    },
                    textColor,
                  ),
                  _buildDivider(),
                  _buildDropdownTile(
                    isArabic ? "العملة" : "Currency",
                    _selectedCurrency,
                    Icons.payments_outlined,
                    ['SAR (Riyal)', 'EGP (Pound)', 'USD (Dollar)'],
                    (val) => setState(() => _selectedCurrency = val!),
                    textColor,
                  ),
                ], cardColor),
                const SizedBox(height: 24),
                _buildSectionHeader(isArabic ? "التنبيهات" : "Notifications", textColor),
                const SizedBox(height: 12),
                _buildSettingsCard([
                  _buildSwitchTile(
                    isArabic ? "التنبيهات" : "Notifications",
                    _notificationsEnabled,
                    Icons.notifications_outlined,
                    (val) => setState(() => _notificationsEnabled = val),
                    textColor,
                  ),
                ], cardColor),
                const SizedBox(height: 24),
                _buildSectionHeader(isArabic ? "النظام والدعم" : "Support & System", textColor),
                const SizedBox(height: 12),
                _buildSettingsCard([
                  _buildActionTile(isArabic ? "حول التطبيق" : "About App", Icons.info_outline, textColor),
                  _buildDivider(),
                  _buildActionTile(isArabic ? "تواصل معنا" : "Contact Us", Icons.headset_mic_outlined, textColor),
                  _buildDivider(),
                  _buildActionTile(isArabic ? "سياسة الخصوصية" : "Privacy Policy", Icons.security_outlined, textColor),
                ], cardColor),
                const SizedBox(height: 40),
                Center(
                  child: Text(
                    "Version 1.0.0",
                    style: TextStyle(color: Colors.grey[400], fontSize: 12),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Text(
        title,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: textColor),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children, Color cardColor) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildDropdownTile(String title, String value, IconData icon, List<String> items, ValueChanged<String?> onChanged, Color textColor) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFD4AF37)),
      title: Text(title, style: TextStyle(fontSize: 15, color: textColor)),
      trailing: DropdownButton<String>(
        value: value,
        underline: const SizedBox(),
        dropdownColor: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF1E1E1E) : Colors.white,
        icon: const Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.grey),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: TextStyle(fontSize: 13, color: textColor)))).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value, IconData icon, ValueChanged<bool> onChanged, Color textColor) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFD4AF37)),
      title: Text(title, style: TextStyle(fontSize: 15, color: textColor)),
      trailing: Switch(
        value: value,
        activeColor: const Color(0xFFD4AF37),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildActionTile(String title, IconData icon, Color textColor) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFD4AF37)),
      title: Text(title, style: TextStyle(fontSize: 15, color: textColor)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      onTap: () {},
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, indent: 56, color: Colors.grey[100]);
  }
}