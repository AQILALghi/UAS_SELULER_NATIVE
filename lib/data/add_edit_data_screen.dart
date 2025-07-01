import 'package:flutter/material.dart';
import 'package:crud_app/data/data_model.dart';
import 'package:crud_app/data/data_service.dart';
import 'package:crud_app/utils/app_styles.dart';

class AddEditDataScreen extends StatefulWidget {
  final Item? item;

  const AddEditDataScreen({super.key, this.item});

  @override
  State<AddEditDataScreen> createState() => _AddEditDataScreenState();
}

class _AddEditDataScreenState extends State<AddEditDataScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final DataService _dataService = DataService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _nameController.text = widget.item!.name;
      _descriptionController.text = widget.item!.description;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveData() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final itemToSave = Item(
        id: widget.item?.id,
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
      );

      try {
        if (widget.item == null) {
          await _dataService.addItem(itemToSave);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: const Text('Data berhasil ditambahkan!', style: TextStyle(color: Colors.white)), backgroundColor: Theme.of(context).colorScheme.secondary),
            );
          }
        } else {
          await _dataService.updateItem(widget.item!.id!, itemToSave);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: const Text('Data berhasil diperbarui!', style: TextStyle(color: Colors.white)), backgroundColor: Theme.of(context).colorScheme.secondary),
            );
          }
        }
        if (mounted) {
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Terjadi kesalahan: ${e.toString()}', style: const TextStyle(color: Colors.white)), backgroundColor: Theme.of(context).colorScheme.error),
          );
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item == null ? 'Tambah Item Baru' : 'Edit Item'),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.item == null
                    ? 'Isi detail item baru'
                    : 'Edit detail item',
                style: AppStyles.subtitleStyle.copyWith(color: theme.colorScheme.onBackground),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nama Item',
                  hintText: 'Misal: Laptop',
                  prefixIcon: Icon(Icons.label_outline, color: theme.colorScheme.primary),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama item tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Deskripsi Item',
                  hintText: 'Deskripsi lengkap tentang item',
                  prefixIcon: Icon(Icons.description_outlined, color: theme.colorScheme.primary),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Deskripsi item tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              _isLoading
                  ? Center(child: CircularProgressIndicator(color: theme.colorScheme.primary))
                  : ElevatedButton(
                    onPressed: _saveData,
                    child: Text(
                      widget.item == null ? 'Simpan Data' : 'Perbarui Data',
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}