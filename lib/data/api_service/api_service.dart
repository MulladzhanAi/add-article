

import 'dart:convert';

import 'package:article_add_proj/domain/models/article_item_model.dart';
import 'package:http/http.dart' as http;
import 'package:article_add_proj/domain/models/item_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ApiService {


  Future<List<Item>> getItemByName(String name) async {
    HttpLink httpLink = HttpLink("http://143.110.190.57:8002/graphql/");
    GraphQLClient qlClient =
        GraphQLClient(link: httpLink, cache: GraphQLCache(store: HiveStore()));

    QueryResult queryResult= await qlClient.query(QueryOptions(document: gql("""
                query d {
        items(name: "${name}") {
          edges {
            node {
              id
              itemType
              name
              measurement {
                name
                slug
                id
              }
            }
          }
        }
      }
    
    """)));

    List<dynamic> list = queryResult.data?['items']['edges'] ?? [];



    List<Item> items=(list as List).map((item) {
      return Item.fromJson(item["node"]);
    }).toList();

    items.forEach((element) {
      print(element.name +
          " ---" +
          element.id.toString() +
          "---" +
          element.measurment.name +
          "----" +
          element.measurment.id.toString());
    });

    return items;

  }




  Future<int> addItemMaterial (Item item) async{
    var link="http://143.110.190.57:8002/api/item/";
    var responce = await http.post(Uri.parse(link),
        body: {"name" : item.name,"item_type" : "material","measurement": item.measurment.id.toString()});

    var data = json.decode(responce.body);

    return data["id"];
  }



  Future<int> addItemAccessories (Item item) async{
    var link="http://143.110.190.57:8002/api/item/";
    var responce = await http.post(Uri.parse(link),
        body: {"name" : item.name,"item_type" : "accessories","measurement": item.measurment.id.toString()});

    var data = json.decode(responce.body);

    return data["id"];
  }



  Future<int> addArticleItem(int articleId,ArticleItemModel articleItemModel) async{
    var link = "http://143.110.190.57:8002/api/article_item/";
    var responce = await http.post(Uri.parse(link),
      body: {"quantity" : articleItemModel.quantity.toString(),
              "article" : articleId.toString(),
                "item" : articleItemModel.itemId.toString()
      });

    var data = json.decode(responce.body);
    print("Добавлен АртикелИтем с айди = ${data["id"]}\n Айди article = ${data['article']} Айди item ${data["item"]}");
    return data['id'];
  }



  Future<int> addArticle(String name,String number,String description) async{
    var link = "http://143.110.190.57:8002/api/article/";
    var responce = await  http.post(Uri.parse(link),
      body: {"name" : name ,"number" : number,"description" : description}
    );

    var data = json.decode(responce.body);
    return data['id'];
  }


}
