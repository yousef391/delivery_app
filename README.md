# 🛵 Oran Delivery

A modern, fast, and scalable delivery application built with Flutter, designed to streamline logistics and delivery operations in Oran.

---

## 📱 Try it Out

- **Download APK:** [Google Drive Link](https://drive.google.com/file/d/1lIrbZRoKdS7AXf5Ue8DZtmmD5dS6hpHj/view?usp=drive_link)
- **Test Account:**
  - **Email:** `test@example.com` *(Update if needed)*
  - **Password:** `123456`

---

## ✨ Features

- **Onboarding:** Smooth and informative onboarding experience for new users.
- **Authentication:** Secure user login and registration.
- **Home Dashboard:** Real-time overview of current status and quick actions.
- **Deliveries Management:** Comprehensive tracking and management of deliveries.
- **Interactive Maps:** Real-time routing and location tracking powered by `flutter_map` and OpenStreetMap.
- **User Profile:** Manage personal information and app preferences.
- **Settings:** Extensive customization options including **Dark/Light Mode** support.

---

## 🛠 Tech Stack

- **Framework:** [Flutter](https://flutter.dev/) (Dart)
- **State Management:** [`flutter_bloc`](https://pub.dev/packages/flutter_bloc)
- **Dependency Injection:** [`get_it`](https://pub.dev/packages/get_it)
- **Networking:** [`dio`](https://pub.dev/packages/dio)
- **Routing:** [`go_router`](https://pub.dev/packages/go_router)
- **Maps:** [`flutter_map`](https://pub.dev/packages/flutter_map) & [`latlong2`](https://pub.dev/packages/latlong2)
- **UI/UX:** Material 3, Custom Themes (Light/Dark), [`shimmer`](https://pub.dev/packages/shimmer) for skeleton loaders.

---

## 📂 Architecture & Project Structure

The project follows a feature-first architecture approach to ensure scalability and maintainability.

```text
lib/
├── core/                   # Core functionalities (DI, themes, networking, utils)
│   ├── di/                 # Dependency Injection setup
│   └── theme/              # Theme definitions & ThemeCubit
├── features/               # Feature-driven modules
│   ├── auth/               # Authentication feature
│   ├── deliveries/         # Deliveries & orders management
│   ├── home/               # Home dashboard
│   ├── onboarding/         # Welcome & tutorial screens
│   ├── profile/            # User profile management
│   └── settings/           # App settings & preferences
└── main.dart               # Entry point of the application
```

---

## 🚀 Getting Started

Follow these steps to run the project locally.

### Prerequisites

- Flutter SDK
- Android Studio / Xcode or VS Code with Flutter extensions
- A connected device or emulator

### Installation

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd oran_delivery
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

---

## 🎨 Design System

The app utilizes **Material 3** with dynamic theming support:
- **Light Theme:** Clean, airy aesthetic with a distinctive Blue accent (`#1E88E5`).
- **Dark Theme:** High-contrast, sleek interface with a striking Neon Yellow accent (`#D4FF26`).

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

1. Fork the project.
2. Create your feature branch (`git checkout -b feature/AmazingFeature`).
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the branch (`git push origin feature/AmazingFeature`).
5. Open a Pull Request.

---

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.
