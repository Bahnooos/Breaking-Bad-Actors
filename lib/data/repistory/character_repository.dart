import 'package:breaking/data/API/charactersaPI.dart';
import 'package:breaking/data/models/characters.dart';
import 'package:breaking/data/models/continent.dart';

class CharacterRepository {
  final Characters_Api api;

 CharacterRepository(this.api);
  Future <List<Character>> getAllCharacters() async{
    final characters = await api.getAllCharacters();
    return characters.map((chaerater) => Character.fromJson(chaerater)).toList();
    
  } 
   Future <List<Quote>> getQuote() async{
    final quote = await api.getQuote();
    return quote.map((quote) => Quote.fromJson(quote)).toList();
    
  } 
}