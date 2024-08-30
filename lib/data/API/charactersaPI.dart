import 'package:breaking/constants/strings.dart';
import 'package:dio/dio.dart';
class Characters_Api{

  late Dio dio;
  Characters_Api(){
  BaseOptions options = BaseOptions(
    baseUrl:baseurl,
    
    connectTimeout:Duration(seconds: 20) ,
    receiveTimeout: Duration(seconds: 20),
    receiveDataWhenStatusError: true,
  );
  dio =Dio(options);
  
    
  }
  Future <List<dynamic>> getAllCharacters() async{
    try {
  Response response=await dio.get('Characters',);
  
  return response.data;
} on Exception catch (e) {
  print(e.toString());
  return[];
}


  }
 Future <List<dynamic>> getQuote() async{
    try {
  Response response=await dio.get('https://api.gameofthronesquotes.xyz/v1/random/5',);
  
  return response.data;
} on Exception catch (e) {
  print(e.toString());
  return[];
}


  }
   
  
}