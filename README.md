# Indian Health, Wellness & Psychology App

A comprehensive Flutter application for Ayurvedic health and wellness management with Prakriti analysis, personalized recommendations, and community features. Experience the perfect blend of ancient wisdom and modern technology.

##  Features

### Core Wellness Features
- **User Profile Management**: Complete health information tracking with automatic profile creation
- **Prakriti Analysis**: Interactive 8-question assessment to determine Ayurvedic constitution (Vata, Pitta, Kapha)
- **Personalized Diet Chart**: Custom nutrition recommendations based on your unique Prakriti
- **Daily Schedule**: Optimal routine suggestions tailored to your constitution
- **Meditation Center**: Guided breathing exercises with interactive animations
- **Yoga Practice**: Comprehensive poses and sequences with Sanskrit names
- **Health Tracker**: Daily progress tracking for water, sleep, exercise, and mood
- **Community Hub**: Social feed, wellness groups, and challenges
- **Admin Panel**: User management and follow-up tracking system

### Premium UI/UX Features
- **Sexy Animations**: Smooth transitions, elastic effects, and staggered animations
- **Glassmorphism Design**: Transparent cards with blur effects and gradient overlays
- **Dynamic Gradients**: Unique color themes for each screen (Green, Purple, Orange, Teal)
- **Interactive Elements**: Breathing animations, progress bars, and tap feedback
- **Hero Animations**: Seamless transitions between screens
- **Responsive Design**: Optimized for all screen sizes and platforms

## Screenshots

*Add screenshots of your app here*

## Getting Started

### Prerequisites
- Flutter SDK (>=3.8.1)
- Dart SDK
- Android Studio / VS Code
- Android/iOS device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd indian_health_wellness
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## Dependencies

- `flutter`: SDK framework
- `google_fonts`: Beautiful Poppins typography
- `shared_preferences`: Local data persistence
- `flutter_local_notifications`: Wellness reminders
- `intl`: Date and time formatting
- `cupertino_icons`: iOS-style icons
- `animations`: Smooth page transitions
- `lottie`: Advanced animations support

## App Structure

```
lib/
├── main.dart                      # App entry point with routing
├── screens/                       # All app screens
│   ├── splash_screen.dart         # Animated splash with logo
│   ├── home_screen.dart           # Main dashboard with features
│   ├── profile_screen.dart        # User profile management
│   ├── prakriti_screen.dart       # Constitution analysis
│   ├── diet_screen.dart           # Personalized nutrition
│   ├── schedule_screen.dart       # Daily routine planner
│   ├── meditation_screen.dart     # Breathing exercises
│   ├── yoga_screen.dart           # Poses and sequences
│   ├── health_tracker_screen.dart # Progress tracking
│   ├── community_screen.dart      # Social features
│   └── admin_screen.dart          # Management panel
├── models/                        # Data models
│   └── user_model.dart           # User data structure
├── utils/                         # Utilities
│   ├── constants.dart            # App constants
│   └── notification_service.dart # Push notifications
└── assets/                        # Images and icons
    ├── images/
    └── icons/
```

##  Key Features Explained

### Prakriti Analysis System
Interactive 8-question assessment with smooth animations:
- **Vata**: Air and Space elements (movement, creativity, quick thinking)
- **Pitta**: Fire and Water elements (metabolism, intelligence, leadership)
- **Kapha**: Earth and Water elements (structure, stability, calmness)
- **Results**: Detailed constitution analysis with personalized recommendations

### Wellness Ecosystem
**Meditation Center**:
- Interactive breathing exercises with pulsing animations
- Guided sessions: Morning Peace, Stress Relief, Sleep Meditation
- Play/pause controls with visual feedback

**Yoga Practice**:
- Complete pose library with Sanskrit names
- Difficulty-coded sequences (Easy/Medium/Hard)
- Sun Salutation, Morning Flow, Evening Relaxation

**Health Tracking**:
- Daily goals: Water (8 glasses), Sleep (8 hours), Exercise (30 min)
- Interactive counters with tap-to-add functionality
- Mood tracking with emoji slider
- Progress visualization with animated bars

**Community Features**:
- Social feed with user posts and interactions
- Wellness groups: Meditation Masters, Yoga Enthusiasts
- Challenges: 30-Day Meditation, Hydration Hero
- Progress tracking and leaderboards

### Personalized Recommendations
Based on Prakriti analysis:
- **Custom Diet Plans**: Foods to include/avoid by constitution
- **Meal Timing**: Optimal eating schedules
- **Daily Routines**: Time-specific wellness activities
- **Lifestyle Tips**: Constitution-specific advice

