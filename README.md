# 🌸 Flowery Store App

A beautiful and modern Flutter e-commerce application for a flower store, built with clean architecture, BLoC state management, and RESTful API integration.

## ✨ Features

- 🛍️ **Product Catalog** - Browse and explore flower collections
- 🛒 **Shopping Cart** - Add/remove items with real-time updates
- 💳 **Checkout** - Seamless payment integration
- 🌍 **Localization** - Multi-language support (i18n)
- 📱 **Responsive Design** - Optimized for all screen sizes
- 🎨 **Beautiful UI** - Modern and intuitive user interface
- 🔐 **Secure API Communication** - Retrofit with interceptors
- 📊 **State Management** - BLoC pattern for predictable state updates
- 🚀 **Performance Optimized** - Lazy loading and efficient caching

## 📸 Screenshots

Add your app screenshots here to showcase the UI:

```markdown
| Home Screen | Product Details | Cart |
|:-:|:-:|:-:|
| ![Home](https://via.placeholder.com/200x400?text=Home+Screen) | ![Product](https://via.placeholder.com/200x400?text=Product+Details) | ![Cart](https://via.placeholder.com/200x400?text=Shopping+Cart) |
```

## 🛠️ Tech Stack

### Core Framework
- **Flutter** - UI framework for cross-platform development
- **Dart** - Programming language (v3.10.4+)

### State Management & Architecture
- **BLoC** (v9.1.0) - Business Logic Component pattern
- **Flutter BLoC** (v9.1.1) - BLoC library for Flutter

### Networking & Serialization
- **Retrofit** (v4.9.1) - Type-safe HTTP client
- **JSON Serializable** (v6.10.0) - JSON serialization code generation
- **JSON Annotation** (v4.9.0) - JSON annotation support

### Dependency Injection
- **Injectable** (v2.7.1+4) - Service locator with code generation
- **Injectable Generator** - Code generation for service locator

### UI & UX
- **Flutter Screenutil** (v5.9.3) - Responsive UI scaling
- **Flutter SVG** (v2.2.3) - SVG image support
- **Flutter Animate** (v4.5.2) - Advanced animations
- **Cupertino Icons** (v1.0.8) - iOS-style icons
- **Flutter Native Splash** (v2.4.7) - Custom splash screens

### Internationalization
- **Flutter Localizations** - Built-in localization support
- **Intl** - Internationalization and localization
- **L10n Configuration** - Multi-language setup

### Development Tools
- **Flutter Launcher Icons** (v0.14.4) - App icon generation
- **Logger** (v2.6.0) - Logging utility
- **Flutter Lints** (v6.0.0) - Code style recommendations
- **Build Runner** - Code generation runner

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point
├── core/                        # Core functionality
│   ├── constants/              # App constants
│   ├── config/                 # Configuration
│   └── utils/                  # Utility functions
├── data/                        # Data layer
│   ├── models/                 # Data models
│   ├── datasources/            # API datasources
│   ├── repositories/           # Repository implementations
│   └── api/                    # Retrofit API clients
├── domain/                      # Domain layer
│   ├── entities/               # Business entities
│   ├── repositories/           # Repository interfaces
│   └── usecases/               # Business logic usecases
├── presentation/               # Presentation layer
│   ├── screens/                # UI screens
│   ├── widgets/                # Reusable widgets
│   ├── bloc/                   # BLoC providers
│   └── styles/                 # Themes and styles
└── generated/                   # Generated files (l10n, etc)
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (v3.10.4 or higher)
- Dart SDK (v3.10.4 or higher)
- Android Studio / Xcode / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/IslamRamzy444/flowery_store_app.git
   cd flowery_store_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Generate localization files**
   ```bash
   flutter gen-l10n
   ```

5. **Generate launcher icons** (optional)
   ```bash
   flutter pub run flutter_launcher_icons
   ```

6. **Run the app**
   ```bash
   flutter run
   ```

## 📦 Build & Deployment

### Android Build

```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# App Bundle
flutter build appbundle --release
```

### iOS Build

```bash
# iOS app
flutter build ios --release
```

## 🔧 Development Workflows

### Adding a New Feature

1. Create a new BLoC for state management
2. Define entities in the domain layer
3. Create repository interface in domain
4. Implement repository in data layer
5. Create API datasource if needed
6. Add UI screens in presentation layer

### Code Generation

```bash
# Run build runner in watch mode
flutter pub run build_runner watch

# Run once
flutter pub run build_runner build
```

### Running Tests

```bash
flutter test
```

## 🌐 Localization

The app supports multiple languages through i18n configuration. Language files are generated automatically.

To add a new language:
1. Edit `lib/l10n/arb` files
2. Run: `flutter gen-l10n`

## 📱 Supported Platforms

- ✅ Android (API 16+)
- ✅ iOS (11.0+)
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🐛 Known Issues

- See [Issues](https://github.com/IslamRamzy444/flowery_store_app/issues) for current problems

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### PR Guidelines

When submitting a PR, please:
- Include clear description of changes
- Add screenshots/demos for UI changes
- Reference any related issues
- Follow the existing code style

**Example PR Description:**

```markdown
## Description
Added user authentication feature with email and password login.

## Changes
- ✅ Login screen UI
- ✅ Authentication BLoC
- ✅ API integration
- ✅ Error handling

## Screenshots
[Login Screen](image_url)
[Success Screen](image_url)

## Checklist
- [ ] Code follows project style
- [ ] Tests added/updated
- [ ] Documentation updated
```

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👨‍💻 Author

- **Islam Ramzy** - [GitHub Profile](https://github.com/IslamRamzy444)

## 📞 Support

For support, email support@flowerystore.app or open an [Issue](https://github.com/IslamRamzy444/flowery_store_app/issues)

## 🔗 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [BLoC Pattern Guide](https://bloclibrary.dev/)
- [Dart Documentation](https://dart.dev/guides)
- [Clean Architecture in Flutter](https://resocoder.com/flutter-clean-architecture)

---

**⭐ If you find this project helpful, please consider giving it a star!**
