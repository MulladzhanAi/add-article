import 'package:article_add_proj/data/api_service/api_service.dart';

class ApiModul{
  static ApiService ? _apiService;

  static ApiService getApiModul(){
    if(_apiService==null){
      _apiService=ApiService();
    }
    return _apiService!;
  }
}