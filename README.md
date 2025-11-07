# Personal Finance Manager

A comprehensive Flutter application for managing personal finances, tracking transactions, setting budgets, and visualizing financial data. Built with clean architecture principles and modern Flutter best practices.

## 📱 Features

- **Dashboard**: Overview of financial health with charts and statistics
- **Transaction Management**: Add, view, and track income and expenses
- **Budget Planning**: Set and monitor monthly budgets by category
- **Dark/Light Theme**: Toggle between themes with persistent settings
- **Data Persistence**: Local storage using Hive database
- **Beautiful Charts**: Visualize financial data using FL Chart
- **Clean Navigation**: Bottom navigation with Go Router

## 📸 Screenshots

<div align="center">
  <table>
    <tr>
      <td align="center">
        <img src="assets/screenshots/Simulator Screenshot - iPhone 17 Pro Max - 2025-11-07 at 11.09.20.png" alt="Dashboard" width="250" height="540"/>
        <br />
        <b>Dashboard</b>
      </td>
      <td align="center">
        <img src="assets/screenshots/Simulator Screenshot - iPhone 17 Pro Max - 2025-11-07 at 11.09.30.png" alt="Settings" width="250" height="540"/>
        <br />
        <b>Settings</b>
      </td>
    </tr>
    <tr>
      <td align="center">
        <img src="assets/screenshots/Simulator Screenshot - iPhone 17 Pro Max - 2025-11-07 at 11.10.17.png" alt="Budget" width="250" height="540"/>
        <br />
        <b>Budget</b>
      </td>
      <td align="center">
        <img src="assets/screenshots/Simulator Screenshot - iPhone 17 Pro Max - 2025-11-07 at 11.10.36.png" alt="Transactions" width="250" height="540"/>
        <br />
        <b>Transactions</b>
      </td>
    </tr>
  </table>
</div>

## 🏗️ Architecture

This project follows **Clean Architecture** principles with the following structure:

```
lib/
├── core/                     # Core functionality shared across features
│   ├── constant/            # App-wide constants
│   ├── cubit/              # Global state management (App Theme)
│   ├── error/              # Error handling
│   ├── model/              # Data models (Transaction, Budget)
│   ├── service/            # Services (Hive, SharedPreferences)
│   ├── theme/              # App themes (Light/Dark)
│   ├── usecase/            # Base use case classes
│   └── widget/             # Reusable widgets
├── features/               # Feature modules
│   ├── dashboard/         
│   │   ├── data/          # Data sources and repositories
│   │   ├── domain/        # Business logic and entities
│   │   └── presentation/  # UI (screens, widgets, BLoC)
│   ├── transaction/       # Transaction management feature
│   ├── budget/            # Budget management feature
│   └── settings/          # App settings
├── depedencies.dart       # Dependency injection setup
├── main.dart              # App entry point
├── router.dart            # Navigation configuration
└── shell_scaffold.dart    # Main app scaffold with navigation
```

## 🛠️ Tech Stack

### Core Dependencies
- **Flutter SDK**: ^3.9.2
- **Dart**: ^3.9.2

### State Management & Architecture
- **flutter_bloc**: ^9.1.1 - State management using BLoC pattern
- **get_it**: ^9.0.5 - Dependency injection
- **fpdart**: ^1.2.0 - Functional programming utilities

### Navigation
- **go_router**: ^17.0.0 - Declarative routing

### Data Persistence
- **hive**: ^2.2.3 - Lightweight NoSQL database
- **hive_flutter**: ^1.1.0 - Hive integration for Flutter
- **shared_preferences**: ^2.5.3 - Key-value storage for settings

### UI & Visualization
- **fl_chart**: ^1.1.1 - Beautiful charts and graphs
- **cupertino_icons**: ^1.0.8 - iOS style icons

### Utilities
- **uuid**: ^4.5.2 - Unique ID generation
- **intl**: ^0.20.1 - Internationalization and formatting

