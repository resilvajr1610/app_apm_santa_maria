import 'package:flutter/material.dart';
import '../uteis/cores.dart';

class BotaoCamera extends StatelessWidget {
  const BotaoCamera({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: CircleAvatar(
        backgroundColor: Cores.input,
        maxRadius: 50,
        child: Icon(Icons.add_a_photo,color: Colors.grey[400],size: 35,),
      ),
    );
  }
}
