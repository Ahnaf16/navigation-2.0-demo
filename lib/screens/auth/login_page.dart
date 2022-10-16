import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:navigation_testing/auth/login_api.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});
  final emailCtrl = TextEditingController(text: 'a@gng.com');
  final passCtrl = TextEditingController(text: '123456');
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authApiProvider);
    return ScaffoldPage(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            child: TextBox(
              controller: emailCtrl,
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 300,
            child: TextBox(
              controller: passCtrl,
            ),
          ),
          const SizedBox(height: 20),
          FilledButton(
            child: const Text('Email Sign In'),
            onPressed: () {
              auth.emailLogIn(emailCtrl.text, passCtrl.text);
            },
          ),
          const SizedBox(height: 10),
          FilledButton(
            child: const Text('Sign In Anonymously'),
            onPressed: () {
              auth.login;
            },
          ),
          const SizedBox(height: 10),
          IconButton(
            icon: const Icon(MdiIcons.google, size: 30),
            onPressed: () {
              auth.signInWithGoogle;
            },
          ),
        ],
      ),
    );
  }
}
