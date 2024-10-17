import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../uteis/cores.dart';

class BotaoCamera extends StatelessWidget {
  var funcao;
  XFile? foto;

  BotaoCamera({
    required this.funcao,
    required this.foto,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: GestureDetector(
        onTap: funcao,
        child: CircleAvatar(
          backgroundColor: Cores.input,
          maxRadius: 50,
          child: foto==null
              ?Icon(Icons.add_a_photo,color: Colors.grey[400],size: 35,)
              :ClipOval(child: Image.file(File(foto!.path),width: 100,height: 100,fit: BoxFit.cover,)),
        ),
      ),
    );
  }
}
