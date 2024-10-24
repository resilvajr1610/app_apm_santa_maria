import 'dart:io';
import 'package:app_apm_santa_maria/componentes/snackBars.dart';
import 'package:app_apm_santa_maria/telas/tela_emprestimos.dart';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ServicoNotificacao{
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNofiticationsPlugin = FlutterLocalNotificationsPlugin();

  void permissaoNotificacao(context)async{
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print('autorizado');
    }else if (settings.authorizationStatus == AuthorizationStatus.provisional){
      print('provisional');
    }else{
      showSnackBar(context, 'Permissão para notificacão negada', Colors.red);
      Future.delayed(Duration(seconds: 2),(){
        AppSettings.openAppSettings(type: AppSettingsType.notification);
      });
    }
  }

  void initLocalNotificacao(BuildContext context, RemoteMessage message)async{
    // https://www.youtube.com/watch?v=b-it1TsDTd8&list=PLCLjX4pcwQDny-rOsxh-MxvY30yujVWpc&index=5
    var androidSetting = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initSetting = InitializationSettings(android: androidSetting);

    await flutterLocalNofiticationsPlugin.initialize(initSetting);
  }

  void firebaseInit(BuildContext context){
    FirebaseMessaging.onMessage.listen((message){
      RemoteNotification? notificacao = message.notification;
      AndroidNotification? android = message.notification!.android;

      if(kDebugMode){
        print('notif title: ${notificacao!.title}');
        print('notif body: ${notificacao!.body}');
      }
      if(Platform.isAndroid){
        initLocalNotificacao(context, message);
        // handleMessage(context, message);
        exibirNotificacao(message);
      }
    });
  }

  Future<void> exibirNotificacao(RemoteMessage message)async{
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        message.notification!.android!.channelId.toString(),
        message.notification!.android!.channelId.toString(),
        importance: Importance.high,
        showBadge: true,
        playSound: true,
    );
    AndroidNotificationDetails androidNotificationDetails= AndroidNotificationDetails(
        channel.id.toString(),
        channel.name.toString(),
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        sound: channel.sound,
        additionalFlags: Int32List.fromList([4]),
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails
    );
    Future.delayed(Duration.zero, (){
      flutterLocalNofiticationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails,
      );
    });
  }

  Future<void> setupInterMessage(BuildContext context)async{

    FirebaseMessaging.onMessageOpenedApp.listen((message){
      handleMessage(context, message);
    });
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message){
      if(message!= null && message.data.isNotEmpty){
        handleMessage(context, message);
      }
    });
  }

  Future<void> handleMessage(BuildContext context, RemoteMessage message)async{
    Navigator.push(context, MaterialPageRoute(builder: (context)=>TelaEmprestimos()));
  }
}