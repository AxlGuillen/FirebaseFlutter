import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SingIn extends StatelessWidget {
  const SingIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //oscuro
                //Image.network('https://firebase.google.com/static/images/brand-guidelines/logo-built_black.png?hl=es-419')
                //claro
                Image.network(
                    'https://firebase.google.com/static/images/brand-guidelines/logo-built_white.png?hl=es-419'),
                const SizedBox(height: 20),
                const _RegisterForm(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

Future<void> signInWithEmailAndPassword(emailAddress,password) async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailAddress,
      password: password
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}

class _RegisterFormState extends State<_RegisterForm> {
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _fromKey,
        child: Column(
          children: [
            CustomTextFormField(
              label: 'Correo Electronico',
              hint: 'ejemplo@correo.com',
              icono: const Icon(Icons.email_rounded),
              onchanged: (value) => email = value,
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              label: 'Contraseña',
              obcuredText: true,
              icono: const Icon(Icons.password_rounded),
              onchanged: (value) => password = value,
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                print('Olvidé la contraseña');
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Olvidé la contraseña',
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.tonalIcon(
              onPressed: () {
                final isValid = _fromKey.currentState!.validate();
                if (!isValid) return;
                print(' $email, $password');
              },
              icon: const Icon(Icons.login_rounded),
              label: const Text('Login'),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => context.push('/singUp'),
              child: const Text(
                'Registrate',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ],
        ));
  }
}
