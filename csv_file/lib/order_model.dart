// Model for The orders
class Order {
  final String id;
  final String area;
  final String name;
  final int quantity;
  final String brand;

  Order(
      {required this.id,
      required this.area,
      required this.name,
      required this.quantity,
      required this.brand});

  Order copyWith({
    String? id,
    String? area,
    String? name,
    int? quantity,
    String? brand,
  }) {
    return Order(
      id: id ?? this.id,
      area: area ?? this.area,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      brand: brand ?? this.brand,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.id == id &&
        other.area == area &&
        other.name == name &&
        other.quantity == quantity &&
        other.brand == brand;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        area.hashCode ^
        name.hashCode ^
        quantity.hashCode ^
        brand.hashCode;
  }
}
