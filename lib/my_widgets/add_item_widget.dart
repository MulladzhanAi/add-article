import 'package:article_add_proj/domain/fields_model/input_field_states.dart';
import 'package:article_add_proj/my_widgets/add_item_fields_widget.dart';
import 'package:flutter/material.dart';

import '../domain/fields_model/item_fields_model.dart';


class AddItemWidget extends StatefulWidget {

  ///ЗНАЧЕНИЕ ВО ВСЕХ ПОЛЕЙ
  List<ItemFieldsModel> itemFieldsmodels;


  ///ВВЕДЕНЫ ЛИ ВСЕ ПОЛЯ
  List<InputFieldStates> inputFieldStates;



  Function checkCanAdd;

  Function updateMainUI;

  final String nameLabel;
  final String countLabel;
  final String nameHint;
  final String countHint;
  final String buttonLabel;



  AddItemWidget({
    super.key,
    required this.updateMainUI,
    required this.checkCanAdd,
    required this.itemFieldsmodels,
    required this.inputFieldStates,
    required this.nameLabel,
    required this.nameHint,
    required this.countLabel,
    required this.countHint,
    required this.buttonLabel,
  });

  @override
  State<AddItemWidget> createState() => _AddItemWidgetState();
}

class _AddItemWidgetState extends State<AddItemWidget> {




  @override
  void initState() {
    listenOnController();
    super.initState();
  }

  void updateUI(int id){
    setState(() {
      widget.inputFieldStates.last.idMeasurementWasSelected=id;
      //widget.itemFieldsmodels.last.currentIdMeasurement=id;
    });
  }

  void listenOnController(){


    for(int i=0;i<widget.itemFieldsmodels.length;i++){


      widget.itemFieldsmodels[i].nameController.addListener(() {

        addListenerName(i);
      });

      widget.itemFieldsmodels[i].countController.addListener(() {

        addListenerCount(i);
      });
    }
  }


  ///
  ///
  ///
  ///
  ///
  void addListenerName(int i){
    setState(() {
      widget.inputFieldStates[i].nameHasInput=
          widget.itemFieldsmodels[i].nameController.text.isNotEmpty;
      widget.checkCanAdd();

    });
  }

  void addListenerCount(int i){
    setState(() {
      widget.inputFieldStates[i].countHasInput=
          widget.itemFieldsmodels[i].countController.text.isNotEmpty;
      widget.checkCanAdd();

    });
  }




  void deleteEmptyItem(){
    for(int i=widget.itemFieldsmodels.length-1;i>=0;i--){
      if(widget.itemFieldsmodels[i].nameController.text.isEmpty &&
          widget.itemFieldsmodels[i].countController.text.isEmpty &&
          widget.itemFieldsmodels[i].currentIdMeasurement==0 &&
          widget.itemFieldsmodels.length>1
      ){




        widget.itemFieldsmodels.removeAt(i);
        widget.inputFieldStates.removeAt(i);

        listenOnController();

      }

    }
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        ListView.builder(
          shrinkWrap: true,
            primary: false,
            itemCount:  widget.itemFieldsmodels.length == 0 ? 0 : widget.itemFieldsmodels.length,
            itemBuilder: (context,index){
              return AddItemFieldsWidget(
                updateMainUI: widget.updateMainUI,
                updateParentUI: updateUI,
                deleteEmptyItem: deleteEmptyItem,
                inputFieldStates: widget.inputFieldStates[index],
                itemFieldsModel: widget.itemFieldsmodels[index],
                nameController: widget.itemFieldsmodels[index].nameController,
                countController: widget.itemFieldsmodels[index].countController,
                nameLabel: widget.nameLabel,
                countLabel: widget.countLabel,
                nameHint: widget.nameHint,
                countHint: widget.countHint,
                moreThanItem: index>0,

              );
            },
        ),





        ///КНОПКА ДОБАВЛЕНИЯ
        Center(
          child: Padding(
            padding: EdgeInsets.only(top:8,bottom: 8),
            child: Container(
              width: 195,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: widget.inputFieldStates.last.nameHasInput  &&
                    widget.inputFieldStates.last.countHasInput &&
                    widget.itemFieldsmodels.last.currentIdMeasurement!=0?
                Color(0xff47A6DC) :
                Color(0xffCCCCCC),
              ),
              child: InkWell(

                onTap: (){
                  if(widget.itemFieldsmodels.last.nameController.text.isNotEmpty &&
                      widget.itemFieldsmodels.last.countController.text.isNotEmpty &&
                      widget.itemFieldsmodels.last.currentIdMeasurement !=0
                  ){
                    widget.itemFieldsmodels.add(ItemFieldsModel(
                        nameController: TextEditingController(),
                        countController: TextEditingController(),
                        currentIdMeasurement: 0,
                    ));

                    widget.inputFieldStates.add(InputFieldStates());


                    setState(() {
                      listenOnController();
                    });

                    widget.checkCanAdd();
                  }
                },
                child: Center(child: Text(widget.buttonLabel),),
              ),
            ),
          ),
        ),

      ],
    );
  }
}



