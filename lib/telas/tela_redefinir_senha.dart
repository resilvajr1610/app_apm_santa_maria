import 'package:app_apm_santa_maria/telas/tela_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../componentes/botao_sublinhado.dart';
import '../componentes/botao_texto_customizado.dart';
import '../componentes/input_padrao.dart';
import '../componentes/snackBars.dart';

class TelaRedefinirSenha extends StatefulWidget {
  const TelaRedefinirSenha({super.key});

  @override
  State<TelaRedefinirSenha> createState() => _TelaRedefinirSenhaState();
}

class _TelaRedefinirSenhaState extends State<TelaRedefinirSenha> {

  var email = TextEditingController();

  logar(){
    if(email.text.contains('@') && email.text.contains('.')){
      FirebaseAuth.instance.sendPasswordResetEmail(email: email.text).then((_){
        showSnackBar(context, 'Acesse seu e-mail para continuar a alteração de senha!\nVerifique também sua caixa de spam e lixo eletrônico caso não receba o e-mail na caixa de entrada', Colors.green);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>TelaLogin()));
      });
    }else{
      showSnackBar(context, 'E-mail incompleto', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/imagens/logo.png',height: 150,),
            InputPadrao(tituloTopo: 'E - mail de acesso', controller: email,paddingHorizontal: 40,),
            BotaoTextoCustomizado(
              texto: 'Alterar senha',
              borda: 5,
              paddingHorizontal: 0,
              paddingVertical: 10,
              larguraCustomizada: 0.8,
              altura: 45,
              funcao: ()=>logar(),
            ),
            BotaoSublinhado(
              texto: 'Voltar ao Login',
              funcao: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>TelaLogin())),
            ),
          ],
        ),
      ),
    );
  }
}
