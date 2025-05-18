import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    /// Unique identifier for the user profile.
    required String id,

    /// Display name of the user.
    required String displayName,

    /// Email address of the user.
    required String email,

    /// Optional URL to the user's profile photo.
    String? photoUrl,

    /// Optional associated boat identifier.
    String? boatId,
  }) = _UserProfile;

  /// Generate a UserProfile from JSON.
  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
