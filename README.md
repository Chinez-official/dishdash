# DishDash 🍳

A beautiful recipe discovery app built with Flutter that helps you find, save, and organize your favorite recipes.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)

## 📱 Screenshots

<p align="center">
  <img src="screenshots/home.png" width="200" alt="Home Screen"/>
  <img src="screenshots/search.png" width="200" alt="Search Screen"/>
  <img src="screenshots/recipe_detail.png" width="200" alt="Recipe Detail"/>
  <img src="screenshots/bookmarks.png" width="200" alt="Bookmarks"/>
</p>

## ✨ Features

### Recipe Discovery
- 🔍 **Smart Search** - Search recipes by name with debounced search and caching
- 🏠 **Home Feed** - Browse popular and trending recipes
- 📂 **Categories** - Filter recipes by food categories
- 🎲 **Random Recipe** - Discover new recipes with the random feature

### Organization
- 🔖 **Bookmarks** - Save your favorite recipes for quick access
- 📝 **Notes** - Add personal notes and ratings to recipes (1-5 stars)
- 🕐 **Recent Searches** - Quick access to your search history

### User Experience
- 🔐 **Authentication** - Sign in with email/password or Google
- 🎨 **Beautiful UI** - Modern, clean design with smooth animations
- ⚡ **Offline Support** - Cached data for seamless offline experience
- 📱 **Responsive** - Optimized for all screen sizes

## 🛠️ Tech Stack

- **Framework**: Flutter 3.7+
- **State Management**: Riverpod
- **Navigation**: Auto Route
- **Database**: Drift (SQLite)
- **Authentication**: Firebase Auth
- **Networking**: Dio
- **Dependency Injection**: GetIt + Injectable
- **Code Generation**: Freezed, JSON Serializable

## 📋 Requirements

- Flutter SDK 3.7.2 or higher
- Dart SDK 3.7.2 or higher
- Android Studio / VS Code
- Firebase account (for authentication)

## 🚀 Setup Instructions

### 1. Clone the repository
```bash
git clone https://github.com/yourusername/dishdash.git
cd dishdash/dishdash
```

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Firebase Setup
1. Create a new Firebase project at [Firebase Console](https://console.firebase.google.com)
2. Enable **Email/Password** and **Google Sign-In** authentication
3. Download `google-services.json` and place it in `android/app/`
4. For iOS, download `GoogleService-Info.plist` and add it to `ios/Runner/`

### 4. Generate code
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 5. Run the app
```bash
flutter run
```

## 📁 Project Structure

```
lib/
├── app/
│   ├── core/                        # Core functionality
│   │   ├── config/                  # App configuration & DI
│   │   ├── models/                  # Data models
│   │   ├── repositories/            # Data repositories
│   │   ├── routes/                  # Navigation routes
│   │   ├── services/                # API & storage services
│   │   └── usecases/                # Business logic
│   │
│   ├── features/                    # Feature modules
│   │   ├── auth/                    # Authentication
│   │   │   ├── notifiers/           # State management
│   │   │   ├── forgot_password/
│   │   │   ├── sign_in/
│   │   │   └── sign_up/
│   │   │
│   │   ├── bookmark/                # Saved recipes
│   │   │   ├── components/          # UI components
│   │   │   └── notifiers/           # State management
│   │   │
│   │   ├── home/                    # Home screen
│   │   │   ├── components/          # Recipe cards, sections
│   │   │   └── widgets/             # Reusable widgets
│   │   │
│   │   ├── notes/                   # Recipe notes
│   │   │   ├── components/          # Note cards, forms
│   │   │   └── notifiers/           # State management
│   │   │
│   │   ├── recipe_detail/           # Recipe details view
│   │   │   ├── components/          # Ingredients, steps
│   │   │   └── notifiers/           # State management
│   │   │
│   │   ├── search/                  # Search functionality
│   │   │   ├── components/          # Search results
│   │   │   └── notifiers/           # State management
│   │   │
│   │   ├── settings/                # App settings
│   │   │   └── components/          # Settings tiles, dialogs
│   │   │
│   │   └── splash/                  # Splash screen
│   │
│   └── shared/                      # Shared widgets & utilities
│
├── providers/                       # Riverpod providers
└── main.dart                        # App entry point
```

## 🔑 API

This app uses the [TheMealDB API](https://www.themealdb.com/api.php) for recipe data.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 👨‍💻 Author

Built with ❤️ using Flutter

---

⭐ Star this repo if you find it helpful!
