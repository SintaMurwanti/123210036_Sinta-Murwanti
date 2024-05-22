class Job {
  final String id;
  final String title;
  final String company;
  final String location;
  final String description;

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.description,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      title: json['title'],
      company: json['company'],
      location: json['location'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'company': company,
      'location': location,
      'description': description,
    };
  }
}
