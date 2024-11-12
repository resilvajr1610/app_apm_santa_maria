import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DadosPadroes{
  static List estados = ["AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO",];

  static String formatarDataHora(Timestamp timestamp) {
    DateTime data = timestamp.toDate();
    String dataFormatada = DateFormat('dd/MM/yyyy HH:mm').format(data);
    return dataFormatada;
  }
}