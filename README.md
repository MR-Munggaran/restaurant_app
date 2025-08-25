# Restaurant App

## Introduction
The Restaurant App is a mobile application built using the Flutter framework. It is designed to provide users with a complete restaurant listing experience, including details about each restaurant, customer reviews, search functionality, and the option to save favorites locally. The app communicates with an external API to fetch restaurant data and uses local storage to manage user favorites. The architecture leverages Provider for state management and incorporates testing for various app components.

## Features
- **Restaurant Listing:** Fetches and displays a list of available restaurants with essential details like name, city, rating, and a thumbnail image.
- **Restaurant Detail:** Displays comprehensive details for each restaurant including description, location, menus for foods and drinks, and an image gallery.
- **Review Management:** Allows users to post reviews and view customer reviews for each restaurant.
- **Search Functionality:** Provides an option to search restaurants by name, tapping into API search endpoints.
- **Local Favorites:** Uses a local SQLite database (via Sqflite) to store and retrieve users’ favorite restaurants.
- **Push Notifications:** Integrates local notifications to remind users and update them about restaurant highlights.
- **Theming:** Supports both light and dark themes with easy configuration options through a dedicated theme provider.

## Requirements
| Requirement            | Version / Details                                             |
|------------------------|---------------------------------------------------------------|
| Flutter SDK            | Flutter 2.0 or later                                          |
| Dart SDK               | Dart 2.12 or later                                            |
| Dependencies           | provider, http, sqflite, shared_preferences, flutter_local_notifications, and others as specified in pubspec.yaml |

## Installation
1. **Clone the Repository:**
   Use Git to clone the repository locally.
   ```
   git clone https://github.com/MR-Munggaran/restaurant_app.git
   ```
2. **Navigate to the Project Directory:**
   ```
   cd restaurant_app
   ```
3. **Install Dependencies:**
   Install the Flutter packages by running:
   ```
   flutter pub get
   ```
4. **Setup Emulators or Devices:**
   Ensure that you have a proper emulator or a physical device connected for running the app.

## Usage
- **Running the App:**
  Launch the app using:
  ```
  flutter run
  ```
- **Running Tests:**
  Execute the test suite to ensure everything is working as expected:
  ```
  flutter test
  ```
- **Project Structure Overview:**
  - The API services are defined in the `lib/data/api/api_services.dart` file.
  - Data models and response classes can be found in the `lib/data/model` folder.
  - State management is implemented using Providers in the `lib/provider` folder.
  - The user interface is built with reusable widgets in the `lib/widget` folder.
  - Local storage operations are handled in `lib/data/sql/local_database_service.dart`.

## Configuration
- **API Endpoint:**
  The app fetches restaurant-related data from the remote API at [https://restaurant-api.dicoding.dev](https://restaurant-api.dicoding.dev). This base URL is defined in the `ApiServices` class and can be modified if necessary.
- **Local Database:**
  The app uses a local SQLite database named `resto-app.db` (configured in the `LocalDatabaseService` file) to store favorite restaurant data.
- **Notifications:**
  Local notifications are configured using a dedicated service. Permissions are requested on startup, and notifications can be toggled via the settings screen.
- **Theme Customization:**
  Theme settings for light and dark modes are defined in the `RestaurantTheme` classes and managed via the `ThemeProvider`.
  
For additional customizations, review the specific provider and service files under the `lib/provider` and `lib/service` directories.

## Contributing
Contributions to the Restaurant App are warmly welcomed. Follow these steps:
- **Fork the Repository:** Create your fork and clone your fork locally.
- **Create a Feature Branch:** Generate a branch specific to your feature or bug fix:
  ```
  git checkout -b feature/name-of-feature
  ```
- **Make Your Changes:** Ensure you follow the existing coding style and guidelines.
- **Test Your Changes:** Run the test suite (`flutter test`) to verify that your changes do not break any functionality.
- **Submit a Pull Request:** Push your changes to GitHub and create a pull request for review.

Please ensure that your contributions adhere to established coding patterns and include documentation where appropriate.

## License
The Restaurant App is open-sourced under the MIT License. The full license text is included in the repository and outlines the permissions and limitations regarding the use, distribution, and modification of the software.

```
MIT License

Copyright (c) [YEAR] [OWNER]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED.
```

Enjoy building and enhancing the Restaurant App!