### Development Dependencies
- **build_runner**: ^2.4.13 - Code generation
- **hive_generator**: ^2.0.1 - Hive type adapter generation
- **flutter_lints**: ^6.0.0 - Recommended lints

## 🚀 Getting Started

### Prerequisites

Before running this project, ensure you have:
- **Flutter SDK** (3.9.2 or higher) installed
- **Dart SDK** (3.9.2 or higher)
- An IDE (VS Code, Android Studio, or IntelliJ)
- iOS Simulator / Android Emulator / Physical Device

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd kuvaka_tech
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code with build_runner** (IMPORTANT)
   
   This project uses Hive for local storage, which requires code generation for type adapters. You **must** run build_runner before running the app for the first time:

   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

   This command will generate:
   - `transaction.g.dart` - Type adapter for Transaction model
   - `budget.g.dart` - Type adapter for Budget model

   **Note**: The `--delete-conflicting-outputs` flag ensures that any existing generated files are replaced with new ones.

4. **Verify the generated files**
   
   Check that these files exist:
   - `lib/core/model/transaction.g.dart`
   - `lib/core/model/budget.g.dart`

5. **Run the app**
   ```bash
   flutter run
   ```

## 🔨 Development Commands

### Running build_runner in watch mode

If you're actively developing and modifying models, you can run build_runner in watch mode to automatically regenerate files when changes are detected:

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Clean and rebuild

If you encounter issues with generated files:

```bash
# Clean previous builds
flutter clean

# Get dependencies
flutter pub get

# Rebuild generated files
flutter pub run build_runner build --delete-conflicting-outputs
```

### Running tests

```bash
flutter test
```

### Code analysis

```bash
flutter analyze
```

### Format code

```bash
dart format lib/
```

## 📦 Build for Release

### Android APK

```bash
flutter build apk --release
```

### Android App Bundle (for Play Store)

```bash
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

### Web

```bash
flutter build web --release
```

### Windows

```bash
flutter build windows --release
```

### macOS

```bash
flutter build macos --release
```

### Linux

```bash
flutter build linux --release
```

## 🗂️ Data Models

### Transaction Model
- **id**: Unique identifier (UUID)
- **category**: Transaction category
- **amount**: Transaction amount
- **type**: Income or Expense
- **date**: Transaction date
- **note**: Optional note

### Budget Model
- **id**: Unique identifier (UUID)
- **category**: Budget category
- **limit**: Budget limit amount
- **spent**: Amount spent
- **month**: Month (1-12)
- **year**: Year (YYYY)

## 🎨 Theming

The app supports both light and dark themes:
- Theme preference is persisted using SharedPreferences
- Toggle theme from the Settings screen
- Automatic theme switching based on system settings (optional)

## 🧪 Testing

The project includes test setup in the `test/` directory.

## 📝 Code Generation Details

This project uses **build_runner** with **hive_generator** to automatically generate type adapters for Hive database models. 

### Why is build_runner needed?

Hive requires type adapters to serialize and deserialize custom objects. Instead of writing these adapters manually, we use code generation:

1. Annotate models with `@HiveType()` and `@HiveField()`
2. Add `part 'filename.g.dart';` directive
3. Run build_runner to generate the adapter code

### When to run build_runner?

- **First time setup**: After cloning the repository
- **After modifying models**: When you add/remove/modify any Hive model fields
- **After pulling changes**: If someone else modified the models
- **Build errors**: If you see errors about missing `.g.dart` files

## 🔧 Troubleshooting

### "FileSystemException: Cannot open file" or missing .g.dart files
**Solution**: Run `flutter pub run build_runner build --delete-conflicting-outputs`

### "MissingPluginException" or Hive errors
**Solution**: 
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Build errors after updating dependencies
**Solution**:
```bash
flutter pub upgrade
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request


## 👨‍💻 Author
Naresh Sharma
Created as part of the Kuvaka Tech assignment.
