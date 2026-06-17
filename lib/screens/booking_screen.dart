import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/app_routes.dart';
import '../core/app_strings.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../models/machine.dart';
import '../utils/date_helper.dart';
import '../widgets/custom_button.dart';
import '../widgets/time_slot_picker.dart';
import '../widgets/loading_overlay.dart';
import '../providers/booking_provider.dart';
import '../providers/machine_provider.dart';
import '../providers/auth_provider.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  Machine? _selectedMachine;
  DateTime? _selectedDate;
  DateTime? _selectedTime;
  List<DateTime> _timeSlots = [];

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _timeSlots = DateHelper.getTimeSlots(_selectedDate!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final machine = ModalRoute.of(context)?.settings.arguments as Machine?;
      if (machine != null) {
        setState(() {
          _selectedMachine = machine;
        });
      }
    });
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate!,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _timeSlots = DateHelper.getTimeSlots(picked);
        _selectedTime = null;
      });
    }
  }

  Future<void> _submit() async {
    if (_selectedMachine == null || _selectedDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final bookingProvider = Provider.of<BookingProvider>(context, listen: false);

    final startTime = _selectedTime!;
    final endTime = startTime.add(const Duration(minutes: 30));

    final booking = await bookingProvider.createBooking(
      userId: authProvider.user!.id,
      machine: _selectedMachine!,
      date: _selectedDate!,
      startTime: startTime,
      endTime: endTime,
    );

    if (mounted && booking != null) {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.bookingConfirmation,
        arguments: booking,
      );
    } else if (mounted && bookingProvider.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(bookingProvider.errorMessage!)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final machineProvider = Provider.of<MachineProvider>(context);
    final bookingProvider = Provider.of<BookingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.bookMachine),
      ),
      body: LoadingOverlay(
        isLoading: bookingProvider.isLoading,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Select Machine',
                style: AppTextStyles.h3,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<Machine>(
                value: _selectedMachine,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: machineProvider.machines
                    .where((m) => m.status == MachineStatus.available)
                    .map((machine) {
                  return DropdownMenuItem(
                    value: machine,
                    child: Text('${machine.type} ${machine.number}'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedMachine = value;
                  });
                },
                hint: const Text('Select a machine'),
              ),
              const SizedBox(height: 24),
              Text(
                'Select Date',
                style: AppTextStyles.h3,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: _selectDate,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: AppColors.lightGrey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateHelper.formatDate(_selectedDate!),
                        style: AppTextStyles.bodyLarge,
                      ),
                      const Icon(Icons.calendar_today_outlined),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Select Time',
                style: AppTextStyles.h3,
              ),
              const SizedBox(height: 12),
              TimeSlotPicker(
                slots: _timeSlots,
                selectedSlot: _selectedTime,
                onSlotSelected: (slot) {
                  setState(() {
                    _selectedTime = slot;
                  });
                },
              ),
              const SizedBox(height: 32),
              CustomButton(
                text: AppStrings.confirmBooking,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
