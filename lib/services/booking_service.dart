import '../models/booking.dart';
import '../models/machine.dart';
import '../core/exceptions.dart';

class BookingService {
  static final BookingService _instance = BookingService._internal();
  factory BookingService() => _instance;
  BookingService._internal();

  final List<Booking> _bookings = [];

  Future<List<Booking>> getBookingsByUserId(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _bookings.where((b) => b.userId == userId).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<Booking> createBooking({
    required String userId,
    required Machine machine,
    required DateTime date,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final conflictingBookings = _bookings.where((b) =>
        b.machine.id == machine.id &&
        b.date.day == date.day &&
        b.date.month == date.month &&
        b.date.year == date.year &&
        !(endTime.isBefore(b.startTime) || startTime.isAfter(b.endTime)));

    if (conflictingBookings.isNotEmpty) {
      throw BookingException('This time slot is already booked');
    }

    final booking = Booking(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      machine: machine,
      date: date,
      startTime: startTime,
      endTime: endTime,
      status: BookingStatus.confirmed,
      createdAt: DateTime.now(),
    );

    _bookings.add(booking);
    return booking;
  }

  Future<void> cancelBooking(String bookingId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _bookings.indexWhere((b) => b.id == bookingId);
    if (index != -1) {
      _bookings[index] = _bookings[index].copyWith(
        status: BookingStatus.cancelled,
      );
    }
  }

  Future<bool> isTimeSlotAvailable({
    required String machineId,
    required DateTime date,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final conflictingBookings = _bookings.where((b) =>
        b.machine.id == machineId &&
        b.status == BookingStatus.confirmed &&
        b.date.day == date.day &&
        b.date.month == date.month &&
        b.date.year == date.year &&
        !(endTime.isBefore(b.startTime) || startTime.isAfter(b.endTime)));
    return conflictingBookings.isEmpty;
  }
}
