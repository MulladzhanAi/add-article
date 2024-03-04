import 'package:article_add_proj/data/repository/repository_modul.dart';
import 'package:article_add_proj/domain/fields_model/item_fields_model.dart';
import 'package:flutter/material.dart';
import '../domain/fields_model/input_field_states.dart';
import '../domain/models/item_model.dart';

class AddItemFieldsWidget extends StatefulWidget {
  ///ОТСЛЕЖИВАНИЕ ЗНАЧЕНИЙ
  ItemFieldsModel itemFieldsModel;

  ///
  InputFieldStates inputFieldStates;



  final Function(int) updateParentUI;
  final Function deleteEmptyItem;
  final Function updateMainUI;

  final bool moreThanItem;

  ///

  ///КОНТРОЛЛЕРЫ
  TextEditingController nameController;
  TextEditingController countController;

  final String nameLabel;
  final String countLabel;
  final String nameHint;
  final String countHint;

  AddItemFieldsWidget({
    super.key,
    required this.updateMainUI,
    required this.updateParentUI,
    required this.deleteEmptyItem,
    required this.itemFieldsModel,
    required this.inputFieldStates,
    required this.nameController,
    required this.countController,
    required this.nameLabel,
    required this.countLabel,
    required this.nameHint,
    required this.countHint,
    required this.moreThanItem,
  });

  @override
  State<AddItemFieldsWidget> createState() => _AddItemFieldsWidgetState();
}

class _AddItemFieldsWidgetState extends State<AddItemFieldsWidget> {
  Item? currentItem;



  @override
  void initState() {

    widget.nameController.addListener(() {
      setState(() {

      });
    });

    super.initState();
  }


  @override
  void dispose() {
/*    widget.newTextController.clear();
    widget.newTextController.dispose();*/
    super.dispose();
  }
  TextEditingController newTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        ///ПОЛЯ ЗАПОЛНЕНИЯ МАТЕРИАЛА
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Autocomplete<Item>(
                    //key: _autoComplete,
                    //optionsMaxHeight: 150,
                    optionsBuilder: (TextEditingValue value) {
                      if (value.text.isEmpty) return List.empty();
                      return RepositoryModul.getRepository()
                          .getItemByName(value.text);
                    },
                    onSelected: (value) {



                      currentItem = value;
                      widget.itemFieldsModel.currentItem=value;

                    },
                    fieldViewBuilder: (BuildContext context,TextEditingController controller,
                        FocusNode node, Function onSelected) {
                      //widget.newTextController=controller;  //true
                      //widget.nameController=controller;
                      //controller = newTextController;
                      newTextController=controller;
                      return TextField(
                        controller: newTextController,
                        focusNode: node,

                        onChanged: (value){
                          widget.nameController.text=value;
                        },
                        onSubmitted: (value){
                          widget.nameController.text=value;
                        },

                        decoration: InputDecoration(
                          filled: true,
                          fillColor: widget.inputFieldStates.nameHasInput
                              ? Color(0xFFFFFFFF)
                              : Color(0xffF0F0F0),
                          labelText: widget.nameLabel,
                          hintText: widget.nameHint,
                          border: OutlineInputBorder(
                            borderSide: widget.nameController.text.isNotEmpty
                                ? BorderSide(
                                    color: Color(0xffD2D2D2), width: 1.0)
                                : BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      );
                    },
                    optionsViewBuilder: (BuildContext context,
                        Function onSelect, Iterable<Item> itemList) {
                      return Align(
                        alignment: Alignment.topCenter,
                        child: Material(
                          child: SizedBox(
                            height: 200,
                            child: ListView.builder(
                                itemCount: itemList.length,
                                itemBuilder: (context, index) {
                                  Item curItem = itemList.elementAt(index);
                                  return InkWell(
                                    onTap: () => onSelect(curItem),
                                    child: ListTile(
                                      title: Text(curItem.name),
                                      subtitle: Text(curItem.measurment.name),
                                    ),
                                  );
                                }),
                          ),
                        ),
                      );
                    },
                    displayStringForOption: (Item item) => item.name,
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  if (widget.nameController.text.isNotEmpty ||
                      widget.moreThanItem) {
                    ///ОЧИЩАЮ ВСЕ ЗНАЧЕНИЯ ЕСЛИ НАЖАЛИ КРЕСТИК
                    widget.nameController.clear();
                    widget.countController.clear();
                    widget.itemFieldsModel.currentIdMeasurement = 0;


                   // widget.newTextController.clear();
                    newTextController.clear();
                    ///НУЖНО ВООБЩЕ УДАЛИТЬ ПОСЛЕДНИЙ ЭЛЕМЕНТ ЛИСТА
                    widget.deleteEmptyItem();

                    widget.updateMainUI();
                  } else {
                    //Если имя не введено
                  }
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: widget.nameController.text.isNotEmpty ||
                              widget.moreThanItem
                          ? Color(0xffFFFFFF)
                          : Color(0xffCCCCCC),
                      borderRadius: BorderRadius.circular(25),
                      border: widget.nameController.text.isNotEmpty ||
                              widget.moreThanItem
                          ? Border.all(
                              color: Color(0xff47A6DC),
                              width: 1,
                            )
                          : null),
                  child: SizedBox(
                    width: 7,
                    height: 7,
                    child: Icon(
                      Icons.close,
                      color: widget.nameController.text.isNotEmpty ||
                              widget.moreThanItem
                          ? Color(0xff47A6DC)
                          : Color(0xffFFFFFF),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 16, left: 16, top: 8, bottom: 8),
          child: Row(
            children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(right: 8),
                child: TextField(
                  controller: widget.countController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: widget.countController.text.isNotEmpty
                        ? Color(0xFFFFFFFF)
                        : Color(0xffF0F0F0),

                    labelText: widget.countLabel,
                    hintText: widget.countHint,

                    /////////ОТРЕДАКТИРУЙ ТЕКСТ
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: widget.countController.text.isNotEmpty
                          ? BorderSide(color: Color(0xffD2D2D2), width: 1.0)
                          : BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              )),
              DropdownMenu(
                selectedTrailingIcon: Icon(
                  Icons.add,
                  color: Colors.green,
                ),
                dropdownMenuEntries: <DropdownMenuEntry<int>>[
                  DropdownMenuEntry(
                    value: 1,
                    label: 'метр',
                    style: ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(Colors.white),
                    ),
                  ),
                  DropdownMenuEntry(
                    value: 2,
                    label: 'шт',
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                  ),
                ],
                onSelected: (id) {
                  if (id != null) {
                    setState(() {
                      widget.inputFieldStates.idMeasurementWasSelected = id;
                      widget.itemFieldsModel.currentIdMeasurement = id;
                    });
                    widget.updateParentUI(id);
                    widget.updateMainUI();
                  }
                },
                width: 195,
                hintText: "Ед. измерения *",
                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: widget.itemFieldsModel.currentIdMeasurement == 0
                      ? Color(0xffF0F0F0)
                      : Color(0xffffffff),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          widget.itemFieldsModel.currentIdMeasurement == 0
                              ? BorderSide.none
                              : BorderSide(
                                  color: Color(0xffD2D2D2),
                                  width: 1,
                                )),
                ),
                label: Text("Ед. измерения *"),
                menuStyle: MenuStyle(
                    //backgroundColor: MaterialStateProperty.all(Color(0xff202020)),
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.resolveWith(
                      (states) {
                        return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15));
                      },
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
