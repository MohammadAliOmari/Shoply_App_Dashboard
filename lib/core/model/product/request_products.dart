import 'dart:io';

class RequestProducts {
  final String? name;
  final String? description;
  final double? price;
  final List<File>? images;
  final bool isTrending;

  RequestProducts({
    required this.name,
    required this.description,
    required this.price,
    required this.images,
    this.isTrending = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'images': images,
      'isTrending': isTrending,
    };
  }
}
