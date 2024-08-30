

import 'package:breaking/Business_logic/cubit/characters_cubit.dart';
import 'package:breaking/constants/mycolors.dart';
import 'package:breaking/data/models/characters.dart';
import 'package:breaking/presentstion/widgets/charateritems.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class Character_Screen extends StatefulWidget {
  const Character_Screen({super.key});

  @override
  State<Character_Screen> createState() => _Character_ScreenState();
}

class _Character_ScreenState extends State<Character_Screen> {
  late List<Character> allcharaters;
  late List<Character> search_characters;
  bool Is_Searching = false;
  final _searchControler = TextEditingController();
  Widget _buildsearchcharacter(){
    return TextField(
      controller: _searchControler,
      cursorColor: MyColors.myGray,
      decoration: InputDecoration(
        hintText: 'find the chrarter',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.myGray,fontSize: 18,),
      ),
      style: TextStyle(color: MyColors.myGray,fontSize: 18,),
      onChanged: (searchcharacter) {
        addsearchedForItemsToListCharacter(searchcharacter);
      },
    );
   
   
  }
void addsearchedForItemsToListCharacter(String searchcharacter){
  search_characters=allcharaters.where((character) => character.firstName.toLowerCase().startsWith(searchcharacter)).toList();
  setState(() {
    
  });
}
List<Widget> SearchingAction(){
  if(Is_Searching){
 return[
  IconButton(onPressed: (){
    _clearsearch();
    Navigator.pop(context);
  }, icon: Icon(Icons.clear,color: MyColors.myGray,),),
 ];
  }else{
return[
  IconButton(onPressed: (){
    _startingsearch();
  }, icon: Icon(Icons.search,color: MyColors.myGray,))
];
  }
}
void _startingsearch(){
  ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopsearching),);
  setState(() {
    Is_Searching=true;
  });

}
void _stopsearching(){
 _clearsearch();
 setState(() {
   Is_Searching = false;
 });
}
void _clearsearch()
{
_searchControler.clear();
}
  @override
  void initState() {
    super.initState();
   
    
        BlocProvider.of<CharactersCubit>(context,listen: false).getAllCharacters();
        
        setState(() {
          
        });
  
   
  }

  Widget BuildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharacterLoaded) {
        allcharaters = (state).characters;
        return BuildLoadedListWidget();
      } else {
        return showloadingindicator();
      }
    });
  }

  Widget showloadingindicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myGray,
      ),
    );
  }

  Widget BuildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGray,
        child: Column(
          children: [
            builCharaterList(),
          ],
        ),
      ),
    );
  }

  Widget builCharaterList() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        childAspectRatio: 2 / 3,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _searchControler.text.isEmpty ? allcharaters.length : search_characters.length,
      itemBuilder: ((context, index) {
        return CharaterItem(character: _searchControler.text.isEmpty ? allcharaters[index]: search_characters[index],);
      }),
    );
  }
 Widget _buildAppBar(){
  return Text(
          'ACTORS',
          style: TextStyle(color: MyColors.myWhite),
        );
 }

 Widget buildNoInternetWidget(){
  return Center(
    child: Container(
      color: Colors.white70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        SizedBox(height: 20,),
        Text('Check Your Network',style: TextStyle(fontSize: 24,),),
        Image.asset('assets/images/undraw_server_down_s4lk.png')
      ],),
    ),
  );
 }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        leading: Is_Searching ? BackButton(color: MyColors.myGray,) : Container(),
        title: Is_Searching ? _buildsearchcharacter() : _buildAppBar() ,
        actions: SearchingAction(),
      ),
      body:OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return BuildBlocWidget();
          }
          else{
            return buildNoInternetWidget();
          }
        },
        child: showloadingindicator(),
        ),
      
      
      // BuildBlocWidget(),
    );
  }
}
