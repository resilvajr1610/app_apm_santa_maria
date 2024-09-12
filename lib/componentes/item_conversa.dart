import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:app_apm_santa_maria/componentes/titulo_texto.dart';
import 'package:app_apm_santa_maria/telas/tela_conversas.dart';
import 'package:flutter/material.dart';
import '../uteis/cores.dart';

class ItemConversa extends StatelessWidget {

  String mensagem;
  String data;
  bool destinatario;

  ItemConversa({
    required this.mensagem,
    required this.data,
    required this.destinatario,
  });

  @override
  Widget build(BuildContext context) {

    double largura = MediaQuery.of(context).size.width;

    return Row(
      children: [
        destinatario?SizedBox(width: 50,):Container(),
        Container(
          width: largura*0.75,
          alignment: destinatario?Alignment.centerRight:Alignment.centerLeft,
          decoration: BoxDecoration(
              color: !destinatario?Cores.cinzaClaro:Cores.cinzaEscuro,
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 9),
          child: Column(
            crossAxisAlignment: !destinatario?CrossAxisAlignment.start:CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                width: largura*0.6,
                child:TextoPadrao(
                  texto: mensagem,
                  maxLinhas: 100,
                  tamanho: 12,
                  cor: Colors.black87,
                  textAlign: !destinatario?TextAlign.start:TextAlign.end,
                )
              ),
              TextoPadrao(texto: data,cor: Colors.black87,tamanho: 12,),
            ],
          ),
        ),
        !destinatario?SizedBox(width: 50,):Container(),
      ],
    );
  }
}
