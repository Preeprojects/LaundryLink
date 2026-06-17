import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/app_routes.dart';
import '../core/app_strings.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../models/booking.dart';
import '../widgets/booking_card.dart';
import '../widgets/empty_state.dart';
import '../widgets/loading_overlay.dart';
import '../providers/booking_provider.dart';
import '../providers/auth_provider.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.user != null) {
        Provider.of<BookingProvider>(context, listen: false)
            .fetchBookings(authProvider.user!.id);
      }
    });
  }

  Future<void> _cancelBooking(String bookingId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Booking'),
        content: const Text('Are you sure you want to cancel this booking?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await Provider.of<BookingProvider>(context, listen: false)
          .cancelBooking(bookingId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.myBookings),
      ),
      body: LoadingOverlay(
        isLoading: bookingProvider.isLoading,
        child: RefreshIndicator(
          onRefresh: () {
            final authProvider = Provider.of<AuthProvider>(context, listen: false);
            return bookingProvider.fetchBookings(authProvider.user!.id);
          },
          child: bookingProvider.bookings.isEmpty
              ? EmptyState(
                  icon: Icons.calendar_today_outlined,
                  message: AppStrings.noBookings,
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: bookingProvider.bookings.length,
                  itemBuilder: (context, index) {
                    final booking = bookingProvider.bookings[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: BookingCard(
                        booking: booking,
                        onCancel: () => _cancelBooking(booking.id),
                      ),
                    );
                  },
                ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          } else if (index == 2) {
            Navigator.pushNamed(context, AppRoutes.profile);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_today),
            label: 'My Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
