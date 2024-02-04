import 'package:chat_firebase/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_firebase/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_firebase/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_firebase/screens/chat_screen.dart';
import 'package:chat_firebase/screens/login_screen.dart';
import 'package:chat_firebase/screens/register_screen.dart';
import 'package:chat_firebase/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ChatCubit()),
        BlocProvider(create: (context) => AuthBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginScreen.id:(context)=> LoginScreen(),
          RegisterScreen.id:(context)=> RegisterScreen(),
          ChatScreen.id:(context)=> ChatScreen(),
        },
        initialRoute: LoginScreen.id,
      ),
    );
  }
}