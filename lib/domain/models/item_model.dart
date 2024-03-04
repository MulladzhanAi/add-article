import 'package:article_add_proj/domain/models/measurement_model.dart';

class Item {
  int ? id;
  String itemType;
  String name;
  Measurement measurment;

  Item(
      {required this.id,
        required this.itemType,
        required this.name,
        required this.measurment
      });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        id: int.parse(json["id"]),
        itemType: json["itemType"],
        name: json["name"],
        measurment: Measurement.fromJson(json["measurement"])

    );
  }

}