import 'package:app_apm_santa_maria/componentes/item_mensagem.dart';
import 'package:app_apm_santa_maria/componentes/item_conversa.dart';
import 'package:app_apm_santa_maria/modelos/bad_state_lista.dart';
import 'package:app_apm_santa_maria/modelos/bad_state_texto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../componentes/drawer_padrao.dart';
import '../componentes/texto_padrao.dart';
import '../uteis/cores.dart';

class TelaConversas extends StatefulWidget {

  @override
  State<TelaConversas> createState() => _TelaConversasState();
}

class _TelaConversasState extends State<TelaConversas> {

  DocumentSnapshot? dadosUser;

  List<ItemConversa> conversas = [];

  carregarUsuario()async{
    FirebaseFirestore.instance.collection('usuarios').doc(FirebaseAuth.instance.currentUser!.uid).get().then((docUser){
      dadosUser = docUser;
      setState(() {});
    });
  }

  carregarConversas()async{
    FirebaseFirestore.instance.collection('conversas').where('idSocio',isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots().listen((docConversas){
      for(int i =0; docConversas.docs.length > i; i++){
        conversas.add(
            ItemConversa(
                mensagem: docConversas.docs[i]['mensagem'],
                data: formatarDataHora(docConversas.docs[i]['envio']),
                visto: docConversas.docs[i]['vistoSocio']!='nao',
                cargo: docConversas.docs[i]['perfilFunc'],
                de: docConversas.docs[i]['nomeFunc'],
                idConversa: docConversas.docs[i].id,
                tipo: BadStateTexto(docConversas.docs[i],'topicos')!=''?'transmissao':'privado',
            )
        );
      }
      setState(() {});
    });
    FirebaseFirestore.instance.collection('conversas').where('topicos',isEqualTo: 'socio').snapshots().listen((docConversas){
      for(int i =0; docConversas.docs.length > i; i++){
        conversas.add(
            ItemConversa(
              mensagem: docConversas.docs[i]['mensagem'],
              data: formatarDataHora(docConversas.docs[i]['envio']),
              visto: BadStateLista(docConversas.docs[i],'vistos').contains(FirebaseAuth.instance.currentUser!.uid),
              cargo: docConversas.docs[i]['perfilFunc'],
              de: docConversas.docs[i]['nomeFunc'],
              idConversa: docConversas.docs[i].id,
              tipo: BadStateTexto(docConversas.docs[i],'topicos')!=''?'transmissao':'privado',
            )
        );
      }
      setState(() {});
    });
  }

  String formatarDataHora(Timestamp timestamp) {
    DateTime data = timestamp.toDate();
    String dataFormatada = DateFormat('dd/MM/yyyy HH:mm').format(data);
    return dataFormatada;
  }

  @override
  void initState() {
    super.initState();
    carregarUsuario();
    carregarConversas();
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
          Image.asset('assets/imagens/logo.png',height: 40,),
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
            conversas.isEmpty?Container(
              alignment: Alignment.center,
              height: altura*0.8,
              child: TextoPadrao(texto: 'Não há mensagens',cor: Cores.texto,tamanho: 18,),):Container(
              margin: EdgeInsets.only(top: 24),
              height: altura*0.75,
              child: ListView.builder(
                itemCount: conversas.length,
                itemBuilder: (context,i){
                  return conversas[i];
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
