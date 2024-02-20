import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lab3/env/env.dart';
import 'package:lab3/features/app/splash_screen/splash_screen.dart';
import 'package:lab3/features/user_auth/presentation/pages/login_page.dart';

Future main() async{

  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb)
  {
    Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: Env.apiKey, 
        appId: Env.appId, 
        messagingSenderId: Env.messagingSenderId, 
        projectId: Env.projectId));
  }
  
  else
  {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Firebase',
      home: SplashScreen(
        child: LoginPage(),
      )
    );
  }
}
