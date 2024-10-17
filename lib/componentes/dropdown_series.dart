import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:app_apm_santa_maria/modelos/serie_modelo.dart';
import 'package:app_apm_santa_maria/uteis/cores.dart';
import 'package:flutter/material.dart';

class DropdownSeries extends StatelessWidget {
  var onChanged;
  SerieModelo? selecionado;
  String titulo;
  double tamanhoFonte;
  List lista;
  double largura;
  double larguraContainer;
  String hint;

  DropdownSeries({
    required this.onChanged,
    required this.selecionado,
    required this.titulo,
    required this.lista,
    required this.largura,
    this.tamanhoFonte = 15,
    this.larguraContainer = 300,
    this.hint = 'Selecione'
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titulo.isEmpty?Container():TextoPadrao(texto: titulo,tamanho: 14,textAlign: TextAlign.end,cor: Cores.azul,negrito: true,),
        Container(
          width: largura*0.95,
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
                value: selecionado,
                items: lista.map((value) => DropdownMenuItem(
                  value: value,
                  child: Container(
                    width: larguraContainer,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.0),
                      child: TextoPadrao(
                        texto: value.nome,
                        tamanho: tamanhoFonte,
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