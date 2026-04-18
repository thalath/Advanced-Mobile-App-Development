import 'dart:convert';

List<ProductModels> productFromJson(String str) => List<ProductModels>.from(
  json.decode(str).map((x) => ProductModels.fromJson(x)),
);

String productToJson(List<ProductModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModels {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  Rating rating;

  ProductModels({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductModels.fromJson(Map<String, dynamic> json) => ProductModels(
    id: json['id'],
    title: json['title'],
    price: json['price']?.toDouble(),
    description: json['description'],
    category: json['category'],
    image: json['image'],
    rating: Rating.fromJson(json['rating']),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "category": category,
    "image": image,
    "rating": rating.toJson(),
  };
}

class Rating {
  double rate;
  int count;

  Rating({required this.rate, required this.count});

  factory Rating.fromJson(Map<String, dynamic> json) =>
      Rating(rate: json['rate']?.toDouble(), count: json['count']);

  Map<String, dynamic> toJson() => {"rate": rate, "count": count};
}
