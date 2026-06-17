import 'package:flutter/material.dart';
import '../core/app_routes.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../models/machine.dart';
import '../widgets/status_badge.dart';
import '../widgets/custom_button.dart';

class MachineDetailScreen extends StatelessWidget {
  const MachineDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final machine = ModalRoute.of(context)!.settings.arguments as Machine;

    return Scaffold(
      appBar: AppBar(
        title: Text('${machine.type} ${machine.number}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                machine.type == 'Washer'
                    ? Icons.local_laundry_service
                    : Icons.dry,
                size: 80,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${machine.type} ${machine.number}',
                  style: AppTextStyles.h2,
                ),
                StatusBadge(status: machine.status),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, size: 20, color: AppColors.grey),
                const SizedBox(width: 8),
                Text(
                  machine.location,
                  style: AppTextStyles.bodyLarge,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Machine Information',
                      style: AppTextStyles.h3,
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow('Type', machine.type),
                    const SizedBox(height: 12),
                    _buildInfoRow('Status', _getStatusText(machine.status)),
                    const SizedBox(height: 12),
                    _buildInfoRow('Location', machine.location),
                  ],
                ),
              ),
            ),
            const Spacer(),
            CustomButton(
              text: 'Book This Machine',
              onPressed: machine.status == MachineStatus.available
                  ? () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.booking,
                        arguments: machine,
                      );
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.grey,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodyMedium,
        ),
      ],
    );
  }

  String _getStatusText(MachineStatus status) {
    switch (status) {
      case MachineStatus.available:
        return 'Available';
      case MachineStatus.inUse:
        return 'In Use';
      case MachineStatus.maintenance:
        return 'Maintenance';
    }
  }
}
