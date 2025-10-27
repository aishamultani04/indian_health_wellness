import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
  
  static Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings();
    
    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    
    await _notifications.initialize(settings);
  }
  
  static Future<void> scheduleWellnessReminder() async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'wellness_channel',
      'Wellness Reminders',
      channelDescription: 'Daily wellness and health reminders',
      importance: Importance.high,
      priority: Priority.high,
    );
    
    const NotificationDetails details = NotificationDetails(android: androidDetails);
    
    await _notifications.show(
      0,
      'Wellness Reminder',
      'Time for your daily wellness check-in!',
      details,
    );
  }
  
  static Future<void> scheduleMealReminder(String mealType, String time) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'meal_channel',
      'Meal Reminders',
      channelDescription: 'Meal time reminders based on your Prakriti',
      importance: Importance.high,
      priority: Priority.high,
    );
    
    const NotificationDetails details = NotificationDetails(android: androidDetails);
    
    await _notifications.show(
      1,
      'Meal Reminder',
      'Time for your $mealType at $time',
      details,
    );
  }
}