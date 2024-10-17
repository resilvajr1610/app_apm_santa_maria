import 'package:app_apm_santa_maria/componentes/check_padrao.dart';
import 'package:app_apm_santa_maria/componentes/drawer_padrao.dart';
import 'package:app_apm_santa_maria/componentes/item_emprestimo.dart';
import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:app_apm_santa_maria/componentes/titulo_texto.dart';
import 'package:app_apm_santa_maria/uteis/cores.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TelaEmprestimos extends StatefulWidget {
  const TelaEmprestimos({super.key});

  @override
  State<TelaEmprestimos> createState() => _TelaEmprestimosState();
}

class _TelaEmprestimosState extends State<TelaEmprestimos> {

  bool abertos = true;
  bool devolvidos = true;

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
                itemCount: 10,
                itemBuilder: (context,i){
                  return !devolvidos&&!abertos?Container():devolvidos&&!abertos&&i!=0?Container():!devolvidos&&abertos&&i==0?Container():
                  ItemEmprestimo(
                    devolvido: i==0,
                    material: 'Calça de sarja bege P',
                    aluno: 'Gustavo Oliveira',
                    dataEmprestado: '20/06/2024',
                    dataDevolucao: '20/07/2024'
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
