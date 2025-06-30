import 'package:cloud_firestore/cloud_firestore.dart'; 

class Item {
  final String? id; 
  final String name;
  final String description;
  final Timestamp? timestamp;  

  Item({this.id, required this.name, required this.description, this.timestamp});

  factory Item.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Item(
      id: doc.id, 
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      timestamp: data['timestamp'] as Timestamp?, 
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'timestamp': FieldValue.serverTimestamp(),  
    };
  }
}