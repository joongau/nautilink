

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nautilink/providers/auth_provider.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _displayNameController;
  late TextEditingController _emailController;
  late TextEditingController _photoUrlController;
  late TextEditingController _boatIdController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    _displayNameController = TextEditingController(text: user?.displayName ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
    _photoUrlController = TextEditingController(text: user?.photoURL ?? '');
    _boatIdController = TextEditingController();
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _photoUrlController.dispose();
    _boatIdController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      // TODO: implement save logic, e.g. call a repository method
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil enregistré')),
      );
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur lors de la sauvegarde')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _signOut() {
    ref.read(authRepositoryProvider).signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _displayNameController,
                      decoration: const InputDecoration(labelText: 'Nom affiché'),
                      validator: (v) =>
                          (v != null && v.isNotEmpty) ? null : 'Nom requis',
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      readOnly: true,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _photoUrlController,
                      decoration: const InputDecoration(labelText: 'URL Photo'),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _boatIdController,
                      decoration: const InputDecoration(labelText: 'ID Bateau'),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _saveProfile,
                      child: const Text('Enregistrer'),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: _signOut,
                      child: const Text('Se déconnecter'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}