import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());


  Future<void> registerUser({required String? email, required String? password}) async {

    emit(RegisterLoading());

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!, password: password!);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(RegisterFailure('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(RegisterFailure('Wrong password provided for that user.'));
      } else if (e.code == 'invalid-credential') {
        emit(RegisterFailure(' Please check your email and password.'));
      } else {
        emit(RegisterFailure('An error occurred. Please check your connection.'));
      }
    }


  }




}
