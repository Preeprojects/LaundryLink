import 'package:flutter/foundation.dart';
import '../models/machine.dart';
import '../services/machine_service.dart';

class MachineProvider with ChangeNotifier {
  final MachineService _machineService = MachineService();
  List<Machine> _machines = [];
  bool _isLoading = false;

  List<Machine> get machines => _machines;
  bool get isLoading => _isLoading;

  Future<void> fetchMachines() async {
    _isLoading = true;
    notifyListeners();

    try {
      _machines = await _machineService.getMachines();
    } catch (e) {
      debugPrint('Error fetching machines: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Machine? getMachineById(String id) {
    try {
      return _machines.firstWhere((m) => m.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Machine> getAvailableMachines() {
    return _machines.where((m) => m.status == MachineStatus.available).toList();
  }
}
