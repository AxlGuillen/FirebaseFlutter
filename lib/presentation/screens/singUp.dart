import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SingUp extends StatelessWidget {
  const SingUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //logo de firebase
                Image.network(
                    'https://geykel.files.wordpress.com/2017/05/firebase-ionic2.png?w=429&h=242'),
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

class _RegisterFormState extends State<_RegisterForm> {
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String password2 = '';

  Future<void> createUserWithEmailAndPassword(emailAddress, password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // todo mostrar alerta
      print(e);
      context.push('/');
    }
  }

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
              validator: (value) {
                if (value == null || value.isEmpty) return 'Campo requerido';
                if (value.trim().isEmpty) return 'Campo requerido';
                final emailRegExp = RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                );
                if (!emailRegExp.hasMatch(value)) return 'No tiene formato de correo';
                return null;
              },
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              label: 'Contraseña',
              obcuredText: true,
              icono: const Icon(Icons.password_rounded),
              onchanged: (value) => password = value,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Campo requerido';
                if (value.trim().isEmpty) return 'Campo requerido';
                if (value.length < 6) return 'Mas de 6 letras';
                return null;
              },
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              label: 'Confirmar contraseña',
              obcuredText: true,
              icono: const Icon(Icons.password_rounded),
              onchanged: (value) => password2 = value,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Campo requerido';
                if (value.trim().isEmpty) return 'Campo requerido';
                if (value.length < 6) return 'Mas de 6 letras';
                if (value != password) return 'La contraseña no coincide';
                return null;
              },
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () {
                final isValid = _fromKey.currentState!.validate();
                if (!isValid) return;
                createUserWithEmailAndPassword(email, password);
              },
              icon: const Icon(Icons.save_alt_outlined),
              label: const Text('Registrar'),
            ),
          ],
        ));
  }
}
