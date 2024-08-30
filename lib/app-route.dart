// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:breaking/data/API/charactersaPI.dart';
import 'package:breaking/data/models/characters.dart';
import 'package:breaking/presentstion/screen/Character_Details_Screen.dart';
import 'package:flutter/material.dart';

import 'package:breaking/Business_logic/cubit/characters_cubit.dart';
import 'package:breaking/constants/strings.dart';
import 'package:breaking/data/repistory/character_repository.dart';
import 'package:breaking/presentstion/screen/Character_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App_Routing {
  late final CharacterRepository characterRepository;
  late final CharactersCubit charactersCubit;
  App_Routing() {
    characterRepository = CharacterRepository(Characters_Api());
    charactersCubit = CharactersCubit(characterRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case characterScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: Character_Screen(),
          ),
        );
      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) =>  CharactersCubit(characterRepository),
                  child: character_details(
                    character: character,
                  ),
                ));
    }
  }
}
