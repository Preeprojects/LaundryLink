import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../models/machine.dart';
import '../models/booking.dart';

class StatusBadge extends StatelessWidget {
  final dynamic status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = AppColors.grey.withOpacity(0.1);
    Color textColor = AppColors.grey;
    String text = 'Unknown';

    if (status is MachineStatus) {
      switch (status) {
        case MachineStatus.available:
          backgroundColor = AppColors.secondary.withOpacity(0.1);
          textColor = AppColors.secondary;
          text = 'Available';
          break;
        case MachineStatus.inUse:
          backgroundColor = AppColors.accent.withOpacity(0.1);
          textColor = AppColors.accent;
          text = 'In Use';
          break;
        case MachineStatus.maintenance:
          backgroundColor = AppColors.danger.withOpacity(0.1);
          textColor = AppColors.danger;
          text = 'Maintenance';
          break;
      }
    } else if (status is BookingStatus) {
      switch (status) {
        case BookingStatus.confirmed:
          backgroundColor = AppColors.secondary.withOpacity(0.1);
          textColor = AppColors.secondary;
          text = 'Confirmed';
          break;
        case BookingStatus.cancelled:
          backgroundColor = AppColors.danger.withOpacity(0.1);
          textColor = AppColors.danger;
          text = 'Cancelled';
          break;
        case BookingStatus.completed:
          backgroundColor = AppColors.grey.withOpacity(0.1);
          textColor = AppColors.grey;
          text = 'Completed';
          break;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
