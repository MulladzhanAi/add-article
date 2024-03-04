import 'package:article_add_proj/data/repository/repository_modul.dart';
import 'package:article_add_proj/domain/models/article_item_model.dart';
import 'package:article_add_proj/my_widgets/add_item_widget.dart';
import 'package:flutter/material.dart';
import '../domain/fields_model/input_field_states.dart';
import '../domain/fields_model/item_fields_model.dart';
import '../domain/models/item_model.dart';
import '../domain/models/measurement_model.dart';

class AddArticlePage extends StatefulWidget {
  ///Function resetWidget;
  const AddArticlePage({
    super.key,
  });

  @override
  State<AddArticlePage> createState() => _AddArticlePageState();
}



class _AddArticlePageState extends State<AddArticlePage> {





  ///НАЗВАНИЕ АРТИКЛЯ
  final TextEditingController articleNameController = TextEditingController();
  bool _articleNameHasInput = false;

  ///ОПИСАНИЕ АРТИКЛЯ
  final TextEditingController articleDescController = TextEditingController();
  bool _articleDescHasInput = false;

  ///ID АРТИКЛЯ
  int articleId=0;

  ///ЗНАЧЕНИЕ ВО ВСЕХ ПОЛЕЙ ДЛЯ МАТЕРИАЛА
  List<ItemFieldsModel> itemMaterialFieldsmodels = [
    ItemFieldsModel(
      nameController: TextEditingController(),
      countController: TextEditingController(),
      currentIdMeasurement: 0,
    ),
  ];

  List<InputFieldStates> inputMaterialFieldsStates = [
    InputFieldStates(),
  ];

  ///

  ///ЗНАЧЕНИЕ ВО ВСЕХ ПОЛЕЙ ДЛЯ ФУРНИТУРЫ
  List<ItemFieldsModel> itemFurnitureFieldsmodels = [
    ItemFieldsModel(
      nameController: TextEditingController(),
      countController: TextEditingController(),
      currentIdMeasurement: 0,
    ),
  ];

  List<InputFieldStates> inputFurnitureFieldsStates = [
    InputFieldStates(),
  ];

  ///
  ///
  ///

  ///КОЛИЧЕСТВО СКОЛЬКО ДОБАВЛЯТЬ
  List<ArticleItemModel> materialArticleItems = [];
  List<ArticleItemModel> furnitureArticleItems = [];

  bool canAdd = false;

  void updateMainUI() {
    checkCanAdd();
    setState(() {});
  }

  void checkCanAdd() {
    setState(() {
      canAdd =  _articleNameHasInput && _articleDescHasInput &&
          (itemMaterialFieldsmodels.every((element) =>
              element.nameController.text.isNotEmpty &&
              element.countController.text.isNotEmpty &&
              element.currentIdMeasurement != 0)) &&
          (itemFurnitureFieldsmodels.every((element) =>
              element.nameController.text.isNotEmpty &&
              element.countController.text.isNotEmpty &&
              element.currentIdMeasurement != 0));
    });
  }

  @override
  void initState() {
    //Добавляю слушатель чтобы отслеживать поле заполнено или нет
    articleNameController.addListener(() {
      setState(() {
        _articleNameHasInput = articleNameController.text.isNotEmpty;

        canAdd =  _articleNameHasInput && _articleDescHasInput &&
            (itemMaterialFieldsmodels.every((element) =>
            element.nameController.text.isNotEmpty &&
                element.countController.text.isNotEmpty &&
                element.currentIdMeasurement != 0)) &&
            (itemFurnitureFieldsmodels.every((element) =>
            element.nameController.text.isNotEmpty &&
                element.countController.text.isNotEmpty &&
                element.currentIdMeasurement != 0));
      });
    });

    articleDescController.addListener(() {
      setState(() {
        _articleDescHasInput = articleDescController.text.isNotEmpty;

        canAdd =  _articleNameHasInput && _articleDescHasInput &&
            (itemMaterialFieldsmodels.every((element) =>
            element.nameController.text.isNotEmpty &&
                element.countController.text.isNotEmpty &&
                element.currentIdMeasurement != 0)) &&
            (itemFurnitureFieldsmodels.every((element) =>
            element.nameController.text.isNotEmpty &&
                element.countController.text.isNotEmpty &&
                element.currentIdMeasurement != 0));
      });
    });

    super.initState();
  }


