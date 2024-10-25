
import 'package:cloud_firestore/cloud_firestore.dart';

List BadStateLista(item,type){
  List list;
  try {
  dynamic data = item.get(FieldPath([type]))??[];
  list = data;
  } on StateError {
    list = [];
  }
  return list;
}