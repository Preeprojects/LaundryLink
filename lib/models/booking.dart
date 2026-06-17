import 'machine.dart';

enum BookingStatus { confirmed, cancelled, completed }

class Booking {
  final String id;
  final String userId;
  final Machine machine;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final BookingStatus status;
  final DateTime createdAt;

  Booking({
    required this.id,
    required this.userId,
    required this.machine,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.createdAt,
  });

  Booking copyWith({
    String? id,
    String? userId,
    Machine? machine,
    DateTime? date,
    DateTime? startTime,
    DateTime? endTime,
    BookingStatus? status,
    DateTime? createdAt,
  }) {
    return Booking(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      machine: machine ?? this.machine,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
