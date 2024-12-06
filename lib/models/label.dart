class Label {
  final String id;
  final String name;
  final String color;

  Label({
    required this.id,
    required this.name,
    required this.color,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
    };
  }

  factory Label.fromJson(Map<String, dynamic> json) {
    return Label(
      id: json['id'],
      name: json['name'],
      color: json['color'],
    );
  }
}
