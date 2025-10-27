import 'package:flutter/material.dart';

class AppConstants {
  // Colors
  static const Color primaryColor = Color(0xFF2E7D32);
  static const Color secondaryColor = Color(0xFF4CAF50);
  static const Color accentColor = Color(0xFF81C784);
  
  // Prakriti Colors
  static const Color vataColor = Color(0xFF2196F3);
  static const Color pittaColor = Color(0xFFFF5722);
  static const Color kaphaColor = Color(0xFF4CAF50);
  
  // Text Styles
  static const TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );
  
  static const TextStyle subHeadingStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: primaryColor,
  );
  
  // Spacing
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  
  // Border Radius
  static const double defaultRadius = 12.0;
  static const double largeRadius = 16.0;
  
  // Prakriti Descriptions
  static const Map<String, String> prakritiDescriptions = {
    'Vata': 'Air and Space elements. Governs movement, breathing, and nervous system.',
    'Pitta': 'Fire and Water elements. Governs digestion, metabolism, and body temperature.',
    'Kapha': 'Earth and Water elements. Governs structure, immunity, and lubrication.',
  };
  
  // Wellness Tips
  static const List<String> wellnessTips = [
    'Start your day with warm water and lemon to balance your digestive fire.',
    'Practice deep breathing exercises to calm your mind and reduce stress.',
    'Eat according to your Prakriti for optimal health and energy.',
    'Maintain regular sleep schedule to support your natural rhythms.',
    'Include meditation in your daily routine for mental clarity.',
    'Choose seasonal foods to stay in harmony with nature.',
    'Practice gratitude daily to enhance your emotional well-being.',
    'Stay hydrated with warm water throughout the day.',
  ];
}