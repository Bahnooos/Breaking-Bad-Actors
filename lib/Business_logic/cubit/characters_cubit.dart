import 'package:bloc/bloc.dart';
import 'package:breaking/data/models/characters.dart';
import 'package:breaking/data/models/continent.dart';
import 'package:breaking/data/repistory/character_repository.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterRepository characterRepository;
    List<Character> characters = [] ;
  CharactersCubit(this.characterRepository) : super(CharactersInitial());
  List<Character>? getAllCharacters(){
    characterRepository.getAllCharacters().then((characters) {
      emit(CharacterLoaded(characters));
       this.characters=characters;
      
    });
    return characters;
  }

    void getQuote(){
    characterRepository.getQuote().then((quote) {
      emit(QuoteLoaded(quote));
      
      
    });
   
  }
}
