# Flutter DateTime WebApp

A responsive web application for managing and displaying multiple timezones with customizable settings and weather information.

## Features

- Multiple timezone display with analog and digital clocks
- Real-time updates for all timezones
- Weather information integration
- Dark/Light theme support
- Customizable date and time formats
- Responsive grid/list layout
- Settings persistence
- Temperature unit conversion (°C/°F)

## Getting Started

1. Clone the repository:
```bash
git clone https://github.com/yourusername/flutter_datetime_webapp.git
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the application:
```bash
flutter run -d chrome
```

## Documentation

Detailed documentation can be found in the `docs` folder:
- [Features Documentation](docs/features/README.md)
- [Architecture Documentation](docs/architecture/README.md)
- [Setup Guide](docs/setup/README.md)

## Requirements

- Flutter SDK: >=3.2.0 <4.0.0
- Dart SDK: >=3.0.0 <4.0.0
- Web browser for running the application

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
`https://yourusername.github.io/flutter_datetime_webapp/`

### Build Configuration

- **Build Output**: `build/web/`
- **Deployment Branch**: `gh-pages`
- **GitHub Actions Workflow**: `.github/workflows/deploy.yml`
