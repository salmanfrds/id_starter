import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/idea_model.dart';

class IdeaStream extends StatelessWidget {
  const IdeaStream({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: 6. Initialize the StreamBuilder to listen to the 'ideaBoard' collection
    final docsSnapshot = FirebaseFirestore.instance.collection('ideaBoard').orderBy('createdAt', descending: true).snapshots();

    return StreamBuilder(
      stream: docsSnapshot, 
      builder: (context, snapshot){
        // TODO: 7. Check for connection state and errors
        if(snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        if(snapshot.hasError) return const Center(child: Text('error'));

        final docsMap = snapshot.data!.docs;

        // TODO: 9. Build the ListView to display the ideas
        return ListView.builder(
          itemCount: docsMap.length,
          itemBuilder: (context, index){
            final docMap = docsMap[index];
            final docModel = IdeaModel.fromMap(docMap.data());
            return IdeaWidget(title: docModel.title, subtitle: docModel.description, id: docMap.id);
          }
        );
      }
    );
  }
}

// TODO: 10. The Card Widget
class IdeaWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String id;
  const IdeaWidget({
    super.key, required this.title, required this.subtitle, required this.id
  });

  // TODO: 11. Implement the delete functionality
  Future<void> deleteIdea(String id) async {
     await FirebaseFirestore.instance.collection('ideaBoard').doc(id).delete(); 
  } 

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: IconButton(
          onPressed: () {
            deleteIdea(id);
          }, 
          icon: Icon(Icons.delete)
        ),
      ),
    );
  }
}
 