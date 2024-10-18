import 'package:app_apm_santa_maria/componentes/item_mensagem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../componentes/drawer_padrao.dart';
import '../componentes/texto_padrao.dart';
import '../uteis/cores.dart';

class TelaMensagens extends StatefulWidget {

  @override
  State<TelaMensagens> createState() => _TelaMensagensState();
}

class _TelaMensagensState extends State<TelaMensagens> {

  DocumentSnapshot? dadosUser;

  carregarUsuario()async{
    FirebaseFirestore.instance.collection('usuarios').doc(FirebaseAuth.instance.currentUser!.uid).get().then((docUser){
      dadosUser = docUser;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    carregarUsuario();
  }
  @override
  Widget build(BuildContext context) {

    double largura = MediaQuery.of(context).size.width;
    double altura = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Container(alignment:Alignment.centerRight,child: TextoPadrao(texto: 'APM',negrito: true,tamanho: 20,)),
        backgroundColor: Cores.azul,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Image.asset('assets/imagens/logo.png',height: 50,),
          SizedBox(width: 10,)
        ],
      ),
      drawer: DrawerPadrao(dadosUser: dadosUser,),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextoPadrao(texto: 'Mensagens',cor: Cores.azul,tamanho: 14,negrito: true,),
            Container(
              margin: EdgeInsets.only(top: 24),
              height: altura*0.75,
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context,i){
                  return ItemMensagem(
                      data: '20/06/2024',
                      de: 'Gustavo',
                      cargo: 'Administração',
                      mensagem: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor...',
                      visto: i!=0,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
