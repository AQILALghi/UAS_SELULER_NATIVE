import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:flutter/material.dart';  
import 'package:crud_app/data/data_model.dart';

class DataService extends ChangeNotifier { 
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> addItem(Item item) async {
    try {
      await _db.collection('items').add(item.toMap());
      notifyListeners(); 
      print('Item added successfully: ${item.name}');
    } catch (e) {
      print('Error adding item: $e'); 
      throw Exception('Gagal menambahkan data: ${e.toString()}');
    }
  }

  Stream<List<Item>> getItems() {
    return _db.collection('items')
              .orderBy('timestamp', descending: true)  
              .snapshots()
              .map((snapshot) =>
                  snapshot.docs.map((doc) => Item.fromFirestore(doc)).toList());
  }

  Future<Item?> getItemById(String id) async {
    try {
      DocumentSnapshot doc = await _db.collection('items').doc(id).get();
      if (doc.exists && doc.data() != null) {
        return Item.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      print('Error getting item by ID: $e');
      throw Exception('Gagal mendapatkan data berdasarkan ID: ${e.toString()}');
    }
  }

  Future<void> updateItem(String id, Item updatedItem) async {
    try {
      // Memperbarui dokumen berdasarkan ID-nya
      await _db.collection('items').doc(id).update(updatedItem.toMap());
      notifyListeners(); 
      print('Item updated successfully: ${updatedItem.name}');
    } catch (e) {
      print('Error updating item: $e');
      throw Exception('Gagal memperbarui data: ${e.toString()}');
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await _db.collection('items').doc(id).delete();
      notifyListeners(); 
      print('Item deleted successfully: $id');
    } catch (e) {
      print('Error deleting item: $e');
      throw Exception('Gagal menghapus data: ${e.toString()}');
    }
  }
}