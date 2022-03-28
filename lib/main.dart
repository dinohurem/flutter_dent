import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider/models/user.dart';
import 'package:flutter_provider/screens/wrapper.dart';
import 'package:flutter_provider/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAfHhV83mXR0bvx0piIP-koShPfa7iqS7o',
      appId: '1:242838545867:android:2cc1d0453ce5e9447cc24e',
      messagingSenderId: '242838545867',
      projectId: 'shdent-29f4c',
    ),
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Doctor?>.value(
      initialData: null,
      value: AuthService().doctor,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
