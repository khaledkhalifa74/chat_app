import 'package:chat_firebase/blocs/auth_bloc/auth_event.dart';
import 'package:chat_firebase/blocs/auth_bloc/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{
  AuthBloc() : super (AuthInitial()){
    on<AuthEvent>((event, emit) async{
      if(event is LoginEvent){
        emit(LoginLoading());
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: event.email, password: event.password);
          emit(LoginSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(LoginFailure(errorMessage: 'user not found'));
          } else if (e.code == 'wrong-password') {
            emit(LoginFailure(errorMessage: 'wrong password'));
          }
        }
        on Exception catch (e) {
          emit(LoginFailure(errorMessage: 'something went wrong'));
        }
      }
      else if (event is RegisterEvent){
        emit(RegisterLoading());
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: event.email, password: event.password);
          emit(RegisterSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            emit(RegisterFailure(errorMessage: 'The password provided is too weak'));
          } else if (e.code == 'email-already-in-use') {
            emit(RegisterFailure(errorMessage: 'The account already exists for that email'));
          }
        }
        on Exception catch (e) {
          emit(RegisterFailure(errorMessage: 'something went wrong'));
        }
      }
    });
  }
  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
  }
}