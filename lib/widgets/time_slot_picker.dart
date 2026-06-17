import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../utils/date_helper.dart';

class TimeSlotPicker extends StatelessWidget {
  final List<DateTime> slots;
  final DateTime? selectedSlot;
  final Function(DateTime) onSlotSelected;
  final Set<DateTime> unavailableSlots;

  const TimeSlotPicker({
    super.key,
    required this.slots,
    this.selectedSlot,
    required this.onSlotSelected,
    this.unavailableSlots = const {},
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: slots.map((slot) {
        final isSelected = selectedSlot == slot;
        final isUnavailable = unavailableSlots.contains(slot);

        return GestureDetector(
          onTap: isUnavailable ? null : () => onSlotSelected(slot),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary
                  : isUnavailable
                      ? AppColors.lightGrey
                      : AppColors.white,
              border: Border.all(
                color: isSelected
                    ? AppColors.primary
                    : isUnavailable
                        ? AppColors.lightGrey
                        : AppColors.lightGrey,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              DateHelper.formatTime(slot),
              style: AppTextStyles.bodyMedium.copyWith(
                color: isSelected
                    ? AppColors.white
                    : isUnavailable
                        ? AppColors.grey
                        : AppColors.black,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
