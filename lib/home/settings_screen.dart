import 'package:flutter/material.dart';
import 'package:crud_app/utils/app_styles.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan Aplikasi', style: AppStyles.titleStyle.copyWith(color: AppColors.textPrimary)),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
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
                    SnackBar(content: Text('Notifikasi ${value ? 'Diaktifkan' : 'Dinonaktifkan'}', style: TextStyle(color: Colors.white)), backgroundColor: value ? AppColors.success : AppColors.error),
                  );
                },
                secondary: const Icon(Icons.notifications_outlined, color: AppColors.primary),
                activeColor: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: const Icon(Icons.info_outline, color: AppColors.primary),
              title: Text('Tentang Aplikasi', style: AppStyles.bodyStyle),
              trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'Aplikasi CRUD Sederhana',
                  applicationVersion: '1.0.0',
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text('Tugas Flutter UAS.', style: AppStyles.smallBodyStyle),
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