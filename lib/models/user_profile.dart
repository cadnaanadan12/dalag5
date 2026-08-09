class UserProfile {
  final String username;
  final String email;
  final String name;
  final String city;
  final String? photoPath; // local path or asset

  UserProfile({
    required this.username,
    required this.email,
    required this.name,
    required this.city,
    this.photoPath,
  });
}
