import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../uteis/cores.dart';

class InputPadrao extends StatelessWidget {
  String tituloTopo;
  TextEditingController controller;
  bool ocultarTexto;
  List<TextInputFormatter>? inputFormatters = [];
  TextInputType textInputType;
  double paddingVertical;
  double paddingHorizontal;
  Color corInput;
  Color corBorda;
  Color corTitulo;
  Color corHint;
  var onChanged;
  String textoValidacao;
  bool habilitado;
  String hint;
  double arredondamentoEsquerdo;
  double arredondamentoDireito;
  int maxLetras;
  int maxLinhas;
  var pesquisar;
  FocusNode? focusNode;

  InputPadrao({
    required this.tituloTopo,
    required this.controller,
    this.ocultarTexto = false,
    this.textInputType = TextInputType.text,
    this.paddingHorizontal = 120,
    this.paddingVertical = 10,
    this.corBorda = Colors.white,
    this.corInput = Cores.input,
    this.corTitulo = Cores.azul,
    this.corHint = Cores.texto,
    this.onChanged = null,
    this.textoValidacao = '',
    this.habilitado = true,
    this.hint = '',
    this.arredondamentoDireito = 10,
    this.arredondamentoEsquerdo = 10,
    this.maxLetras = 0,
    this.maxLinhas = 1,
    this.pesquisar =null,
    this.focusNode = null,
    List<TextInputFormatter>? inputFormatters, // Alteração aqui
  }) : inputFormatters = inputFormatters ?? [];


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal,vertical: paddingVertical),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tituloTopo==''?Container():TextoPadrao(texto: tituloTopo , negrito: true,cor: corTitulo,tamanho: 14,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                border: Border.all(color: corBorda),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(arredondamentoEsquerdo),
                  topRight: Radius.circular(arredondamentoDireito),
                  bottomLeft: Radius.circular(arredondamentoEsquerdo),
                  bottomRight: Radius.circular(arredondamentoDireito)
                ),
                color: corInput
            ),
            child: TextFormField(
              controller: controller,
              obscureText: ocultarTexto,
              inputFormatters: inputFormatters,
              keyboardType: textInputType,
              maxLines: maxLinhas,
              maxLength: maxLetras==0?null:maxLetras,
              decoration: InputDecoration(
                counterText: '',
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(color: corHint)
              ),
              onFieldSubmitted: pesquisar,
              onChanged: onChanged,
              enabled: habilitado,
              focusNode: focusNode,
            ),
          ),
          textoValidacao==''?Container():TextoPadrao(texto: textoValidacao,cor: Cores.erro),
        ],
      ),
    );
  }
}
