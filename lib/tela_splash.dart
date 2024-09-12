import 'package:app_apm_santa_maria/tela_login.dart';
import 'package:flutter/material.dart';

class TelaSplash extends StatefulWidget {
  const TelaSplash({super.key});

  @override
  State<TelaSplash> createState() => _TelaSplashState();
}

class _TelaSplashState extends State<TelaSplash> {

  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration(seconds: 3),(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TelaLogin()));
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/imagens/login.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/imagens/logo.png',height: 150,),
            Container(
              margin: EdgeInsets.only(top: 50),
              height: 30,
              width: 30,
              child: CircularProgressIndicator(color: Colors.white,)
            )
          ],
        ),
      ),
    );
  }
}
