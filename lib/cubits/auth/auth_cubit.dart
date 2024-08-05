import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> registerUser(
      {required String? email, required String? password}) async {
    emit(RegisterLoading());

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(RegisterFailure('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(RegisterFailure('Wrong password provided for that user.'));
      } else if (e.code == 'invalid-credential') {
        emit(RegisterFailure(' Please check your email and password.'));
      } else {
        emit(RegisterFailure(
            'An error occurred. Please check your connection.'));
      }
    }
  }

  Future<void> loginUser(
      {required String? email, required String? password}) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure('Wrong password provided for that user.'));
      } else if (e.code == 'invalid-credential') {
        emit(LoginFailure(' Please check your email and password.'));
      } else {
        emit(LoginFailure('An error occurred. Please check your connection.'));
      }
    }
  }

  @override
  void onChange(Change<AuthState> change) {
    // print(change);
    // debugPrint(change.toString());
    super.onChange(change);
  }
}
