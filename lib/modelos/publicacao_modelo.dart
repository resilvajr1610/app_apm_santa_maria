import 'package:cloud_firestore/cloud_firestore.dart';
class PublicacaoModelo{
  String id;
  String data;
  Timestamp timestamp;
  String perfil;
  String responsavelCriacao;
  String responsavelNome;
  String texto;
  String urlImagem;

  PublicacaoModelo({
    required this.id,
    required this.data,
    required this.timestamp,
    required this.perfil,
    required this.responsavelCriacao,
    required this.responsavelNome,
    required this.texto,
    required this.urlImagem,
  });
}