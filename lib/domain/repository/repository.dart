import '../models/article_item_model.dart';
import '../models/item_model.dart';

abstract class Repository{
  Future<List<Item>> getItemByName(String name);
  Future<int> addItemMaterial(Item item);

  Future<int> addItemAccessories (Item item);

  Future<int> addArticleItem(int articleId,ArticleItemModel articleItemModel);

  Future<int> addArticle(String name,String number,String description);
}