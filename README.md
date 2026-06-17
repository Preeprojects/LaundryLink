# LaundryLink - Hostel Laundry Booking App

A Flutter mobile application for university students to book laundry machine time slots.

## Features

- **User Authentication**: Login and registration with email and password
- **Dashboard**: View available laundry machines
- **Booking System**: Book time slots by selecting date, time, and machine
- **My Bookings**: View and cancel bookings
- **Machine Details**: View machine information and status
- **Notifications**: Receive booking reminders and updates
- **Profile**: Manage user profile and logout

## Project Structure

```
lib/
├── main.dart
├── screens/
│   ├── splash_screen.dart
│   ├── login_screen.dart
│   ├── register_screen.dart
│   ├── dashboard_screen.dart
│   ├── booking_screen.dart
│   ├── booking_confirmation_screen.dart
│   ├── my_bookings_screen.dart
│   ├── machine_detail_screen.dart
│   ├── notifications_screen.dart
│   └── profile_screen.dart
├── models/
│   ├── user.dart
│   ├── booking.dart
│   ├── machine.dart
│   ├── time_slot.dart
│   └── notification_model.dart
├── services/
│   ├── database_service.dart
│   ├── auth_service.dart
│   ├── booking_service.dart
│   ├── machine_service.dart
│   └── notification_service.dart
├── providers/
│   ├── auth_provider.dart
│   ├── booking_provider.dart
│   ├── machine_provider.dart
│   └── notification_provider.dart
├── widgets/
│   ├── machine_card.dart
│   ├── booking_card.dart
│   ├── time_slot_picker.dart
│   ├── custom_button.dart
│   ├── custom_text_field.dart
│   ├── status_badge.dart
│   ├── empty_state.dart
│   └── loading_overlay.dart
├── utils/
│   ├── constants.dart
│   ├── validators.dart
│   ├── date_helper.dart
│   ├── app_colors.dart
│   └── app_text_styles.dart
├── core/
│   ├── app_theme.dart
│   ├── app_routes.dart
│   ├── app_strings.dart
│   └── exceptions.dart
└── test/
    ├── booking_test.dart
    ├── validator_test.dart
    └── auth_test.dart
```

## Getting Started

### Prerequisites

- Flutter SDK (version 3.0 or higher)
- Android Studio / VS Code
- Android Emulator or physical device

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Dependencies

- `provider`: State management
- `intl`: Date formatting

## Testing

Run the test suite:

```bash
flutter test
```
