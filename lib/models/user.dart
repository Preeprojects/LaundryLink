class User {
  final String id;
  final String fullName;
  final String studentId;
  final String email;

  User({
    required this.id,
    required this.fullName,
    required this.studentId,
    required this.email,
  });

  User copyWith({
    String? id,
    String? fullName,
    String? studentId,
    String? email,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      studentId: studentId ?? this.studentId,
      email: email ?? this.email,
    );
  }
}
