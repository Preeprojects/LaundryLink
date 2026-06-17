import 'package:flutter/foundation.dart';
import '../models/booking.dart';
import '../models/machine.dart';
import '../services/booking_service.dart';

class BookingProvider with ChangeNotifier {
  final BookingService _bookingService = BookingService();
  List<Booking> _bookings = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Booking> get bookings => _bookings;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchBookings(String userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _bookings = await _bookingService.getBookingsByUserId(userId);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Booking?> createBooking({
    required String userId,
    required Machine machine,
    required DateTime date,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final booking = await _bookingService.createBooking(
        userId: userId,
        machine: machine,
        date: date,
        startTime: startTime,
        endTime: endTime,
      );
      _bookings.insert(0, booking);
      return booking;
    } catch (e) {
      _errorMessage = e.toString();
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> cancelBooking(String bookingId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _bookingService.cancelBooking(bookingId);
      final index = _bookings.indexWhere((b) => b.id == bookingId);
      if (index != -1) {
        _bookings[index] = _bookings[index].copyWith(
          status: BookingStatus.cancelled,
        );
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> checkAvailability({
    required String machineId,
    required DateTime date,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    return await _bookingService.isTimeSlotAvailable(
      machineId: machineId,
      date: date,
      startTime: startTime,
      endTime: endTime,
    );
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
