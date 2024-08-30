// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

final class CharactersInitial extends CharactersState {}

class CharacterLoaded extends CharactersState {
 List<Character> characters;
  CharacterLoaded(
      this.characters,
  );
}

class QuoteLoaded extends CharactersState {
 List<Quote> quote;
  QuoteLoaded(
      this.quote,
  );
}
