import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:app_apm_santa_maria/componentes/titulo_texto.dart';
import 'package:flutter/material.dart';
import '../uteis/cores.dart';

class ItemEmprestimo extends StatelessWidget {

  bool devolvido;
  String material;
  String aluno;
  String dataEmprestado;
  String dataDevolucao;

  ItemEmprestimo({
    required this.devolvido,
    required this.material,
    required this.aluno,
    required this.dataEmprestado,
    required this.dataDevolucao,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: !devolvido?Cores.cinzaClaro:Cores.cinzaEscuro,
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 9),
      height: 90,
      child: Column(
        children: [
          Row(
            children: [
              TextoPadrao(texto: dataEmprestado,cor: Colors.black87,tamanho: 12,),
              Spacer(),
              TextoPadrao(texto: !devolvido?'Devolução: ':'Devolvido: ',cor: !devolvido?Colors.red:Cores.azul,tamanho: 12,),
              TextoPadrao(texto: dataDevolucao,cor: Colors.black87,tamanho: 12,),
            ],
          ),
          TituloTexto(titulo: 'Material', texto: material),
          Row(
            children: [
              TituloTexto(titulo: 'Aluno', texto: aluno),
              devolvido?Spacer():Container(),
              devolvido?Icon(Icons.check_circle,color: Colors.grey,):Container()
            ],
          ),
        ],
      ),
    );
  }
}
