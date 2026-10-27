import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserLoginPage extends StatelessWidget {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtSenha = TextEditingController();

  void login(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: txtEmail.text,
        password: txtSenha.text,
      );

      Navigator.pushReplacementNamed(context, "/lista");
    } on FirebaseAuthException catch (ex) {
      var erros = {"invalid-email": "E-mail inválido"};
      var snackbar = SnackBar(
        content: Text(erros[ex.code!]!),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: txtEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "E-mail",
              ),
            ),
            TextField(
              controller: txtSenha,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Senha",
              ),
            ),
            ElevatedButton(
              onPressed: () => login(context),
              child: Text("Entrar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/register");
              },
              child: Text("Cadastrar"),
            ),
          ],
        ),
      ),
    );
  }
}
