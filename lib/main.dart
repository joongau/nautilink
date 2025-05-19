import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nautilink/routes.dart';
import 'package:nautilink/pages/login_page.dart';
import 'package:nautilink/pages/home_page.dart';
import 'package:nautilink/pages/profile_page.dart';
import 'package:nautilink/providers/auth_provider.dart';

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
    // Watch authentication state
    final userAsync = ref.watch(authStateProvider);
    final isLoggedIn = userAsync.asData?.value != null;

    // Create router based on auth state
    final router = GoRouter(
      initialLocation: isLoggedIn ? homeRoute : loginRoute,
      routes: [
        GoRoute(
          path: loginRoute,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: homeRoute,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    );

    return MaterialApp.router(
      title: 'NautiLink',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: router,
    );
  }
}
