class Order {
  String id;
  String paymentStatus;
  String cashierUsername;
  String cookStatus;
  String cookUsername;
  final String tableNumber;
  final String waiterStatus;
  final String waiterUsername;
  final String lastUpdatedAt;

  Order({
    this.id = '',
    this.paymentStatus = "Pending",
    this.cashierUsername = "None",
    this.cookStatus = "Pending",
    this.cookUsername = "None",
    this.lastUpdatedAt = '',
    required this.waiterUsername,
    required this.waiterStatus,
    required this.tableNumber,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'paymentStatus': paymentStatus,
        'cashierUsername': cashierUsername,
        'cookStatus': cookStatus,
        'cookUsername': cookUsername,
        'tableNumber': tableNumber,
        'waiterStatus': waiterStatus,
        'waiterUsername': waiterUsername,
      };

  static Order fromJson(Map<String, dynamic> json) => Order(
        id: json['id'],
        paymentStatus: json['paymentStatus'],
        cashierUsername: json['cashierUsername'],
        cookStatus: json['cookStatus'],
        cookUsername: json['cookUsername'],
        tableNumber: json['tableNumber'],
        waiterStatus: json['waiterStatus'],
        waiterUsername: json['waiterUsername'],
      );
}
