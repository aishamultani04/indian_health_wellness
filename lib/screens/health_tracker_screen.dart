import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HealthTrackerScreen extends StatefulWidget {
  const HealthTrackerScreen({super.key});

  @override
  State<HealthTrackerScreen> createState() => _HealthTrackerScreenState();
}

class _HealthTrackerScreenState extends State<HealthTrackerScreen> {
  int _waterGlasses = 0;
  int _sleepHours = 0;
  int _exerciseMinutes = 0;
  int _meditationMinutes = 0;
  double _moodRating = 5.0;

  @override
  void initState() {
    super.initState();
    _loadTodayData();
  }

  _loadTodayData() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toString().split(' ')[0];
    
    setState(() {
      _waterGlasses = prefs.getInt('water_$today') ?? 0;
      _sleepHours = prefs.getInt('sleep_$today') ?? 0;
      _exerciseMinutes = prefs.getInt('exercise_$today') ?? 0;
      _meditationMinutes = prefs.getInt('meditation_$today') ?? 0;
      _moodRating = prefs.getDouble('mood_$today') ?? 5.0;
    });
  }

  _saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toString().split(' ')[0];
    
    if (value is int) {
      await prefs.setInt('${key}_$today', value);
    } else if (value is double) {
      await prefs.setDouble('${key}_$today', value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Health Tracker'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF00695C),
              Color(0xFF00897B),
              Color(0xFF26A69A),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
          child: Column(
            children: [
              _buildDailyGoals(),
              const SizedBox(height: 20),
              _buildTrackers(),
              const SizedBox(height: 20),
              _buildMoodTracker(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDailyGoals() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Today\'s Progress',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          _buildProgressItem('Water', _waterGlasses, 8, 'glasses', Icons.local_drink),
          _buildProgressItem('Sleep', _sleepHours, 8, 'hours', Icons.bedtime),
          _buildProgressItem('Exercise', _exerciseMinutes, 30, 'minutes', Icons.fitness_center),
          _buildProgressItem('Meditation', _meditationMinutes, 15, 'minutes', Icons.self_improvement),
        ],
      ),
    );
  }

  Widget _buildProgressItem(String title, int current, int goal, String unit, IconData icon) {
    double progress = current / goal;
    if (progress > 1.0) progress = 1.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Text(
                '$current/$goal $unit',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(
              progress >= 1.0 ? Colors.green : Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackers() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildTrackerCard('Water', _waterGlasses, Icons.local_drink, () {
              setState(() => _waterGlasses++);
              _saveData('water', _waterGlasses);
            })),
            const SizedBox(width: 16),
            Expanded(child: _buildTrackerCard('Sleep', _sleepHours, Icons.bedtime, () {
              setState(() => _sleepHours++);
              _saveData('sleep', _sleepHours);
            })),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildTrackerCard('Exercise', _exerciseMinutes, Icons.fitness_center, () {
              setState(() => _exerciseMinutes += 15);
              _saveData('exercise', _exerciseMinutes);
            })),
            const SizedBox(width: 16),
            Expanded(child: _buildTrackerCard('Meditation', _meditationMinutes, Icons.self_improvement, () {
              setState(() => _meditationMinutes += 5);
              _saveData('meditation', _meditationMinutes);
            })),
          ],
        ),
      ],
    );
  }

  Widget _buildTrackerCard(String title, int value, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(height: 12),
            Text(
              value.toString(),
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Tap to add',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodTracker() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How are you feeling today?',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildMoodIcon('😢', 1.0),
              _buildMoodIcon('😕', 2.0),
              _buildMoodIcon('😐', 3.0),
              _buildMoodIcon('🙂', 4.0),
              _buildMoodIcon('😊', 5.0),
            ],
          ),
          const SizedBox(height: 16),
          Slider(
            value: _moodRating,
            min: 1.0,
            max: 5.0,
            divisions: 4,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withOpacity(0.3),
            onChanged: (value) {
              setState(() => _moodRating = value);
              _saveData('mood', _moodRating);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMoodIcon(String emoji, double value) {
    bool isSelected = _moodRating == value;
    return GestureDetector(
      onTap: () {
        setState(() => _moodRating = value);
        _saveData('mood', _moodRating);
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.3) : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            emoji,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}