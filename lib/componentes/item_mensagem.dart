import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:app_apm_santa_maria/componentes/titulo_texto.dart';
import 'package:app_apm_santa_maria/telas/tela_conversas.dart';
import 'package:flutter/material.dart';
import '../uteis/cores.dart';

class ItemMensagem extends StatelessWidget {

  bool visto;
  String de;
  String cargo;
  String mensagem;
  String data;

  ItemMensagem({
    required this.visto,
    required this.de,
    required this.cargo,
    required this.mensagem,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {

    double largura = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>TelaConversas())),
      child: Container(
        decoration: BoxDecoration(
            color: Cores.cinzaClaro,
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 9),
        height: 106,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextoPadrao(texto: data,cor: Colors.black87,tamanho: 12,),
                visto?Container():CircleAvatar(maxRadius: 5,backgroundColor: Cores.azul,)
              ],
            ),
            TituloTexto(titulo: 'De', texto: '$de - $cargo'),
            Container(
              width: largura*0.8,
              child:TituloTexto(titulo: 'Mensagem', texto: mensagem,maxLinhas: 2,)
            ),
          ],
        ),
      ),
    );
  }
}
