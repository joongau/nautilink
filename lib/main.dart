import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:nautilink/routes.dart';
import 'package:nautilink/pages/login_page.dart';
import 'package:nautilink/pages/profile_page.dart';
import 'package:go_router/go_router.dart';

final _router = GoRouter(
  initialLocation: loginRoute,
  routes: [
    GoRoute(
  path: '/profile',
  builder: (context, state) => const ProfilePage(),
),
    GoRoute(
      path: loginRoute,
      builder: (context, state) => const LoginPage(),
    ),
    // TODO: Add additional routes here
  ],
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'NautiLink',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
    );
  }
}
