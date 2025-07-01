import 'package:flutter/material.dart';
import 'package:crud_app/data/data_model.dart';
import 'package:crud_app/data/data_service.dart';
import 'package:crud_app/utils/app_router.dart';
import 'package:crud_app/utils/app_styles.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DataService _dataService = DataService();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Item', style: AppStyles.titleStyle.copyWith(color: theme.colorScheme.onBackground)),
        automaticallyImplyLeading: false,
        backgroundColor: theme.colorScheme.background,
        foregroundColor: theme.colorScheme.onBackground,
        elevation: 0,
      ),
      body: StreamBuilder<List<Item>>(
        stream: _dataService.getItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: theme.colorScheme.primary));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error memuat data: ${snapshot.error}', style: AppStyles.smallBodyStyle.copyWith(color: theme.colorScheme.error)));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox, size: 80, color: theme.colorScheme.onBackground.withOpacity(0.5)),
                  const SizedBox(height: 16),
                  Text('Belum ada data.', style: AppStyles.bodyStyle.copyWith(color: theme.colorScheme.onBackground)),
                  Text('Klik tombol tambah untuk mulai!', style: AppStyles.smallBodyStyle.copyWith(color: theme.colorScheme.onBackground.withOpacity(0.7))),
                ],
              ),
            );
          }

          final items = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListTile(
                  key: ValueKey(item.id),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  title: Text(item.name, style: AppStyles.subtitleStyle.copyWith(color: theme.colorScheme.onSurface)),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(item.description, style: AppStyles.smallBodyStyle.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.7))),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: theme.colorScheme.primary),
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRoutes.editData, arguments: item);
                        },
                        tooltip: 'Edit Item',
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: theme.colorScheme.error),
                        onPressed: () {
                          if (item.id != null) {
                            _showDeleteConfirmationDialog(item.id!);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: const Text('ID item tidak ditemukan.'), backgroundColor: theme.colorScheme.error),
                            );
                          }
                        },
                        tooltip: 'Hapus Item',
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.addData);
        },
        child: const Icon(Icons.add), 
      ),
    );
  }

  void _showDeleteConfirmationDialog(String itemId) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: theme.colorScheme.surface,  
          title: Text('Konfirmasi Hapus', style: AppStyles.subtitleStyle.copyWith(color: theme.colorScheme.onSurface)),
          content: Text('Anda yakin ingin menghapus data ini?', style: AppStyles.bodyStyle.copyWith(color: theme.colorScheme.onSurface)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal', style: AppStyles.buttonTextStyle.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.7))),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _dataService.deleteItem(itemId);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: const Text('Data berhasil dihapus!', style: TextStyle(color: Colors.white)), backgroundColor: theme.colorScheme.secondary),
                    );
                    Navigator.of(context).pop();
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Gagal menghapus data: ${e.toString()}', style: const TextStyle(color: Colors.white)), backgroundColor: theme.colorScheme.error),
                    );
                    Navigator.of(context).pop();
                  }
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: theme.colorScheme.error, foregroundColor: theme.colorScheme.onError),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }
}