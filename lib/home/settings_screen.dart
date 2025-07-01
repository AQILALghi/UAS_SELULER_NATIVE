import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  
import 'package:crud_app/utils/app_styles.dart';
import 'package:crud_app/theme_provider.dart';  

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan Aplikasi', style: AppStyles.titleStyle.copyWith(color: theme.colorScheme.onBackground)),
        automaticallyImplyLeading: false,
        backgroundColor: theme.colorScheme.background,
        foregroundColor: theme.colorScheme.onBackground,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              child: SwitchListTile(
                title: Text('Aktifkan Notifikasi', style: AppStyles.bodyStyle),
                value: _notificationsEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Notifikasi ${value ? 'Diaktifkan' : 'Dinonaktifkan'}', style: const TextStyle(color: Colors.white)), backgroundColor: value ? theme.colorScheme.secondary : theme.colorScheme.error),
                  );
                },
                secondary: Icon(Icons.notifications_outlined, color: theme.colorScheme.primary),
                activeColor: theme.colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              child: Column(
                children: [
                  RadioListTile<ThemeMode>(
                    title: Text('Ikuti Sistem', style: AppStyles.bodyStyle),
                    value: ThemeMode.system,
                    groupValue: themeProvider.themeMode,
                    onChanged: (ThemeMode? mode) {
                      if (mode != null) {
                        themeProvider.setThemeMode(mode);
                      }
                    },
                    activeColor: theme.colorScheme.primary,
                    secondary: Icon(Icons.brightness_auto, color: theme.colorScheme.primary),
                  ),
                  RadioListTile<ThemeMode>(
                    title: Text('Mode Terang', style: AppStyles.bodyStyle),
                    value: ThemeMode.light,
                    groupValue: themeProvider.themeMode,
                    onChanged: (ThemeMode? mode) {
                      if (mode != null) {
                        themeProvider.setThemeMode(mode);
                      }
                    },
                    activeColor: theme.colorScheme.primary,
                    secondary: Icon(Icons.wb_sunny_outlined, color: theme.colorScheme.primary),
                  ),
                  RadioListTile<ThemeMode>(
                    title: Text('Mode Gelap', style: AppStyles.bodyStyle),
                    value: ThemeMode.dark,
                    groupValue: themeProvider.themeMode,
                    onChanged: (ThemeMode? mode) {
                      if (mode != null) {
                        themeProvider.setThemeMode(mode);
                      }
                    },
                    activeColor: theme.colorScheme.primary,
                    secondary: Icon(Icons.dark_mode_outlined, color: theme.colorScheme.primary),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Icon(Icons.language_outlined, color: theme.colorScheme.primary),
              title: Text('Bahasa', style: AppStyles.bodyStyle),
              subtitle: Text('Indonesia', style: AppStyles.smallBodyStyle.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.7))),
              trailing: Icon(Icons.chevron_right, color: theme.colorScheme.onSurface.withOpacity(0.7)),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: const Text('Pilihan Bahasa belum diimplementasikan', style: TextStyle(color: Colors.white)), backgroundColor: theme.colorScheme.secondary),
                );
              },
            ),
          ),
          Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Icon(Icons.info_outline, color: theme.colorScheme.primary),
              title: Text('Tentang Aplikasi', style: AppStyles.bodyStyle),
              trailing: Icon(Icons.chevron_right, color: theme.colorScheme.onSurface.withOpacity(0.7)),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'Aplikasi CRUD Sederhana',
                  applicationVersion: '1.0.0',
                  applicationLegalese: '© 2023 MyCompany',
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text('Aplikasi ini dibuat sebagai contoh implementasi frontend Flutter.', style: AppStyles.smallBodyStyle),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}