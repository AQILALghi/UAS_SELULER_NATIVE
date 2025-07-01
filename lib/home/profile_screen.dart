import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crud_app/utils/app_styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameController;
  bool _isEditingName = false;
  bool _isSavingName = false;
  String? _nameError;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _saveName(User user) async {
    if (_nameController.text.trim().isEmpty) {
      setState(() {
        _nameError = 'Nama tidak boleh kosong';
      });
      return;
    }

    setState(() {
      _isSavingName = true;
      _nameError = null;
    });

    try {
      await user.updateDisplayName(_nameController.text.trim());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: const Text('Nama berhasil diperbarui!', style: TextStyle(color: Colors.white)), backgroundColor: Theme.of(context).colorScheme.secondary),
        );
      }
      setState(() {
        _isEditingName = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memperbarui nama: ${e.toString()}', style: const TextStyle(color: Colors.white)), backgroundColor: Theme.of(context).colorScheme.error),
        );
      }
      setState(() {
        _nameError = 'Gagal memperbarui nama.';
      });
    } finally {
      setState(() {
        _isSavingName = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator(color: theme.colorScheme.primary)),
          );
        }

        final User? currentUser = snapshot.data;

        if (currentUser == null) {
          return const Center(child: Text('Pengguna tidak login.'));
        }

        if (!_isEditingName) {
           _nameController = TextEditingController(text: currentUser.displayName ?? '');
        }

        final String currentDisplayName = currentUser.displayName ?? 'Pengguna Aplikasi';
        final String email = currentUser.email ?? 'email@aplikasi.com';
        final String uid = currentUser.uid;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Profil Saya'),
            centerTitle: true,
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            elevation: 4,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [theme.colorScheme.primary, theme.colorScheme.primaryContainer], 
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withOpacity(0.5),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(Icons.person, size: 80, color: theme.colorScheme.onPrimary),
                ),
                const SizedBox(height: 20),

                _isEditingName
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: 'Nama Lengkap',
                                hintText: 'Masukkan nama Anda',
                                errorText: _nameError,
                                border: const OutlineInputBorder(),
                                suffixIcon: _isSavingName
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Center(
                                          child: CircularProgressIndicator(strokeWidth: 2),
                                        ),
                                      )
                                    : IconButton(
                                        icon: Icon(Icons.check, color: theme.colorScheme.secondary),
                                        onPressed: () => _saveName(currentUser),
                                      ),
                              ),
                              onSubmitted: (value) => _saveName(currentUser),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isEditingName = false;
                                    _nameController.text = currentUser.displayName ?? '';
                                    _nameError = null;
                                  });
                                },
                                child: Text('Batal', style: AppStyles.smallBodyStyle.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.7))),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentDisplayName,
                            style: AppStyles.titleStyle.copyWith(color: theme.colorScheme.onBackground),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit, size: 20, color: theme.colorScheme.primary),
                            onPressed: () {
                              setState(() {
                                _isEditingName = true;
                                _nameController.text = currentDisplayName;
                              });
                            },
                            tooltip: 'Edit Nama',
                          ),
                        ],
                      ),
                const SizedBox(height: 10),

                Text(
                  email,
                  style: AppStyles.bodyStyle.copyWith(color: theme.colorScheme.onBackground.withOpacity(0.7)),
                ),
                const SizedBox(height: 5),
                Text(
                  'UID: $uid',
                  style: AppStyles.smallBodyStyle.copyWith(color: theme.colorScheme.onBackground.withOpacity(0.5)),
                ),
                const SizedBox(height: 30),

                Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildProfileInfoRow(Icons.person_outline, 'Nama', currentDisplayName, theme),
                        Divider(height: 20, color: theme.dividerColor),
                        _buildProfileInfoRow(Icons.email_outlined, 'Email', email, theme),
                        Divider(height: 20, color: theme.dividerColor),
                        _buildProfileInfoRow(Icons.vpn_key_outlined, 'User ID', uid, theme),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.info_outline, color: theme.colorScheme.primary),
                    title: Text('Tentang Aplikasi', style: AppStyles.bodyStyle),
                    trailing: Icon(Icons.chevron_right, color: theme.colorScheme.onSurface.withOpacity(0.7)),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: const Text('Versi Aplikasi 1.0.0'), backgroundColor: theme.colorScheme.primary),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.privacy_tip_outlined, color: theme.colorScheme.primary),
                    title: Text('Kebijakan Privasi', style: AppStyles.bodyStyle),
                    trailing: Icon(Icons.chevron_right, color: theme.colorScheme.onSurface.withOpacity(0.7)),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: const Text('Membuka Kebijakan Privasi...'), backgroundColor: theme.colorScheme.primary),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileInfoRow(IconData icon, String label, String value, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 24),
          const SizedBox(width: 15),
          Text('$label:', style: AppStyles.bodyStyle.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: AppStyles.bodyStyle.copyWith(color: theme.colorScheme.onSurface),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}