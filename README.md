# Flutter Info Panel

A responsive, animated info panel component for Flutter that displays information in a compact bottom sheet with a collapsible sidebar navigation.

![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)
![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android%20%7C%20Web%20%7C%20Desktop-lightgrey.svg)

## Demo

https://github.com/user-attachments/assets/dvvx6j

[![Watch Demo Video](https://img.shields.io/badge/Watch-Demo%20Video-red?style=for-the-badge&logo=youtube)](https://streamable.com/dvvx6j)

https://github.com/user-attachments/assets/dvvx6j

<video src="demo.mp4" width="300" controls></video>

**[▶️ Watch Full Demo on Streamable](https://streamable.com/dvvx6j)**

## What is this?

This is a reusable UI component I created to solve a common problem: **displaying help content, documentation, or onboarding information in a clean, organized way**.

Instead of building info screens from scratch every time, this component provides:

- A **bottom sheet** that slides up from the bottom of the screen
- A **collapsible sidebar** to navigate between different topics
- **Text descriptions** for each topic
- **Embedded YouTube videos** for tutorial content
- **Smooth animations** for a polished user experience
- **Responsive design** that works on all screen sizes

## Features

### Core Features
- ✅ Draggable bottom sheet (can resize by dragging)
- ✅ Collapsible sidebar navigation
- ✅ Animated content transitions
- ✅ YouTube video embedding
- ✅ Responsive layout (adapts to screen size)

### Animations
- ✅ Staggered entrance animations for sidebar items
- ✅ Smooth content fade/slide transitions
- ✅ Press effects on interactive elements
- ✅ Animated sidebar expand/collapse
- ✅ Icon scale animations

### Design
- ✅ Clean, modern UI
- ✅ Customizable colors per topic
- ✅ Gradient accents
- ✅ Shadow effects for depth

## Installation

1. Clone this repository:
```bash
git clone https://github.com/YOUR_USERNAME/FlutterInfoWindow.git
cd FlutterInfoWindow/frontend
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Dependencies

This project uses minimal external dependencies:

```yaml
dependencies:
  flutter:
    sdk: flutter
  youtube_player_flutter: ^9.1.1  # For video embedding
```

## Usage

### Basic Usage

To show an info panel, use the `InfoCardButton` helper class:

```dart
import 'flip_card_info_overlay.dart';

// Show the info panel
InfoCardButton.showHomeInfoPanel(context);
```

### Creating Your Own Info Panel

1. Define your info items:

```dart
final List<Info> myInfoList = [
  Info(
    title: "Getting Started",
    icon: Icons.rocket_launch,
    color: Colors.blue,
    description: "Learn how to get started with our app...",
    videoUrl: "https://www.youtube.com/watch?v=VIDEO_ID", // Optional
  ),
  Info(
    title: "Features",
    icon: Icons.star,
    color: Colors.orange,
    description: "Explore all the features available...",
  ),
  // Add more items...
];
```

2. Create a panel widget:

```dart
class MyInfoPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _BaseInfoPanel(
      title: 'My Guide',
      infoList: myInfoList,
    );
  }
}
```

3. Show it:

```dart
showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  builder: (context) => MyInfoPanel(),
);
```

## Project Structure

```
frontend/
├── lib/
│   ├── main.dart                    # App entry point and home screen
│   └── flip_card_info_overlay.dart  # Info panel component
├── pubspec.yaml                     # Dependencies
└── ...
```

## Key Components

### `Info` Class
Holds data for each info item:
- `title` - Display name
- `icon` - Icon to show
- `color` - Theme color for the item
- `description` - Text content
- `videoUrl` - Optional YouTube video URL

### `_BaseInfoPanel`
The main panel widget that handles:
- Bottom sheet behavior
- Sidebar navigation
- Content display
- State management

### `_AnimatedSidebarItem`
Individual sidebar items with:
- Entrance animations
- Press effects
- Selected state styling

### `_AnimatedDetails`
Content area with:
- Animated transitions between items
- Video embedding
- Description display

## Customization

### Colors
Each info item can have its own color. The color is used for:
- Icon background
- Accent elements
- Video progress indicator

### Animations
Animation durations and curves can be modified in the widget classes. Key values:
- Sidebar entrance: 300-550ms (staggered)
- Content transition: 400ms
- Press effects: 100-150ms

### Layout
The sidebar width is calculated as a percentage of screen width:
- Collapsed: 60px fixed
- Expanded: 45% of screen width

## Use Cases

This component is useful for:

- **Help screens** - Show users how to use your app
- **Onboarding** - Guide new users through features
- **Documentation** - Display in-app documentation
- **Settings info** - Explain what each setting does
- **Feature tours** - Showcase app capabilities
- **Learning apps** - Present educational content with videos

## Contributing

Contributions are welcome! Feel free to:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

MIT License - feel free to use this in your own projects.

## Support This Project

If you find this useful:

⭐ **Give this repo a star** - It helps others discover this project!

👤 **Follow me on GitHub** - I'll be sharing more useful Flutter components and projects!

[![GitHub stars](https://img.shields.io/github/stars/YOUR_USERNAME/FlutterInfoWindow?style=social)](https://github.com/YOUR_USERNAME/FlutterInfoWindow)
[![GitHub followers](https://img.shields.io/github/followers/YOUR_USERNAME?style=social)](https://github.com/YOUR_USERNAME)

## Author

Built by [Your Name]

---

### ⭐ Star this repo if you found it helpful!

### 👉 Follow me for more Flutter projects!
