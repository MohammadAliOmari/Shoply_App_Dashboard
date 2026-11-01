class RequestCategories {
  final String id;
  final String name;

  RequestCategories({required this.id, required this.name});

  factory RequestCategories.fromJson(Map<String, dynamic> json) {
    return RequestCategories(id: json['id'], name: json['name']);
  }
}
