import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../uteis/cores.dart';

class ItemMensagem extends StatelessWidget {

  String mensagem;
  String enviado;
  String data;
  String nomeFunc;
  String idFunc;
  String nomeSocio;
  String perfilFunc;
  List alunos;

  ItemMensagem({
    required this.mensagem,
    required this.enviado,
    required this.data,
    required this.nomeSocio,
    required this.idFunc,
    required this.nomeFunc,
    required this.perfilFunc,
    required this.alunos,
  });

  @override
  Widget build(BuildContext context) {

    double largura = MediaQuery.of(context).size.width;

    return Row(
      children: [
        enviado!=FirebaseAuth.instance.currentUser!.uid?SizedBox(width: 50,):Container(),
        Container(
          width: largura*0.75,
          alignment: enviado!=FirebaseAuth.instance.currentUser!.uid?Alignment.centerRight:Alignment.centerLeft,
          decoration: BoxDecoration(
              color: enviado==FirebaseAuth.instance.currentUser!.uid?Cores.cinzaClaro:Cores.cinzaEscuro,
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 9),
          child: Column(
            crossAxisAlignment: enviado==FirebaseAuth.instance.currentUser!.uid?CrossAxisAlignment.start:CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                width: largura*0.6,
                child:TextoPadrao(
                  texto: mensagem,
                  maxLinhas: 100,
                  tamanho: 14,
                  cor: Colors.black87,
                  textAlign: enviado==FirebaseAuth.instance.currentUser!.uid?TextAlign.start:TextAlign.end,
                )
              ),
              TextoPadrao(texto: data,cor: Colors.black54,tamanho: 10,),
            ],
          ),
        ),
        enviado==FirebaseAuth.instance.currentUser!.uid?SizedBox(width: 50,):Container(),
      ],
    );
  }
}
