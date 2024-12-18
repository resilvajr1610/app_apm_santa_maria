import 'package:app_apm_santa_maria/componentes/botao_texto_customizado.dart';
import 'package:app_apm_santa_maria/componentes/input_padrao.dart';
import 'package:app_apm_santa_maria/modelos/bad_state_lista.dart';
import 'package:app_apm_santa_maria/modelos/bad_state_texto.dart';
import 'package:app_apm_santa_maria/telas/tela_cadastrar_aluno.dart';
import 'package:app_apm_santa_maria/telas/tela_cadastrar_socio.dart';
import 'package:app_apm_santa_maria/telas/tela_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../componentes/botao_texto.dart';
import '../componentes/drawer_padrao.dart';
import '../componentes/texto_padrao.dart';
import '../componentes/titulo_texto.dart';
import '../uteis/cores.dart';

class TelaPerfil extends StatefulWidget {
  const TelaPerfil({super.key});

  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {

  DocumentSnapshot? dadosUser;
  Map<String,dynamic> socio = {};
  List<DocumentSnapshot> alunos = [];
  TextEditingController motivo = TextEditingController();

  carregarUsuario()async{
    FirebaseFirestore.instance.collection('usuarios').doc(FirebaseAuth.instance.currentUser!.uid).get().then((docUser){
      dadosUser = docUser;

      socio={
        'nome'        : BadStateTexto(docUser,'nome'),
        'cpf'         : BadStateTexto(docUser,'cpf'),
        'contato'     : BadStateTexto(docUser,'contato'),
        'rua'         : BadStateTexto(docUser,'rua'),
        'numeroCasa'  : BadStateTexto(docUser,'numeroCasa'),
        'complemento' : BadStateTexto(docUser, 'complemento'),
        'bairro'      : BadStateTexto(docUser, 'bairro'),
        'cep'         : BadStateTexto(docUser, 'cep'),
        'cidade'      : BadStateTexto(docUser, 'cidade'),
        'estado'      : BadStateTexto(docUser, 'estado'),
        'email'       : BadStateTexto(docUser, 'email'),
        'senha'       : BadStateTexto(docUser, 'senha'),
        'foto'        : BadStateTexto(docUser, 'foto'),
        'perfil'      : BadStateTexto(docUser, 'perfil'),
      };
      print(socio);
      if(BadStateLista(dadosUser!,'alunos').isNotEmpty){
        carregarAlunos();
      }
      setState(() {});
    });
  }

  carregarAlunos()async{
      for(int i=0; dadosUser!['alunos'].length > i;i ++){
        FirebaseFirestore.instance.collection('alunos').doc(dadosUser!['alunos'][i]).get().then((docAluno){
          alunos.add(docAluno);
          setState(() {});
        });
      }
  }

  salvarExclusao()async{
    FirebaseFirestore.instance.collection('usuarios').doc(FirebaseAuth.instance.currentUser!.uid).update({
      'acesso' : 'solicitado_exclusao',
      'motivo' : motivo.text,
    }).then((_){
      FirebaseAuth.instance.signOut().then((_){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TelaLogin()));
      });
    });
  }

  confirmarExcluirConta()async{
    await showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            backgroundColor: Cores.erro,
            title: TextoPadrao(texto: 'Aviso',cor: Colors.white,textAlign: TextAlign.center,tamanho: 16,negrito: true,),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextoPadrao(texto: 'Deseja realmente solicitar a exclusão a sua conta?\nNão poderá acessar o após a confimação!',cor: Colors.white,negrito:true,tamanho: 14,maxLinhas: 3,),
                InputPadrao(tituloTopo: 'Motivo', controller: motivo,paddingHorizontal: 0,corTitulo: Colors.white,hint: 'Insira o motivo da exclusão',)
              ],
            ),
            actions: [
              BotaoTexto(
                texto: 'Voltar',
                arredodamento: 5,
                tamanhoTexto: 14,
                corBorda: Colors.white,
                corBotao: Cores.azul,
                corTexto: Colors.white,
                tamanhoMaximo: Size(double.infinity,50),
                tamanhoMinimo: Size(double.infinity,50),
                funcao: ()=>Navigator.pop(context),
              ),
              SizedBox(height: 10,),
              BotaoTexto(
                texto: 'Confirmar solicitação',
                arredodamento: 5,
                tamanhoTexto: 14,
                corBorda: Colors.white,
                corBotao: Cores.erro,
                corTexto: Colors.white,
                tamanhoMaximo: Size(double.infinity,50),
                tamanhoMinimo: Size(double.infinity,50),
                funcao: ()=>salvarExclusao(),
              ),
            ],
          );
        }
    );
  }

  @override
  void initState() {
    super.initState();
    carregarUsuario();
  }

  @override
  Widget build(BuildContext context) {

    double largura = MediaQuery.of(context).size.width;

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
      body: dadosUser==null?Container():Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            CircleAvatar(
              backgroundColor: Cores.azul,
              maxRadius: 35,
              child: CircleAvatar(
                backgroundColor: Cores.input,
                maxRadius: 33,
                backgroundImage:dadosUser==null || BadStateTexto(dadosUser!,'foto')==''?null: NetworkImage(dadosUser!['foto']),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: TextoPadrao(texto: dadosUser!['nome'],cor: Cores.azul,tamanho: 14,textAlign: TextAlign.center,negrito: true,),
            ),
            TextoPadrao(texto: 'CPF '+dadosUser!['cpf'],cor: Cores.azul,tamanho: 14,textAlign: TextAlign.center,negrito: true,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextoPadrao(texto: 'Telefone: ',cor: Cores.azul,tamanho: 12,textAlign: TextAlign.center),
                TextoPadrao(texto: dadosUser!['contato'],cor: Cores.texto,tamanho: 12,textAlign: TextAlign.center),
              ],
            ),Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextoPadrao(texto: 'Endereço:     ',cor: Cores.azul,tamanho: 12,textAlign: TextAlign.center),
                Container(
                  width: largura*0.6,
                  child:
                    BadStateTexto(dadosUser!, 'rua').isEmpty?
                    Container():
                      TextoPadrao(
                        texto: '${dadosUser!['rua']}, n° ${dadosUser!['numeroCasa']}, ${dadosUser!['bairro']}, ${dadosUser!['cidade'].toString().toUpperCase()}, '
                          '${dadosUser!['estado']}, CEP ${dadosUser!['cep']}',
                        cor: Cores.texto,tamanho: 12,textAlign: TextAlign.start,maxLinhas: 5,
                      ),
                ),
              ],
            ),
            Divider(color: Cores.azul,indent: 0,endIndent: 0,thickness: 2,),
            Row(
              children: [
                TextoPadrao(texto: 'Alunos:',cor: Cores.azul,tamanho: 14,negrito: true,),
                IconButton(
                  style: IconButton.styleFrom(backgroundColor: Cores.azul),
                  icon: Icon(Icons.add,color: Colors.white,),
                  onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>TelaCadastrarAluno(dadosSocio: socio, alunosAdicionados: [],adicionarAluno: true,))),
                )
              ],
            ),
            Container(
              height: alunos.length*210,
              child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: alunos.length,
                  separatorBuilder: (context,i){
                    return Divider(indent: 20,endIndent: 20,height: 50,);
                  },
                  itemBuilder: (context,i){
                    return BadStateTexto(alunos[i],'nome')==''?Container():Row(
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            margin: EdgeInsets.only(right: 20),
                            alignment: Alignment.centerLeft,
                            child: CircleAvatar(
                              backgroundColor: Cores.input,
                              maxRadius: 30,
                              child:CircleAvatar(
                                backgroundColor: Cores.input,
                                maxRadius: 33,
                                backgroundImage:dadosUser==null || BadStateTexto(alunos[i],'foto')==''?null: NetworkImage(alunos[i]['foto']),
                              ),
                            )
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: largura*0.7,
                              child: Row(
                                children: [
                                  TituloTexto(titulo: 'Nome', texto: BadStateTexto(alunos[i],'nome')),
                                  Spacer(),
                                  IconButton(
                                      style: IconButton.styleFrom(backgroundColor: Cores.azul),
                                      icon: Icon(Icons.edit,color: Colors.white,),
                                      onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>TelaCadastrarAluno(dadosSocio: null, alunosAdicionados: [alunos[i]],adicionarAluno: false,))),
                                  )
                                ],
                              ),
                            ),
                            TituloTexto(titulo: 'Nome de guerra', texto: BadStateTexto(alunos[i],'nomeGuerra')),
                            TituloTexto(titulo: 'Número do aluno', texto: BadStateTexto(alunos[i],'matricula')),
                            TituloTexto(titulo: 'Turma', texto: BadStateTexto(alunos[i],'serie')),
                            TituloTexto(titulo: 'Nascimento', texto:BadStateTexto(alunos[i],'nascimento')),
                            TituloTexto(titulo: 'Sexo', texto: BadStateTexto(alunos[i],'sexo'))
                          ],
                        ),
                      ],
                    );
                  }
              ),
            ),
            BotaoTextoCustomizado(
              texto: 'Alterar meu cadastro',
              borda: 5,
              funcao: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>TelaCadastrarSocio(dadosUser: dadosUser,))),
            ),
            BotaoTextoCustomizado(
              texto: 'Solicitar exclusão da conta',
              borda: 5,
              corBotao: Cores.erro,
              funcao: ()=>confirmarExcluirConta(),
            ),
          ],
        ),
      ),
    );
  }
}
