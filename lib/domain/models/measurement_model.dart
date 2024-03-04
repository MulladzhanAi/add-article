class Measurement {
  String name;
  String slug;
  int id;

  Measurement({required this.name, required this.slug, required this.id});

  factory Measurement.fromJson(Map<String, dynamic> json) {
    return Measurement(
      name: json["name"],
      slug: json["slug"],
      id: int.parse(json["id"]),
    );
  }
}