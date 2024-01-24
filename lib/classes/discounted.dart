class Discounted {
  final String text;
  final String imageUrl;

  Discounted({required this.text, required this.imageUrl});

  factory Discounted.fromJson(Map<String, dynamic> json) {
    return Discounted(
      text: json['descuento'] ?? "",
      imageUrl: json['imagen'] ?? "",
    );
  }

  static List<Discounted> decode(List<dynamic> items) {
    return items.map<Discounted>((item) => Discounted.fromJson(item)).toList();
  }
}
