class Menuitem {
  String id;
  String itemName;
  String category;
  String pictureUrl;
  String price;

  Menuitem({
    this.id = '',
    required this.itemName,
    required this.category,
    required this.pictureUrl,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'itemName': itemName,
        'category': category,
        'pictureUrl': pictureUrl,
        'price': price,
      };

  static Menuitem fromJson(Map<String, dynamic> json) => Menuitem(
        id: json['id'],
        itemName: json['itemName'],
        category: json['category'],
        pictureUrl: json['pictureUrl'],
        price: json['price'],
      );
}
