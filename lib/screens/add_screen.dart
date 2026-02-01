import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  // TODO: 12. Initialize Controllers, Key, and Reference


  // TODO: 15. Dispose the controllers
  @override
  void dispose() {
    super.dispose();
  }

  // TODO: 16. This is how initState works
  @override
  void initState() {
    super.initState();
  }

  // TODO: 14. Implement the submit function to add data to Firestore
  Future<void> _handleSubmit() async {
  }

  // TODO: 13. Create the form with validation
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Idea"),
      ),
      body: const Center(child: Text("Form to add new data into the List")
    ));
  }
}
