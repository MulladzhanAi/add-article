import 'package:article_add_proj/data/api_service/api_modul.dart';
import 'package:article_add_proj/domain/repository/repository.dart';

import '../../domain/models/article_item_model.dart';
import '../../domain/models/item_model.dart';

class RepositoryImpl extends Repository{
  Future<List<Item>> getItemByName(String name) async{
    var result = await ApiModul.getApiModul().getItemByName(name);
    return result;
  }

  Future<int> addItemMaterial(Item item) async {
    var result = await ApiModul.getApiModul().addItemMaterial(item);
    return result;
  }

  Future<int> addItemAccessories (Item item) async{
    var result = await ApiModul.getApiModul().addItemAccessories(item);
    return result;
  }
  Future<int> addArticleItem(int articleId,ArticleItemModel articleItemModel) async{
    var result = await ApiModul.getApiModul().addArticleItem(articleId, articleItemModel);
    return result;
  }

  Future<int> addArticle(String name,String number,String description) async{
    var result = await ApiModul.getApiModul().addArticle(name, number, description);
    print("messege from repos impl article add with id ${result}");
    return result;
  }

}