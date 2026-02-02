import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/idea_model.dart';

class IdeaStream extends StatelessWidget {
  const IdeaStream({super.key});

  // TODO: 11. Implement the delete functionality
  Future<void> _deleteIdea(String id) async {
    await FirebaseFirestore.instance.collection('ideaBoard').doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: 6. Initialize the StreamBuilder to listen to the 'ideaBoard' collection
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('ideaBoard')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        // TODO: 7. Check for connection state and errors
        if (snapshot.hasError) return const Center(child: Text("Error"));
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // TODO: 8. Parse the query snapshot into a list of IdeaModel objects
        final docs = snapshot.data!.docs;

        return ListView.builder(
          // TODO: 9. Build the ListView to display the ideas
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            final idea = IdeaModel.fromMap(data);

            // TODO: 10. The Card Widget
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text(
                  idea.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(idea.description),
                trailing: IconButton(
                  onPressed: () {
                    _deleteIdea(docs[index].id);
                  },
                  icon: Icon(Icons.delete),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
