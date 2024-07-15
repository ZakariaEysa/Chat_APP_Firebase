import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? name;
 final  Function(String)? onChanged;
   const CustomTextFormField({this.onChanged, Key? key, this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: TextFormField(
        obscureText: name == "Email" ? false : true,
        validator: (data) {
          if (data!.isEmpty) {
            return "Field is required";
          } else {
            if (name == "Email") {
              if (isValidEmail(data)) {
              } else {
                return "please enter a vaild email ";
              }
            } else if (name == "Password") {
              if (checkPasswordStrength(data) == PasswordStrength.strong) {
              } else if (checkPasswordStrength(data) == PasswordStrength.weak) {
                return " the given password is weak  ";
              } else {
                return "Please enter at least 8 Characters & numbers & symbols";
              }
            }
          }
        },
        onChanged: onChanged!,
        style: const TextStyle(color: Color(0xffE0E6EB)),
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Color(0xffE0E6EB)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          hintText: name,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.white),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

bool isValidEmail(String email) {
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}

enum PasswordStrength {
  weak,
  strong,
  none,
}

PasswordStrength checkPasswordStrength(String password) {
  // Check if the password is null or empty
  if (password.isEmpty) {
    return PasswordStrength.none;
  }

  // Check the length of the password
  if (password.length < 8) {
    return PasswordStrength.weak;
  }

  // Check if the password contains at least one uppercase letter, one lowercase letter, and one digit
  if (!password.contains(RegExp(r'[A-Z]')) ||
      !password.contains(RegExp(r'[a-z]')) ||
      !password.contains(RegExp(r'[0-9]'))) {
    return PasswordStrength.weak;
  }



  // If none of the above conditions are met, the password is considered strong
  return PasswordStrength.strong;
}
