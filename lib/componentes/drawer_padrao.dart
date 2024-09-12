import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:app_apm_santa_maria/telas/tela_emprestimos.dart';
import 'package:app_apm_santa_maria/telas/tela_mensagens.dart';
import 'package:app_apm_santa_maria/telas/tela_perfil.dart';
import 'package:flutter/material.dart';
import '../telas/tela_login.dart';
import '../uteis/cores.dart';
import 'item_menu.dart';

class DrawerPadrao extends StatelessWidget {
  const DrawerPadrao({super.key});

  @override
  Widget build(BuildContext context) {


    double largura = MediaQuery.of(context).size.width;
    double altura = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20))
          ),
          width: largura*0.7,
          height: altura*0.8,
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Cores.azul,
                maxRadius: 35,
                child: CircleAvatar(
                  backgroundColor: Cores.input,
                  maxRadius: 33,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: TextoPadrao(texto: 'Bem-vindo, Roberto',cor: Cores.azul,tamanho: 14,textAlign: TextAlign.center,),
              ),
              Divider(color: Cores.azul,indent: 50,endIndent: 50,thickness: 2,),
              ItemMenu(
                titulo: 'Estatuto da APM',
                icone: Icons.book,
                funcao: (){},
              ),
              ItemMenu(
                titulo: 'Empréstimos',
                icone: Icons.handshake,
                funcao: ()=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>TelaEmprestimos())),
              ),
              Row(
                children: [
                  ItemMenu(
                    titulo: 'Mensagens',
                    icone: Icons.message,
                    funcao: ()=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>TelaMensagens())),
                  ),
                  CircleAvatar(
                      backgroundColor: Cores.vermelho,
                      maxRadius: 10,
                      child: TextoPadrao(texto: '3',tamanho: 14,)
                  )
                ],
              ),
              ItemMenu(
                titulo: 'Perfil',
                icone: Icons.person,
                funcao: ()=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>TelaPerfil())),
              ),
              Spacer(),
              GestureDetector(
                onTap: ()=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>TelaLogin())),
                child: Padding(
                  padding: EdgeInsets.all(14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextoPadrao(texto: 'Sair',tamanho: 14,cor: Cores.azul,),
                      Icon(Icons.logout,color: Cores.azul,)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
