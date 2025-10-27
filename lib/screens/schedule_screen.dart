import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  String? prakriti;

  @override
  void initState() {
    super.initState();
    _loadPrakriti();
  }

  _loadPrakriti() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prakriti = prefs.getString('prakriti');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Schedule'),
        centerTitle: true,
      ),
      body: prakriti == null ? _buildNoPrakriti() : _buildSchedule(),
    );
  }

  Widget _buildNoPrakriti() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.schedule,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 20),
            Text(
              'Complete Prakriti Analysis First',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'To get personalized daily routine recommendations, please complete your Prakriti analysis first.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/prakriti'),
              child: const Text('Take Prakriti Analysis'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSchedule() {
    Map<String, List<Map<String, dynamic>>> schedules = {
      'Vata': [
        {'time': '6:00 AM', 'activity': 'Wake up', 'icon': Icons.wb_sunny, 'description': 'Rise early for stability'},
        {'time': '6:15 AM', 'activity': 'Warm water with ginger', 'icon': Icons.local_drink, 'description': 'Stimulate digestion'},
        {'time': '6:30 AM', 'activity': 'Oil massage (Abhyanga)', 'icon': Icons.spa, 'description': 'Nourish and ground the body'},
        {'time': '7:00 AM', 'activity': 'Gentle yoga/stretching', 'icon': Icons.self_improvement, 'description': 'Calm and center'},
        {'time': '8:00 AM', 'activity': 'Warm breakfast', 'icon': Icons.restaurant, 'description': 'Nourishing, cooked foods'},
        {'time': '12:00 PM', 'activity': 'Lunch', 'icon': Icons.lunch_dining, 'description': 'Main meal of the day'},
        {'time': '2:00 PM', 'activity': 'Light walk', 'icon': Icons.directions_walk, 'description': 'Aid digestion'},
        {'time': '6:00 PM', 'activity': 'Meditation', 'icon': Icons.psychology, 'description': 'Calm the mind'},
        {'time': '7:00 PM', 'activity': 'Light dinner', 'icon': Icons.dinner_dining, 'description': 'Easy to digest'},
        {'time': '9:30 PM', 'activity': 'Bedtime routine', 'icon': Icons.bedtime, 'description': 'Regular sleep schedule'},
      ],
      'Pitta': [
        {'time': '6:00 AM', 'activity': 'Wake up', 'icon': Icons.wb_sunny, 'description': 'Early rise for coolness'},
        {'time': '6:15 AM', 'activity': 'Cool water', 'icon': Icons.local_drink, 'description': 'Hydrate and cool'},
        {'time': '6:30 AM', 'activity': 'Coconut oil massage', 'icon': Icons.spa, 'description': 'Cooling oil massage'},
        {'time': '7:00 AM', 'activity': 'Moderate exercise', 'icon': Icons.fitness_center, 'description': 'Avoid overheating'},
        {'time': '8:00 AM', 'activity': 'Cool breakfast', 'icon': Icons.restaurant, 'description': 'Fresh, cooling foods'},
        {'time': '12:00 PM', 'activity': 'Main lunch', 'icon': Icons.lunch_dining, 'description': 'Largest meal when digestion is strong'},
        {'time': '2:00 PM', 'activity': 'Rest/shade time', 'icon': Icons.beach_access, 'description': 'Avoid midday heat'},
        {'time': '6:00 PM', 'activity': 'Cooling pranayama', 'icon': Icons.air, 'description': 'Breathing exercises'},
        {'time': '7:00 PM', 'activity': 'Light dinner', 'icon': Icons.dinner_dining, 'description': 'Cool, light foods'},
        {'time': '10:00 PM', 'activity': 'Sleep', 'icon': Icons.bedtime, 'description': 'Adequate rest'},
      ],
      'Kapha': [
        {'time': '5:30 AM', 'activity': 'Early wake up', 'icon': Icons.wb_sunny, 'description': 'Rise before sunrise'},
        {'time': '5:45 AM', 'activity': 'Warm water with honey', 'icon': Icons.local_drink, 'description': 'Stimulate metabolism'},
        {'time': '6:00 AM', 'activity': 'Vigorous exercise', 'icon': Icons.fitness_center, 'description': 'Energize the body'},
        {'time': '7:00 AM', 'activity': 'Dry brushing', 'icon': Icons.brush, 'description': 'Stimulate circulation'},
        {'time': '8:00 AM', 'activity': 'Light breakfast', 'icon': Icons.restaurant, 'description': 'Warm, spiced foods'},
        {'time': '12:00 PM', 'activity': 'Main meal', 'icon': Icons.lunch_dining, 'description': 'Largest meal of the day'},
        {'time': '2:00 PM', 'activity': 'Active work/walk', 'icon': Icons.directions_walk, 'description': 'Stay active'},
        {'time': '6:00 PM', 'activity': 'Energizing pranayama', 'icon': Icons.air, 'description': 'Stimulating breathwork'},
        {'time': '7:00 PM', 'activity': 'Light dinner', 'icon': Icons.dinner_dining, 'description': 'Warm, light foods'},
        {'time': '9:00 PM', 'activity': 'Early bedtime', 'icon': Icons.bedtime, 'description': 'Avoid oversleeping'},
      ],
    };

    final schedule = schedules[prakriti!]!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.schedule,
                  size: 50,
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                Text(
                  '$prakriti Daily Routine',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Personalized schedule for optimal wellness',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ...schedule.map((item) => _buildScheduleItem(
            item['time'],
            item['activity'],
            item['icon'],
            item['description'],
          )).toList(),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Important Notes',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E7D32),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildNote('Consistency is key - try to follow the same schedule daily'),
                  _buildNote('Adjust timing based on your work and family commitments'),
                  _buildNote('Listen to your body and modify as needed'),
                  _buildNote('Seasonal adjustments may be necessary'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(String time, String activity, IconData icon, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32).withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF2E7D32),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        time,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2E7D32),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        activity,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNote(String note) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info, color: Colors.blue, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              note,
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}