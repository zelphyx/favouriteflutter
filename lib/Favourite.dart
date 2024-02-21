import 'dart:typed_data';

class Favourite {
  int? id;
  String? title;
  Uint8List? image;

  Favourite({
    this.id , this.title, this.image,
  });

  factory Favourite.fromJson(Map<String, dynamic> json) {
    return Favourite(
      id: json['id'],
      title: json['title'],
      image: json['image'],
    );
  }
}