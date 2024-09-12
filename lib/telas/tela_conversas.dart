import 'package:flutter/material.dart';
import '../componentes/botao_texto.dart';
import '../componentes/drawer_padrao.dart';
import '../componentes/input_padrao.dart';
import '../componentes/texto_padrao.dart';
import '../uteis/cores.dart';
import '../componentes/item_conversa.dart';

class TelaConversas extends StatefulWidget {
  const TelaConversas({super.key});

  @override
  State<TelaConversas> createState() => _TelaConversasState();
}

class _TelaConversasState extends State<TelaConversas> {

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Container(
          alignment: Alignment.centerRight,
          child: TextoPadrao(texto: 'APM', negrito: true, tamanho: 20),
        ),
        backgroundColor: Cores.azul,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Image.asset('assets/imagens/logo.png', height: 50),
          SizedBox(width: 10),
        ],
      ),
      drawer: DrawerPadrao(),
      body: Container(
        height: altura*0.9,
        padding: EdgeInsets.all(24),
        child: ListView(
          children: [
            TextoPadrao(
              texto: 'Mensagens',
              cor: Cores.azul,
              tamanho: 14,
              negrito: true,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: TextoPadrao(
                texto: 'Gustavo - Administração',
                cor: Cores.azul,
                tamanho: 12,
                negrito: true,
              ),
            ),
            Container(
              height: altura * 0.7,
              child: ListView.builder(
                reverse: true,
                itemCount: 10,
                itemBuilder: (context, i) {
                  return Container(
                    child: ItemConversa(
                      mensagem:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
                      data: '20/06/2024',
                      destinatario: i > 1,
                    ),
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Cores.input,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InputPadrao(
                      arredondamentoDireito: 0,
                      arredondamentoEsquerdo: 10,
                      tituloTopo: '',
                      controller: TextEditingController(),
                      corBorda: Cores.input,
                      paddingHorizontal: 0,
                      paddingVertical: 0,
                      hint: 'Digite a sua mensagem',
                    ),
                  ),
                  BotaoTexto(
                    tamanhoMaximo: Size(100, 35),
                    tamanhoMinimo: Size(100, 35),
                    arredodamento: 5,
                    texto: 'Enviar',
                    corBotao: Cores.azul,
                    corBorda: Cores.azul,
                    corTexto: Colors.white,
                    negrito: false,
                    tamanhoTexto: 14,
                    funcao: () {},
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
