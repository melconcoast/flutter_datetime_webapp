# 🕐 TimeZone Hub - Flutter DateTime WebApp

A modern, responsive web application for managing and displaying multiple timezones with real-time weather integration. Built with Flutter for seamless cross-platform compatibility and deployed on GitHub Pages.

[![Live Demo](https://img.shields.io/badge/Live-Demo-brightgreen?style=for-the-badge&logo=github)](https://melconcoast.github.io/flutter_datetime_webapp/)
[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)

## ✨ Features

### 🌍 Timezone Management
- **Multiple timezone display** with beautiful card-based layout
- **Real-time updates** every second across all timezone cards
- **Add/Remove timezones** with intuitive search functionality
- **Analog and Digital clocks** - toggle between clock types
- **Daytime/Nighttime themes** - automatic visual distinction

### 🎨 Customization & Themes  
- **Dark/Light theme support** with smooth transitions
- **Responsive layouts** - Grid view (desktop) and List view (mobile)
- **Flexible date formats** - DD/MM/YYYY, MM/DD/YYYY, YYYY-MM-DD
- **Time format options** - 12-hour and 24-hour formats
- **Temperature units** - Celsius and Fahrenheit conversion
- **Settings persistence** - your preferences are automatically saved

### 🌤️ Weather Integration
- **Real-time weather data** powered by OpenWeather API
- **Temperature display** with automatic unit conversion  
- **Humidity information** for each timezone location
- **Weather-responsive UI** - cards adapt to day/night cycles

### 📱 User Experience
- **Responsive design** - works perfectly on desktop, tablet, and mobile
- **Smooth animations** and hover effects
- **Intuitive controls** with visual feedback
- **Accessibility features** built-in
- **Fast loading** with optimized Flutter web build

## 🚀 How to Use

### 🌐 Live Demo
Visit the **[Live Demo](https://melconcoast.github.io/flutter_datetime_webapp/)** to try the app instantly - no installation required!

### 📋 Basic Usage

1. **Adding Timezones**
   - Click the **+ (Plus)** floating action button
   - Search for your desired city or timezone
   - Select from the dropdown suggestions
   - The timezone card will appear immediately

2. **Customizing Display**
   - Click the **Settings (⚙️)** icon in the top-right corner
   - Toggle between **Analog and Digital** clock displays
   - Switch between **Light and Dark** themes
   - Choose your preferred **date format** (DD/MM/YYYY, MM/DD/YYYY, YYYY-MM-DD)
   - Select **12-hour or 24-hour** time format
   - Pick temperature units (**Celsius or Fahrenheit**)

3. **Managing Timezones**
   - **Remove timezone**: Click the **X** button on any timezone card
   - **View layouts**: Switch between Grid (desktop) and List (mobile) views
   - **Weather info**: Automatic temperature and humidity display

4. **Settings Persistence**
   - All your preferences are **automatically saved**
   - Timezones and settings persist across browser sessions

## 🛠️ Development Setup

### Prerequisites
- Flutter SDK (>=3.2.0)
- Dart SDK (>=3.0.0) 
- Chrome browser for web development

### Local Installation

1. **Clone the repository**:
```bash
git clone https://github.com/melconcoast/flutter_datetime_webapp.git
cd flutter_datetime_webapp
```

2. **Install dependencies**:
```bash
flutter pub get
```

3. **Run the application**:
```bash
flutter run -d chrome
```

4. **Build for production**:
```bash
flutter build web --release
```

## 🏗️ Architecture & Technology Stack

### Frontend Framework
- **Flutter Web** - Modern UI framework for beautiful, natively compiled applications
- **Dart** - Programming language optimized for client development

### State Management
- **Riverpod** - Robust, testable and scalable state management
- **AsyncValue** - Enhanced state handling for loading/error states

### Key Dependencies
- **`timezone`** - Accurate timezone calculations and conversions
- **`weather`** - OpenWeather API integration for real-time weather data
- **`shared_preferences`** - Local storage for settings persistence
- **`flex_color_scheme`** - Advanced theming and color schemes
- **`google_fonts`** - Beautiful typography with web font loading
- **`intl`** - Internationalization and date/time formatting

### Architecture Patterns
- **MVVM (Model-View-ViewModel)** - Clean separation of concerns
- **Provider Pattern** - Dependency injection and state management
- **Responsive Design** - Adaptive layouts for all screen sizes

### Project Structure
```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models and state classes
├── providers/                # Riverpod state management
├── services/                 # External APIs and data persistence
├── theme/                    # UI theming and styling
├── screens/                  # Main application screens
└── widgets/                  # Reusable UI components
```

## 📖 Documentation

Detailed documentation can be found in the `docs` folder:
- [Features Documentation](docs/features/README.md) - Complete feature overview
- [Architecture Documentation](docs/architecture/README.md) - Technical implementation details  
- [Setup Guide](docs/setup/README.md) - Development environment setup

## 📋 Requirements & Compatibility

- **Flutter SDK**: >=3.2.0 <4.0.0
- **Dart SDK**: >=3.0.0 <4.0.0
- **Web Browsers**: Chrome, Firefox, Safari, Edge
- **Platforms**: Web (Primary), iOS, Android, macOS, Windows, Linux

## GitHub Pages Deployment

This project is configured for automatic deployment to GitHub Pages using GitHub Actions.

### Setup Instructions

1. **Enable GitHub Pages**:
   - Go to your repository settings
   - Navigate to "Pages" section
   - Set source to "Deploy from a branch"
   - Select `gh-pages` branch as the source
   - Click Save

2. **Automatic Deployment**:
   - The app automatically deploys when you push to `main` or `master` branch
   - GitHub Actions will build and deploy the Flutter web app
   - Check the Actions tab for deployment status

3. **Manual Build** (if needed):
   ```bash
   flutter build web --release
   ```

### Live Demo

Once deployed, your app will be available at:
`https://melconcoast.github.io/flutter_datetime_webapp/`

### Build Configuration

- **Build Output**: `build/web/`
- **Deployment Branch**: `gh-pages`
- **GitHub Actions Workflow**: `.github/workflows/deploy.yml`

## 🤝 Contributing

We welcome contributions to TimeZone Hub! Here's how you can help:

### Development Workflow
1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

### Code Guidelines
- Follow **Flutter/Dart** style guidelines
- Add **tests** for new features
- Update **documentation** as needed
- Ensure **responsive design** compatibility
- Test across **multiple browsers**

### Reporting Issues
- Use GitHub Issues for bug reports and feature requests
- Provide detailed reproduction steps
- Include browser/device information
- Add screenshots when helpful

## 🐛 Troubleshooting

### Common Issues
- **App not loading**: Check browser console for JavaScript errors
- **Weather not showing**: Verify internet connection for API calls
- **Settings not saving**: Clear browser cache and reload
- **Timezone search empty**: Check network connectivity

### Development Issues
- **Flutter build fails**: Run `flutter clean && flutter pub get`
- **Hot reload not working**: Restart the development server
- **Web rendering issues**: Try different browsers or incognito mode

## 📝 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Krishna Vyas (melconcoast)**
- GitHub: [@melconcoast](https://github.com/melconcoast)
- Project: [TimeZone Hub](https://github.com/melconcoast/flutter_datetime_webapp)

## 🙏 Acknowledgments

- **Flutter Team** - For the amazing framework
- **OpenWeather** - For weather API services  
- **Timezone Database** - For accurate timezone data
- **GitHub Pages** - For free hosting
- **Claude Code** - For development assistance

---

⭐ **Star this repository** if you found it helpful!

🔗 **Live Demo**: [https://melconcoast.github.io/flutter_datetime_webapp/](https://melconcoast.github.io/flutter_datetime_webapp/)
