import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRegisterPage extends StatelessWidget {
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtSenha = TextEditingController();

  void register(BuildContext context) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: txtEmail.text,
        password: txtSenha.text,
      );
      await credential.user?.updateDisplayName(txtNome.text);
      Navigator.pushReplacementNamed(context, "/lista");
    } on FirebaseAuthException catch (ex) {
      SnackBar snackBar = SnackBar(
        content: Text(ex.message!),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
              controller: txtNome,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Name",
              ),
            ),
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
              onPressed: () => register(context),
              child: Text("Registrar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Voltar"),
            ),
          ],
        ),
      ),
    );
  }
}
