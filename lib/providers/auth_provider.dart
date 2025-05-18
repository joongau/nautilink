import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nautilink/repositories/auth_repository.dart';

/// Provides the AuthRepository instance.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});
