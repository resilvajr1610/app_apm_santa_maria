import 'package:app_apm_santa_maria/componentes/snackBars.dart';
import 'package:app_apm_santa_maria/telas/tela_cadastrar_socio.dart';
import 'package:app_apm_santa_maria/componentes/botao_sublinhado.dart';
import 'package:app_apm_santa_maria/telas/tela_emprestimos.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../componentes/botao_texto_customizado.dart';
import '../componentes/input_padrao.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {

  var email = TextEditingController();
  var senha = TextEditingController();

  logar(){
    if(email.text.contains('@') && email.text.contains('.') && senha.text.isNotEmpty){
      FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: senha.text).then((user){
          print(user.user!.email);
          print(user.user!.uid);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TelaEmprestimos()));
      });
    }else{
      showSnackBar(context, 'E-mail e/ou senha incompleto(s)', Colors.red);
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
            InputPadrao(tituloTopo: 'E - mail', controller: email,paddingHorizontal: 40,),
            InputPadrao(tituloTopo: 'Senha', controller: senha,ocultarTexto: true,paddingHorizontal: 40,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BotaoSublinhado(texto: 'Esqueci a senha/resetar', funcao: (){}),
                ],
              ),
            ),
            BotaoTextoCustomizado(
              texto: 'Entrar',
              borda: 5,
              paddingHorizontal: 0,
              paddingVertical: 10,
              larguraCustomizada: 0.8,
              altura: 45,
              funcao: ()=>logar(),
            ),
            BotaoSublinhado(
              texto: 'Não tem cadastro? Cadastre-se',
              funcao: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>TelaCadastrarSocio())),
            ),
          ],
        ),
      ),
    );
  }
}
