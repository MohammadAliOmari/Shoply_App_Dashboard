import 'dart:io';

class ResquestSales {
  final File? image;

  ResquestSales({required this.image});

  Map<String, dynamic> toJson() {
    return {'image': image};
  }
}
