import 'package:flutter_test/flutter_test.dart';
import 'package:laundrylink/services/booking_service.dart';
import 'package:laundrylink/models/machine.dart';

void main() {
  group('BookingService', () {
    late BookingService bookingService;
    late Machine testMachine;

    setUp(() {
      bookingService = BookingService();
      testMachine = Machine(
        id: '1',
        number: 1,
        type: 'Washer',
        status: MachineStatus.available,
        location: 'Ground Floor',
      );
    });

    test('initial bookings are empty', () async {
      final bookings = await bookingService.getBookingsByUserId('1');
      expect(bookings, isEmpty);
    });

    test('createBooking adds booking', () async {
      final now = DateTime.now();
      final booking = await bookingService.createBooking(
        userId: '1',
        machine: testMachine,
        date: now,
        startTime: now.add(const Duration(hours: 2)),
        endTime: now.add(const Duration(hours: 2, minutes: 30)),
      );

      expect(booking, isNotNull);

      final bookings = await bookingService.getBookingsByUserId('1');
      expect(bookings.length, 1);
    });

    test('cancelBooking updates booking status', () async {
      final now = DateTime.now();
      final booking = await bookingService.createBooking(
        userId: '1',
        machine: testMachine,
        date: now,
        startTime: now.add(const Duration(hours: 2)),
        endTime: now.add(const Duration(hours: 2, minutes: 30)),
      );

      await bookingService.cancelBooking(booking.id);

      final bookings = await bookingService.getBookingsByUserId('1');
      expect(bookings.first.status, BookingStatus.cancelled);
    });
  });
}
