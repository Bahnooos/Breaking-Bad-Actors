// ignore_for_file: unused_local_variable

import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking/Business_logic/cubit/characters_cubit.dart';
import 'package:breaking/constants/mycolors.dart';
import 'package:breaking/data/models/characters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class character_details extends StatelessWidget {
  final Character character;


  const character_details({super.key, required this.character, });
 // const character_details({super.key});
 Widget BuildSliverAppBar(){
  return SliverAppBar(
    expandedHeight: 600,
    pinned: true,
    stretch: true,
    backgroundColor: MyColors.myGray,
    flexibleSpace: FlexibleSpaceBar(
      //centerTitle: true,
      title: Text(
        character.firstName,
        style: TextStyle(color: MyColors.myWhite),
        textAlign:TextAlign.start ,
      ),
      background: Hero(tag: character.id, child: Image.network(character.imageUrl,fit: BoxFit.cover,)),
    ),
  );
 }
 Widget CharacaterInfo(String title , String value){
  
  return RichText(
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    text: TextSpan(
    
    children: [TextSpan(
      text: title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: MyColors.myWhite,
        fontSize: 16,
       
      ),
    ),TextSpan(
      text: value,
      style: TextStyle(
        
        color: MyColors.myWhite,
        fontSize: 14,
        
      ),
    ),]

  ),);
 }
 Widget buildDivider(double endIndent){
  return Divider(
    height: 30,
    thickness: 2,
    endIndent: endIndent,
    color: MyColors.myYellow,
  );
 }
 Widget CheckIfContinentAreLoaded( CharactersState state){
  if (  state is QuoteLoaded) {
     return displayrandomquoteoremptyspace(state);
  }else {
    return showProgressIndicator();
  }
 
 }
 Widget displayrandomquoteoremptyspace(state){
  var quotes = (state).quote;
  if(quotes.length != 0){
  int randomquote = Random().nextInt(quotes.length -1);
  return Center(
    child: DefaultTextStyle(textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color: MyColors.myWhite,
    shadows: [
      Shadow(
        blurRadius: 7,
        color: MyColors.myWhite,
        offset: Offset(0, 0),
      )
    ]
    
    ), child: AnimatedTextKit(
      repeatForever: true,
      animatedTexts:[FlickerAnimatedText(quotes[randomquote].quote)])),
  );
  }else return Container();
 }
 Widget showProgressIndicator(){
  return Center(
    child: CircularProgressIndicator(color: MyColors.myYellow,),
  );
 }

  @override
  Widget build(BuildContext context) {
     BlocProvider.of<CharactersCubit>(context,listen: false).getQuote();
    return Scaffold(
      backgroundColor: (MyColors.myGray),
      body: CustomScrollView(
        slivers: [
          BuildSliverAppBar(),
          SliverList(delegate: SliverChildListDelegate(
            [
              Container(
                margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      CharacaterInfo('FullName : ',character.fullName),
                      buildDivider(250),
                      CharacaterInfo('Title : ',character.title),
                      buildDivider(250),
                      CharacaterInfo('Family : ',character.family),
                      buildDivider(250),
                      
                      SizedBox(height: 20,),
                      BlocBuilder<CharactersCubit, CharactersState>(
                        builder: (context, state) {
                          return CheckIfContinentAreLoaded(state);
                        },
                      )
                     
                  ],
                ),
              ),
              SizedBox(height: 500,),
            ]
          ))
        ],
      ),
    );
  }
}