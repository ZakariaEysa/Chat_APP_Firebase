import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email, password: event.password);
          emit(LoginSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(LoginFailure('No user found for that email.'));
          } else if (e.code == 'wrong-password') {
            emit(LoginFailure('Wrong password provided for that user.'));
          } else if (e.code == 'invalid-credential') {
            emit(LoginFailure(' Please check your email and password.'));
          } else {
            emit(LoginFailure(
                'An error occurred. Please check your connection.'));
          }
        }
      }
    });
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
    // print(transition);
    // debugPrint(transition.toString());
  }
}
