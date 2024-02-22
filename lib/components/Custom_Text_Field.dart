import 'package:flutter/material.dart';

class Custom_Text_Form_Field extends StatelessWidget {
  final String? name;
  Function(String)? Onchanged;
  Custom_Text_Form_Field({this.Onchanged, Key? key, this.name})
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
              if (checkPasswordStrength(data) == PasswordStrength.Strong) {
              } else if (checkPasswordStrength(data) == PasswordStrength.Weak) {
                return " the given password is weak  ";
              } else {
                return "Please enter at least 8 Characters & numbers & symbols";
              }
            }
          }
        },
        onChanged: Onchanged!,
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
  Weak,
  Strong,
  None,
}

PasswordStrength checkPasswordStrength(String password) {
  // Check if the password is null or empty
  if (password == null || password.isEmpty) {
    return PasswordStrength.None;
  }

  // Check the length of the password
  if (password.length < 8) {
    return PasswordStrength.Weak;
  }

  // Check if the password contains at least one uppercase letter, one lowercase letter, and one digit
  if (!password.contains(RegExp(r'[A-Z]')) ||
      !password.contains(RegExp(r'[a-z]')) ||
      !password.contains(RegExp(r'[0-9]'))) {
    return PasswordStrength.Weak;
  }

  // Check if the password contains special characters
  if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return PasswordStrength.Weak;
  }

  // If none of the above conditions are met, the password is considered strong
  return PasswordStrength.Strong;
}
