import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/app_strings.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../models/notification_model.dart';
import '../widgets/empty_state.dart';
import '../widgets/loading_overlay.dart';
import '../providers/notification_provider.dart';
import '../utils/date_helper.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NotificationProvider>(context, listen: false)
          .fetchNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.notifications),
      ),
      body: LoadingOverlay(
        isLoading: notificationProvider.isLoading,
        child: RefreshIndicator(
          onRefresh: () => notificationProvider.fetchNotifications(),
          child: notificationProvider.notifications.isEmpty
              ? EmptyState(
                  icon: Icons.notifications_outlined,
                  message: AppStrings.noNotifications,
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: notificationProvider.notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notificationProvider.notifications[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: _getIconColor(notification.type).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _getIcon(notification.type),
                            color: _getIconColor(notification.type),
                          ),
                        ),
                        title: Text(
                          notification.title,
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: notification.isRead
                                ? FontWeight.normal
                                : FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notification.message,
                              style: AppTextStyles.bodySmall,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              DateHelper.formatDateTime(notification.createdAt),
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.grey,
                              ),
                            ),
                          ],
                        ),
                        trailing: !notification.isRead
                            ? Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              )
                            : null,
                        onTap: () {
                          notificationProvider.markAsRead(notification.id);
                        },
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }

  IconData _getIcon(NotificationType type) {
    switch (type) {
      case NotificationType.reminder:
        return Icons.access_time;
      case NotificationType.update:
        return Icons.info_outline;
      case NotificationType.cancellation:
        return Icons.cancel_outlined;
    }
  }

  Color _getIconColor(NotificationType type) {
    switch (type) {
      case NotificationType.reminder:
        return AppColors.accent;
      case NotificationType.update:
        return AppColors.primary;
      case NotificationType.cancellation:
        return AppColors.danger;
    }
  }
}
