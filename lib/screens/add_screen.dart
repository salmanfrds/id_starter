import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  // TODO: 12. Initialize Controllers, Key, and Reference
  final collectionRef = FirebaseFirestore.instance.collection("ideaBoard");
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // TODO: 15. Dispose the controllers
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  // TODO: 16. This is how initState works
  @override
  void initState() {
    titleController.text = 'this is how initstate works';
    super.initState();
  }

  // TODO: 14. Implement the submit function to add data to Firestore
  Future<void> _handleSubmit() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // await Future.delayed(const Duration(seconds: 10));

    try {
      await collectionRef.add({
        "title": titleController.text.trim(),
        "description": descriptionController.text.trim(),
        "createdAt": FieldValue.serverTimestamp(),
      });

      if (mounted) Navigator.pop(context);
    } catch (e) {
      setState(() => _isLoading = false);
      debugPrint(e.toString());
    }
  }

  // TODO: 13. Create the form with validation
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Idea")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            spacing: 16.0,
            children: [
              TextFormField(
                controller: titleController,
                validator: (v) => v!.isEmpty ? "Title required" : null,
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                controller: descriptionController,
                validator: (v) => v!.isEmpty ? "Description required" : null,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleSubmit,
                  child: _isLoading
                      ? const CircularProgressIndicator(strokeWidth: 2)
                      : const Text("Add Idea"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
