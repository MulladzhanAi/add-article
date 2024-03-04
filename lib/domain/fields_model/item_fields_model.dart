import 'package:flutter/cupertino.dart';

import '../models/item_model.dart';

class ItemFieldsModel{

  ///ИСПОЛЬЗУЕТСЯ ДЛЯ ПОЛУЧЕНИЯ ДАННЫХ С ПОЛЕЙ
  TextEditingController nameController;
  TextEditingController countController;
  int currentIdMeasurement;
  Item ? currentItem;

  ItemFieldsModel(
  {
    required this.nameController,
    required this.countController,
    required this.currentIdMeasurement,
  });
}