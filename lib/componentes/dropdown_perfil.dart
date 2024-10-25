import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:flutter/material.dart';
import '../modelos/perfil_modelo.dart';
import '../uteis/cores.dart';

class DropdownPerfil extends StatelessWidget {
  var onChanged;
  PerfilModelo? selecionado;
  String titulo;
  double tamanhoFonte;
  List lista;
  double larguraLista;
  double larguraItem;

  DropdownPerfil({
    required this.onChanged,
    required this.selecionado,
    required this.titulo,
    required this.lista,
    required this.larguraLista,
    this.tamanhoFonte = 15,
    this.larguraItem = 300
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: Colors.white24,
        border: Border.all(color: Cores.azul),
        borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      width: larguraLista*0.95,
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          iconEnabledColor: Cores.azul,
            hint: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: TextoPadrao(texto: 'Selecione',tamanho: 15,textAlign: TextAlign.end,cor: Cores.azul,),
            ),
            value: selecionado,
            items: lista.map((value) => DropdownMenuItem(
              value: value,
              child: Container(
                width: larguraItem,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: TextoPadrao(
                    texto: value.nome,
                    tamanho: tamanhoFonte,
                    cor: Cores.azul,
                  ),
                ),
              ),
            )
            ).toList(),
            onChanged:onChanged
        ),
      ),
    );
  }
}