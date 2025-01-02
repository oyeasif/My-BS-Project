import 'package:adminseller/Model/ChatMessage.dart';
import 'package:adminseller/Model/cartitems.dart';
import 'package:adminseller/Model/categories.dart';
import 'package:adminseller/splashscreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:flutter_notification_channel/notification_visibility.dart';
import 'package:provider/provider.dart';

import 'Model/carditems.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await FlutterNotificationChannel().registerNotificationChannel(
      description: 'To show notifications of mod graphics app',
      id: 'modg',
      importance: NotificationImportance.IMPORTANCE_HIGH,
      name: 'Mod Graphics',
      visibility: NotificationVisibility.VISIBILITY_PUBLIC,);


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>AllCards()),
        ChangeNotifierProvider(create: (_)=>Allcategories()),
        ChangeNotifierProvider(create: (_)=>cartItems()),
        ChangeNotifierProvider(create: (_)=>Messages()),
      ],
      child: MaterialApp(
        title: 'Add Data',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple).copyWith(secondary: Colors.amber),
        ),
        home: const MysplashScreen(),
      ),
    );
  }

}
