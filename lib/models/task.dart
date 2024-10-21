class Task {
  int? id;
  String title;
  bool isCompleted;
  String priority;

  Task({this.id, required this.title, this.isCompleted = false, this.priority = "Low"});

  // Convert a Task object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted ? 1 : 0, // SQLite stores bool as integer
      'priority': priority,
    };
  }

  // Create a Task object from a Map object
  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      isCompleted: map['isCompleted'] == 1, // SQLite stores bool as integer
      priority: map['priority'],
    );
  }
}
