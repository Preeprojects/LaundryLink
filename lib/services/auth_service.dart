import '../models/user.dart';
import '../core/exceptions.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Dummy users for testing
  final List<Map<String, String>> _dummyUsers = [
    {
      'email': 'john@university.edu',
      'password': 'password123',
      'fullName': 'John Doe',
      'studentId': 'U2023001',
    },
    {
      'email': 'jane@university.edu',
      'password': 'jane1234',
      'fullName': 'Jane Smith',
      'studentId': 'U2023002',
    },
  ];

  User? _currentUser;
  User? get currentUser => _currentUser;

  Future<User> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    // Find the dummy user
    final user = _dummyUsers.firstWhere(
      (u) => u['email'] == email && u['password'] == password,
      orElse: () => throw AuthException('Invalid email or password'),
    );

    _currentUser = User(
      id: user['studentId']!,
      fullName: user['fullName']!,
      studentId: user['studentId']!,
      email: user['email']!,
    );
    return _currentUser!;
  }

  Future<User> register({
    required String fullName,
    required String studentId,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    // Check if email already exists
    final existingUser = _dummyUsers.any((u) => u['email'] == email);
    if (existingUser) {
      throw AuthException('Email already registered');
    }

    // Add new dummy user
    _dummyUsers.add({
      'email': email,
      'password': password,
      'fullName': fullName,
      'studentId': studentId,
    });

    _currentUser = User(
      id: studentId,
      fullName: fullName,
      studentId: studentId,
      email: email,
    );
    return _currentUser!;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
  }
}
