class items {
  String image;
  String food;
  String price;
  String category;
  String quantity;
  String itemid;

  items(
      {this.quantity = '',
      required this.image,
      required this.food,
      required this.price,
      required this.category,
      this.itemid='1'});
}
