import 'package:flutter_test/flutter_test.dart';
import 'package:laundrylink/services/auth_service.dart';

void main() {
  group('AuthService', () {
    late AuthService authService;

    setUp(() {
      authService = AuthService();
    });

    test('initial currentUser is null', () {
      expect(authService.currentUser, isNull);
    });

    test('login sets currentUser', () async {
      await authService.login(email: 'test@example.com', password: 'password');
      expect(authService.currentUser, isNotNull);
    });

    test('register sets currentUser', () async {
      await authService.register(
        fullName: 'Test User',
        studentId: 'U12345',
        email: 'test@example.com',
        password: 'password',
      );
      expect(authService.currentUser, isNotNull);
    });

    test('logout clears currentUser', () async {
      await authService.login(email: 'test@example.com', password: 'password');
      await authService.logout();
      expect(authService.currentUser, isNull);
    });
  });
}