### Admin Dashboard
Comprehensive management with animated charts:
- User statistics and Prakriti distribution
- Progress tracking and follow-up scheduling
- Community engagement metrics
- Health goal completion rates

##  Customization

### Color Themes
Each screen has unique gradient themes in `lib/utils/constants.dart`:
```dart
// Wellness Green Theme
static const Color primaryColor = Color(0xFF2E7D32);
static const Color secondaryColor = Color(0xFF4CAF50);

// Screen-Specific Gradients
static const List<Color> meditationGradient = [Color(0xFF1A237E), Color(0xFF3F51B5)];
static const List<Color> yogaGradient = [Color(0xFFE65100), Color(0xFFFF9800)];
static const List<Color> trackerGradient = [Color(0xFF00695C), Color(0xFF00897B)];
```

### Animation Customization
```dart
// Modify animation durations
AnimationController(
  duration: const Duration(milliseconds: 1200), // Adjust timing
  curve: Curves.elasticOut, // Change animation curves
);
```

### Adding New Features
1. Create animated screen in `lib/screens/`
2. Add route with transitions in `main.dart`
3. Update home screen feature cards
4. Add navigation with Hero animations

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Performance & Compatibility

- **Platforms**: Android, iOS, Web, Desktop
- **Animations**: 60fps smooth transitions
- **Storage**: Efficient local data persistence
- **Memory**: Optimized for low-end devices
- **Offline**: Core features work without internet

## User Experience Highlights

- **Onboarding**: Automatic profile creation with welcome dialogs
- **Feedback**: Success animations and celebration dialogs
- **Navigation**: Intuitive flow between wellness features
- **Accessibility**: Screen reader support and high contrast
- **Responsiveness**: Adapts to all screen sizes seamlessly

## Support

For support, email support@indianhealthwellness.com or create an issue in this repository.

## Acknowledgments

- **Ayurvedic Wisdom**: Traditional Indian medicine and wellness practices
- **Flutter Community**: Excellent packages and development tools
- **Google Fonts**: Beautiful Poppins typography
- **Material Design 3**: Modern UI components and guidelines
- **Animation Libraries**: Smooth transitions and interactive effects  
OUTPUT:


![IMG-20251027-WA0003](https://github.com/user-attachments/assets/f76371f6-dff8-45db-b601-387b314b3815)
![IMG-20251027-WA0019](https://github.com/user-attachments/assets/4580ce14-58a2-4a45-98bd-3bacd81572c8)
![IMG-20251027-WA0018](https://github.com/user-attachments/assets/d1a13e67-045f-4d21-b37b-1e72ce760457)
![IMG-20251027-WA0017](https://github.com/user-attachments/assets/7c2d30fd-1b94-4419-a2bc-077d6dad609a)
![IMG-20251027-WA0016](https://github.com/user-attachments/assets/80ee43b3-0597-403e-b731-e23b8991370b)
![IMG-20251027-WA0015](https://github.com/user-attachments/assets/5124ef36-cc7e-4b6c-8442-d0b9470bb128)
![IMG-20251027-WA0014](https://github.com/user-attachments/assets/5af4ed56-acca-4214-9fd5-8568e3b3c62d)
![IMG-20251027-WA0013](https://github.com/user-attachments/assets/2ee10404-60d3-491e-aa10-8ff965e20185)
![IMG-20251027-WA0012](https://github.com/user-attachments/assets/39c67e0d-a64f-4fd4-875b-e774e1b7a72d)
![IMG-20251027-WA0011](https://github.com/user-attachments/assets/db1a534a-08fb-4703-8bbe-36e8e608d985)
![IMG-20251027-WA0010](https://github.com/user-attachments/assets/30f751b4-4d1c-4d1a-b011-6624e2f3f3f7)
![IMG-20251027-WA0009](https://github.com/user-attachments/assets/9856012c-9524-406b-9757-99e47f2f980d)
![IMG-20251027-WA0008](https://github.com/user-attachments/assets/30c255c8-206b-4089-a6f3-b11c29da5254)
![IMG-20251027-WA0007](https://github.com/user-attachments/assets/87c78646-76f5-4507-b95c-75525aaf75d8)
![IMG-20251027-WA0006](https://github.com/user-attachments/assets/e037b2aa-3a5d-44f1-b9a3-cd15f8e75c68)
![IMG-20251027-WA0005](https://github.com/user-attachments/assets/e7e93a1a-7b93-477b-a726-b3e255d5bd45)
![IMG-20251027-WA0004](https://github.com/user-attachments/assets/11bf6f4f-5731-4d9a-ae86-0e7f52dc4ae6)
