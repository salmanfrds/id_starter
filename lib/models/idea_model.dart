class IdeaModel {
  // TODO: 4. Define the properties of the IdeaModel (title, description)
  final String title;
  final String description;

  IdeaModel({required this.title, required this.description});

  // TODO: 5. Create a factory constructor to parse JSON data
  factory IdeaModel.fromMap(Map<String, dynamic> map) {
    return IdeaModel(
      title: map['title'] as String? ?? "No Title",
      description: map['description'] as String? ?? "No Description",
    );
  }
}
