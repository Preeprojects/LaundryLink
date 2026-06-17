import 'package:flutter_test/flutter_test.dart';
import 'package:laundrylink/utils/validators.dart';

void main() {
  group('Validators', () {
    group('required', () {
      test('returns error when value is null', () {
        expect(Validators.required(null), isNotNull);
      });

      test('returns error when value is empty', () {
        expect(Validators.required(''), isNotNull);
        expect(Validators.required('   '), isNotNull);
      });

      test('returns null when value is valid', () {
        expect(Validators.required('test'), isNull);
      });
    });

    group('email', () {
      test('returns error when email is invalid', () {
        expect(Validators.email('invalid'), isNotNull);
        expect(Validators.email('invalid@'), isNotNull);
        expect(Validators.email('@invalid.com'), isNotNull);
      });

      test('returns null when email is valid', () {
        expect(Validators.email('test@example.com'), isNull);
      });
    });

    group('password', () {
      test('returns error when password is too short', () {
        expect(Validators.password('12345'), isNotNull);
      });

      test('returns null when password is valid', () {
        expect(Validators.password('password123'), isNull);
      });
    });

    group('confirmPassword', () {
      test('returns error when passwords do not match', () {
        expect(Validators.confirmPassword('different', 'password'), isNotNull);
      });

      test('returns null when passwords match', () {
        expect(Validators.confirmPassword('password', 'password'), isNull);
      });
    });
  });
}
