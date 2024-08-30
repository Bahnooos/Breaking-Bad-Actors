import 'package:breaking/app-route.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( Breaking_Bad(app_routing: App_Routing(),));
}

class Breaking_Bad extends StatelessWidget {
   Breaking_Bad({super.key, required this.app_routing});
  final App_Routing app_routing;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: app_routing.generateRoute,
     
    );
  }
}