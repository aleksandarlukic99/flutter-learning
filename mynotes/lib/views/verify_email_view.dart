import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(title: const Text("Verify email"),
      ),
      body: Column(
        children: [
          const Text("We've sent you an email verification. Pleaes open it to verify your account."),
          const Text("If you havent recieved email verification, press button below:"),
          TextButton(
            onPressed: () async {
              final user = AuthService.firebase().currentUser;
              await user?.isEmailVerified;
            },
            child: const Text('Send Email verify'),
          ),
          TextButton(onPressed: () async {
            await AuthService.firebase().logOut();
            Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => false);
          },
           child: const Text("Restart"),
           )
        ],
      ),
    );
  }
}