import 'package:breaking/constants/mycolors.dart';
import 'package:breaking/constants/strings.dart';
import 'package:breaking/data/models/characters.dart';
import 'package:flutter/material.dart';

class CharaterItem extends StatelessWidget {
  final Character character;
  const CharaterItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin:const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding:const EdgeInsetsDirectional.all(8),
      decoration: BoxDecoration(
          color: MyColors.myWhite, borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap:()=> Navigator.pushNamed(context, characterDetailsScreen,arguments: character),
        child: GridTile(
           
             child: Hero(
              tag: character.id,
              child: Container(
                  color: MyColors.myGray,
                  child: character.image.isNotEmpty
                      ? FadeInImage.assetNetwork(
                          placeholder: 'assets/images/Animation - 1714166753309.gif',
                          image: character.imageUrl,
                          fit: BoxFit.cover,
                        )
                      : Image.asset( 'assets/images/Simplife EG.png'),
                      ),
            ),
          
          footer: Container(
              width: double.infinity,
              padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
             
              alignment: Alignment.bottomCenter,
              color: Colors.black54,
              child: Text(
                '${character.fullName}', 
                style: const TextStyle(
                    height: 1.3,
                    fontSize: 16,
                    color:MyColors.myWhite,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
         
        ),
      ),
    );
  }
}
