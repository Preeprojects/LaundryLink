enum MachineStatus { available, inUse, maintenance }

class Machine {
  final String id;
  final int number;
  final String type;
  final MachineStatus status;
  final String location;

  Machine({
    required this.id,
    required this.number,
    required this.type,
    required this.status,
    required this.location,
  });

  Machine copyWith({
    String? id,
    int? number,
    String? type,
    MachineStatus? status,
    String? location,
  }) {
    return Machine(
      id: id ?? this.id,
      number: number ?? this.number,
      type: type ?? this.type,
      status: status ?? this.status,
      location: location ?? this.location,
    );
  }
}
