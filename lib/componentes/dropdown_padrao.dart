import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:app_apm_santa_maria/uteis/cores.dart';
import 'package:flutter/material.dart';

class DropDownPadrao extends StatelessWidget {
  var onChanged;
  String? select;
  String title;
  double fontSize;
  List list;
  double width;
  double widthContainer;
  String hint;

  DropDownPadrao({
    required this.onChanged,
    required this.select,
    required this.title,
    required this.list,
    required this.width,
    this.fontSize = 15,
    this.widthContainer = 300,
    this.hint = 'Selecione'
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title.isEmpty?Container():TextoPadrao(texto: title,tamanho: 14,textAlign: TextAlign.end,cor: Cores.azul,negrito: true,),
        Container(
          width: width*0.95,
          padding: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: Cores.input,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
                hint: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: TextoPadrao(texto: hint,tamanho: 15,textAlign: TextAlign.end,cor: Colors.black,),
                ),
                value: select,
                items: list.map((value) => DropdownMenuItem(
                  value: value,
                  child: Container(
                    width: widthContainer,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.0),
                      child: TextoPadrao(
                        texto: value,
                        tamanho: fontSize,
                        cor: Colors.black,
                      ),
                    ),
                  ),
                )
                ).toList(),
                onChanged:onChanged
            ),
          ),
        ),
      ],
    );
  }
}