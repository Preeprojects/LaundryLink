import '../models/machine.dart';

class MachineService {
  static final MachineService _instance = MachineService._internal();
  factory MachineService() => _instance;
  MachineService._internal();

  final List<Machine> _machines = [
    Machine(
      id: '1',
      number: 1,
      type: 'Washer',
      status: MachineStatus.available,
      location: 'Ground Floor',
    ),
    Machine(
      id: '2',
      number: 2,
      type: 'Washer',
      status: MachineStatus.inUse,
      location: 'Ground Floor',
    ),
    Machine(
      id: '3',
      number: 3,
      type: 'Dryer',
      status: MachineStatus.available,
      location: 'Ground Floor',
    ),
    Machine(
      id: '4',
      number: 4,
      type: 'Dryer',
      status: MachineStatus.maintenance,
      location: 'Ground Floor',
    ),
    Machine(
      id: '5',
      number: 5,
      type: 'Washer',
      status: MachineStatus.available,
      location: 'First Floor',
    ),
    Machine(
      id: '6',
      number: 6,
      type: 'Dryer',
      status: MachineStatus.available,
      location: 'First Floor',
    ),
  ];

  Future<List<Machine>> getMachines() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_machines);
  }

  Future<Machine> getMachineById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _machines.firstWhere((m) => m.id == id);
  }
}
