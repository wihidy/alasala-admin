import 'dart:ui';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'العربية (Arabic)';
  String _selectedCurrency = 'SAR (Riyal)';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A3365),
        elevation: 0,
        title: const Text(
          'إعدادات النظام / Settings',
          style: TextStyle(color: Colors.white, fontSize: 18),
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
          _buildSectionHeader("التفضيلات العامة / General"),
          const SizedBox(height: 12),
          _buildSettingsCard([
            _buildDropdownTile(
              "اللغة / Language",
              _selectedLanguage,
              Icons.language,
              ['العربية (Arabic)', 'English'],
              (val) => setState(() => _selectedLanguage = val!),
            ),
            _buildDivider(),
            _buildDropdownTile(
              "العملة / Currency",
              _selectedCurrency,
              Icons.payments_outlined,
              ['SAR (Riyal)', 'EGP (Pound)', 'USD (Dollar)'],
              (val) => setState(() => _selectedCurrency = val!),
            ),
          ]),
          const SizedBox(height: 24),
          _buildSectionHeader("المظهر والتنبيهات / Appearance"),
          const SizedBox(height: 12),
          _buildSettingsCard([
            _buildSwitchTile(
              "الوضع الليلي / Dark Mode",
              _isDarkMode,
              Icons.dark_mode_outlined,
              (val) => setState(() => _isDarkMode = val),
            ),
            _buildDivider(),
            _buildSwitchTile(
              "التنبيهات / Notifications",
              _notificationsEnabled,
              Icons.notifications_outlined,
              (val) => setState(() => _notificationsEnabled = val),
            ),
          ]),
          const SizedBox(height: 24),
          _buildSectionHeader("النظام والدعم / Support"),
          const SizedBox(height: 12),
          _buildSettingsCard([
            _buildActionTile("حول التطبيق / About App", Icons.info_outline),
            _buildDivider(),
            _buildActionTile("تواصل معنا / Contact Us", Icons.headset_mic_outlined),
            _buildDivider(),
            _buildActionTile("سياسة الخصوصية / Privacy Policy", Icons.security_outlined),
          ]),
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
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1A3365)),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildDropdownTile(String title, String value, IconData icon, List<String> items, ValueChanged<String?> onChanged) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF1A3365)),
      title: Text(title, style: const TextStyle(fontSize: 15)),
      trailing: DropdownButton<String>(
        value: value,
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down, size: 20),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 13)))).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value, IconData icon, ValueChanged<bool> onChanged) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF1A3365)),
      title: Text(title, style: const TextStyle(fontSize: 15)),
      trailing: Switch(
        value: value,
        activeColor: const Color(0xFF1A3365),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildActionTile(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF1A3365)),
      title: Text(title, style: const TextStyle(fontSize: 15)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      onTap: () {},
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, indent: 56, color: Colors.grey[100]);
  }
}
