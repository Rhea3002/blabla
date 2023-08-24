import 'dart:convert';

class Product {
  final String name;
  final String description;
  final double quantity;
  final List<String> images;
  final String category;
  final double price;
  final double ram;
  final double rom;
  final String screentech;
  final String os;
  final List<String> keywordlist;
  final String? userId;
  final String? id;

  Product(
      {required this.name,
      required this.description,
      required this.quantity,
      required this.images,
      required this.category,
      required this.price,
      required this.ram,
      required this.rom,
      required this.screentech,
      required this.os,
      required this.keywordlist,
      this.id,
      this.userId
      });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'ram': ram,
      'rom': rom,
      'screentech': screentech,
      'os': os,
      'keywordlist': keywordlist,
      'id': id,
      'userId': userId,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
      images: List<String>.from(map['images']),
      keywordlist: List<String>.from(map['keywordlist']),
      category: map['category'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      ram: map['ram']?.toDouble() ?? 0.0,
      rom: map['rom']?.toDouble() ?? 0.0,
      screentech: map['screentech'] ?? '',
      os: map['os'] ?? '',
      id: map['_id'],
      userId: map['userId']

        // rating: map['ratings'] != null
        //     ? List<Rating>.from(
        //         map['ratings']?.map(
        //           (x) => Rating.fromMap(x),
        //         ),
        //       )
        //     : null,
        );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