  Key valueKey = UniqueKey();



  ///ВВЕДЕНЫ ЛИ ВСЕ ПОЛЯ

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 92,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8),
              child: Image.asset("assets/images/trailing.png")),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Booster",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),

      ),
      body: ListView(
        key: valueKey,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8),
              child: Center(child: Text("информация об артикуле".toUpperCase()))),
          Padding(
            padding:
                EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
            child: Container(
              height: 50,
              child: TextField(
                controller: articleNameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: _articleNameHasInput
                      ? Color(0xFFFFFFFF)
                      : Color(0xffF0F0F0),
                  hintText: "Номер артикула *",
                  border: OutlineInputBorder(
                    borderSide: _articleNameHasInput
                        ? BorderSide(color: Color(0xffD2D2D2), width: 1.0)
                        : BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Container(
              height: 166,
              child: TextField(
                maxLines: 5,
                controller: articleDescController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: _articleDescHasInput
                      ? Color(0xFFFFFFFF)
                      : Color(0xffF0F0F0),
                  hintText: "Описание артикула",
                  border: OutlineInputBorder(
                    borderSide: _articleDescHasInput
                        ? BorderSide(color: Color(0xffD2D2D2), width: 1.0)
                        : BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            child: Center(
              child: Text("материал".toUpperCase()),
            ),
          ),
          AddItemWidget(
            checkCanAdd: checkCanAdd,
            updateMainUI: updateMainUI,
            itemFieldsmodels: itemMaterialFieldsmodels,
            inputFieldStates: inputMaterialFieldsStates,
            nameLabel: "Материал",
            nameHint: "Материал,цвет *",
            countLabel: "Количество на ед.продукта",
            countHint: "Кол-во на ед.прод.",
            buttonLabel: "+материал",
          ),
          AddItemWidget(
            checkCanAdd: checkCanAdd,
            updateMainUI: updateMainUI,
            itemFieldsmodels: itemFurnitureFieldsmodels,
            inputFieldStates: inputFurnitureFieldsStates,
            nameLabel: "Фурнитура",
            nameHint: "Фурнитура *",
            countLabel: "Количество на единицу",
            countHint: "Кол-во на единицу *",
            buttonLabel: "+фурнитура",
          ),
          Padding(
            padding: EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 116),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: canAdd ? Color(0xff47A6DC) : Color(0xffCCCCCC),
                  borderRadius: BorderRadius.circular(15)),
              child: InkWell(
                onTap: () async {
                  if(canAdd){

                    try{
                      articleId = await RepositoryModul.getRepository().addArticle(
                          articleNameController.text,
                          articleNameController.text,
                          articleDescController.text,
                      );
                    }catch(e){
                      showDialog(context: context, builder: (context)=>AlertDialog(
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.of(context).pop();
                          }, child: Text("Закрыть")),

                        ],
                        title: Text("Такой артикль уже есть"),
                      ));
                      return;
                    }

                    await addToMaterialList();
                    await addToFurnitureList();
                    addToQuntity();
                    addArticleItem();
                    clearAllData();

                  }
                },
                child: Center(child: Text("Сохранить")),
              ),
            ),
          ),
        ],
      ),
    );
  }



  Future<int> addNewItem(Item item) async {
    var id= await RepositoryModul.getRepository().addItemMaterial(item);
    await Future.delayed(Duration(seconds: 2));
    return id;
  }



  addToMaterialList() async {
    await Future.forEach(itemMaterialFieldsmodels, (field) async {
      if (field.currentItem == null) {
        int id = await RepositoryModul.getRepository().addItemMaterial(Item(
          id: null,
          itemType: 'material',
          name: field.nameController.text,
          measurment: Measurement(
            name: '',
            slug: '',
            id: field.currentIdMeasurement,
          ),
        ));
        print('item was added with id $id');

        int quantity = field.currentIdMeasurement == 1
            ? int.parse(field.countController.text) * 100
            : int.parse(field.countController.text);
        field.currentItem = Item(
          id: id,
          itemType: 'material',
          name: field.nameController.text,
          measurment: Measurement(
            name: '',
            slug: '',
            id: field.currentIdMeasurement,
          ),
        );
      }
    });
  }

  addToFurnitureList() async {
    await Future.forEach(itemFurnitureFieldsmodels, (field) async {
      if (field.currentItem == null) {
        int id = await RepositoryModul.getRepository().addItemAccessories(Item(
          id: null,
          itemType: 'accessories',
          name: field.nameController.text,
          measurment: Measurement(
            name: '',
            slug: '',
            id: field.currentIdMeasurement,
          ),
        ));
        print('item was added with id $id');

        int quantity = field.currentIdMeasurement == 1
            ? int.parse(field.countController.text) * 100
            : int.parse(field.countController.text);
        field.currentItem = Item(
          id: id,
          itemType: 'material',
          name: field.nameController.text,
          measurment: Measurement(
            name: '',
            slug: '',
            id: field.currentIdMeasurement,
          ),
        );
      }
    });
  }


  addToQuntity(){
    itemMaterialFieldsmodels.forEach((item) {
      double inputValue =double.tryParse(item.countController.text.replaceAll(',', '.')) ?? 0;
      int quantity = item.currentIdMeasurement == 1 ?
        (inputValue*100).toInt():
        inputValue.toInt();
      materialArticleItems.add(ArticleItemModel(itemId: item.currentItem!.id!, quantity: quantity));
    });

    itemFurnitureFieldsmodels.forEach((item) {
      double inputValue = double.tryParse(item.countController.text.replaceAll(',', '.')) ?? 0;
      int quantity = item.currentIdMeasurement == 1 ?
        (inputValue*100).toInt():
        inputValue.toInt();
      furnitureArticleItems.add(ArticleItemModel(itemId: item.currentItem!.id!, quantity: quantity));
    });

  }


  void addArticleItem() {
    materialArticleItems.forEach((articleItem) {
      RepositoryModul.getRepository().addArticleItem(articleId, articleItem);
    });

    furnitureArticleItems.forEach((articleItem) {
      RepositoryModul.getRepository().addArticleItem(articleId, articleItem);
    });
  }



  addArticle(String name,String description,String number) async{
    try {
      articleId = await RepositoryModul.getRepository().addArticle(name, number, description);
      print('Успешно добавлен и айди равен $articleId');
      return articleId;
    } catch (error) {
      print('Ошибка при добавлении артикла: $error');
      throw error; // Вы можете выбросить исключение или вернуть значение по умолчанию
    }
  }


  void clearAllData() {
    resetKey();

    articleNameController.clear();
    articleDescController.clear();

    itemMaterialFieldsmodels.clear();
    itemMaterialFieldsmodels = [
    ];

    itemMaterialFieldsmodels.add(ItemFieldsModel(
      nameController: TextEditingController(),
      countController: TextEditingController(),
      currentIdMeasurement: 0,
    ));
    inputMaterialFieldsStates.clear();
    inputMaterialFieldsStates = [
      InputFieldStates(),
    ];


    ///ЗНАЧЕНИЕ ВО ВСЕХ ПОЛЕЙ ДЛЯ ФУРНИТУРЫ
    itemFurnitureFieldsmodels.clear();
    itemFurnitureFieldsmodels = [
      ItemFieldsModel(
        nameController: TextEditingController(),
        countController: TextEditingController(),
        currentIdMeasurement: 0,
      ),
    ];

    inputFurnitureFieldsStates.clear();
    inputFurnitureFieldsStates = [
      InputFieldStates(),
    ];

    materialArticleItems = [];
    furnitureArticleItems = [];

    onListen();

    canAdd = false;

  }


  void onListen(){
    articleNameController.addListener(() {
      setState(() {
        _articleNameHasInput = articleNameController.text.isNotEmpty;
      });
    });

    articleDescController.addListener(() {
      setState(() {
        _articleDescHasInput = articleDescController.text.isNotEmpty;
      });
    });
  }


  void resetKey(){
    valueKey=UniqueKey();
  }


}
