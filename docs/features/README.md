# Features Documentation

## Core Features

### 1. Timezone Management
- **Location**: `lib/widgets/timezone_selection_dialog.dart`
- **Description**: Allows users to add and remove timezones
- **Key Components**:
  - Timezone search functionality
  - Real-time timezone preview
  - Current time display for selected timezone

### 2. Clock Display
- **Location**: `lib/widgets/clock_widget.dart`
- **Description**: Displays both analog and digital clocks
- **Features**:
  - Analog clock face (optional)
  - Digital time display
  - Day/Night indication
  - Weather information
  - Temperature display

### 3. Settings Management
- **Location**: `lib/widgets/settings_drawer.dart`
- **Description**: Handles user preferences and customization
- **Settings**:
  - Dark/Light theme toggle
  - Time format (12/24 hour)
  - Date format selection
  - Temperature unit selection
  - View type (Grid/List)
  - Analog clock visibility
  - Seconds display toggle

### 4. Weather Integration
- **Location**: `lib/services/weather_service.dart`
- **Description**: Provides weather information for each timezone
- **Features**:
  - Temperature display
  - Weather conditions
  - Temperature unit conversion

### 5. Layout Management
- **Location**: 
  - `lib/widgets/timezone_grid_view.dart`
  - `lib/widgets/timezone_list_view.dart`
- **Description**: Responsive layout handling
- **Features**:
  - Grid view for larger screens
  - List view for mobile devices
  - Adaptive sizing