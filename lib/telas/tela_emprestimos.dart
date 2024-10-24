import 'package:app_apm_santa_maria/componentes/check_padrao.dart';
import 'package:app_apm_santa_maria/componentes/drawer_padrao.dart';
import 'package:app_apm_santa_maria/componentes/item_emprestimo.dart';
import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:app_apm_santa_maria/sevicos/servico_notificacao.dart';
import 'package:app_apm_santa_maria/uteis/cores.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TelaEmprestimos extends StatefulWidget {
  const TelaEmprestimos({super.key});

  @override
  State<TelaEmprestimos> createState() => _TelaEmprestimosState();
}

class _TelaEmprestimosState extends State<TelaEmprestimos> {

  bool abertos = true;
  bool devolvidos = true;

  DocumentSnapshot? dadosUser;
  List<ItemEmprestimo> emprestimos=[];

  ServicoNotificacao servicoNotificacao = ServicoNotificacao();

  pegarToken()async{
    String? token = await FirebaseMessaging.instance.getToken();
    print("Token do dispositivo: $token");
    FirebaseFirestore.instance.collection('usuarios').doc(FirebaseAuth.instance.currentUser!.uid).update({
      'token' : token
    });
  }

  carregarUsuario()async{
    FirebaseFirestore.instance.collection('usuarios').doc(FirebaseAuth.instance.currentUser!.uid).get().then((docUser){
      dadosUser = docUser;
      setState(() {});
    });
  }

  carregarEmprestimos()async{
    FirebaseFirestore.instance.collection('emprestimos').where('idSocio',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then((docEmp){
      for(int i=0; docEmp.docs.length > i; i++){
        emprestimos.add(
            ItemEmprestimo(
                devolvido: docEmp.docs[i]['situacao']=='concluido',
                material: docEmp.docs[i]['material'],
                aluno: docEmp.docs[i]['nomeAluno'].toString().toUpperCase(),
                dataEmprestado: docEmp.docs[i]['dataEmprestimo'],
                dataDevolucao: docEmp.docs[i]['situacao']=='concluido'?formatarData(docEmp.docs[i]['dataConcluido']):docEmp.docs[i]['dataDevolucao']
            )
        );
      }
      setState(() {});
    });
  }

  String formatarData(Timestamp timestamp) {
    DateTime data = timestamp.toDate();
    String dataFormatada = DateFormat('dd/MM/yyyy').format(data);
    return dataFormatada;
  }

  @override
  void initState() {
    super.initState();
    servicoNotificacao.permissaoNotificacao(context);
    servicoNotificacao.firebaseInit(context);
    servicoNotificacao.setupInterMessage(context);
    pegarToken();
    carregarUsuario();
    carregarEmprestimos();
  }

  @override
  Widget build(BuildContext context) {

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
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextoPadrao(texto: 'Empréstimos',cor: Cores.azul,tamanho: 14,negrito: true,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CheckPadrao(
                        check: abertos,
                        texto: 'Em aberto',
                        funcao: (valor){
                          setState(()=>abertos=valor!);
                        }
                    ),
                    CheckPadrao(
                        check: devolvidos,
                        texto: 'Devolvidos',
                        funcao: (valor){
                          setState(()=>devolvidos=valor!);
                        }
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: altura*0.75,
              child: ListView.builder(
                itemCount: emprestimos.length,
                itemBuilder: (context,i){
                  return devolvidos && !abertos && emprestimos[i].devolvido?
                  emprestimos[i]:!devolvidos && abertos && !emprestimos[i].devolvido?emprestimos[i]:devolvidos && abertos?emprestimos[i]:Container();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
