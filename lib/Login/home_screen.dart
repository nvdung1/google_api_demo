import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapi_demo/Login/Login_state_notifier.dart';
import 'package:googleapi_demo/Login/login_screen.dart';
import 'package:googleapi_demo/Login/login_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key, required this.user}) : super(key: key);

  final GoogleSignInAccount user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginProvider = StateNotifierProvider<LoginStateNotifier, LoginState>(
        (_) => LoginStateNotifier());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () async {
                await ref.read(loginProvider.notifier).logout();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LoginScreen()));
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.blueGrey.shade900,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Profile',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 32),
            CircleAvatar(
              radius: 40,
              backgroundImage: getImage(),
            ),
            const SizedBox(height: 8),
            Text('Name: ' + user.displayName!,
                style: const TextStyle(color: Colors.white, fontSize: 20)),
            const SizedBox(height: 8),
            Text('Email: ' + user.email,
                style: const TextStyle(color: Colors.white, fontSize: 20))
          ],
        ),
      ),
    );
  }

  NetworkImage getImage() {
    if (user.photoUrl == null) {
      return const NetworkImage(
          'https://upload.wikimedia.org/wikipedia/commons/b/b1/Loading_icon.gif?20151024034921');
    } else {
      return NetworkImage(user.photoUrl!);
    }
  }
}
