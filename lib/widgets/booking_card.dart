import 'package:flutter/material.dart';
import '../models/booking.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../utils/date_helper.dart';
import 'status_badge.dart';

class BookingCard extends StatelessWidget {
  final Booking booking;
  final VoidCallback? onCancel;

  const BookingCard({
    super.key,
    required this.booking,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${booking.machine.type} ${booking.machine.number}',
                    style: AppTextStyles.h3,
                  ),
                ),
                StatusBadge(status: booking.status),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: AppColors.grey),
                const SizedBox(width: 4),
                Text(
                  booking.machine.location,
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: AppColors.grey),
                const SizedBox(width: 4),
                Text(
                  DateHelper.formatDate(booking.date),
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: AppColors.grey),
                const SizedBox(width: 4),
                Text(
                  '${DateHelper.formatTime(booking.startTime)} - ${DateHelper.formatTime(booking.endTime)}',
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),
            if (onCancel != null && booking.status == BookingStatus.confirmed) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: onCancel,
                  icon: const Icon(Icons.cancel_outlined),
                  label: const Text('Cancel Booking'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.danger,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
