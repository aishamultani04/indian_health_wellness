import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DietScreen extends StatefulWidget {
  const DietScreen({super.key});

  @override
  State<DietScreen> createState() => _DietScreenState();
}

class _DietScreenState extends State<DietScreen> {
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
        title: const Text('Diet Chart'),
        centerTitle: true,
      ),
      body: prakriti == null ? _buildNoPrakriti() : _buildDietChart(),
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
              Icons.restaurant_menu,
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
              'To get personalized diet recommendations, please complete your Prakriti analysis first.',
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

  Widget _buildDietChart() {
    Map<String, Map<String, dynamic>> dietPlans = {
      'Vata': {
        'color': Colors.blue[100],
        'foods_to_eat': [
          'Warm, cooked foods',
          'Sweet fruits (bananas, dates)',
          'Cooked grains (rice, oats)',
          'Warm milk and ghee',
          'Nuts and seeds',
          'Root vegetables',
        ],
        'foods_to_avoid': [
          'Cold, raw foods',
          'Dry, light foods',
          'Bitter vegetables',
          'Carbonated drinks',
          'Excessive caffeine',
        ],
        'meal_timing': [
          'Breakfast: 7-8 AM',
          'Lunch: 12-1 PM',
          'Dinner: 6-7 PM',
          'Regular meal times important',
        ],
      },
      'Pitta': {
        'color': Colors.orange[100],
        'foods_to_eat': [
          'Cool, refreshing foods',
          'Sweet fruits (melons, grapes)',
          'Leafy greens',
          'Coconut water',
          'Cooling spices (coriander, fennel)',
          'Dairy products',
        ],
        'foods_to_avoid': [
          'Spicy, hot foods',
          'Sour fruits',
          'Excessive salt',
          'Alcohol',
          'Fried foods',
        ],
        'meal_timing': [
          'Breakfast: 7-8 AM',
          'Lunch: 12-1 PM (largest meal)',
          'Dinner: 6-7 PM (light)',
          'Avoid skipping meals',
        ],
      },
      'Kapha': {
        'color': Colors.green[100],
        'foods_to_eat': [
          'Light, warm foods',
          'Spicy foods',
          'Bitter vegetables',
          'Herbal teas',
          'Honey (in moderation)',
          'Legumes and beans',
        ],
        'foods_to_avoid': [
          'Heavy, oily foods',
          'Dairy products',
          'Sweet foods',
          'Cold drinks',
          'Excessive salt',
        ],
        'meal_timing': [
          'Light breakfast: 7-8 AM',
          'Main meal: 12-1 PM',
          'Light dinner: 6 PM',
          'Avoid late night eating',
        ],
      },
    };

    final plan = dietPlans[prakriti!]!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: plan['color'],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.restaurant_menu,
                  size: 50,
                  color: const Color(0xFF2E7D32),
                ),
                const SizedBox(height: 10),
                Text(
                  '$prakriti Diet Plan',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2E7D32),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildDietSection('Foods to Include', plan['foods_to_eat'], Icons.check_circle, Colors.green),
          const SizedBox(height: 16),
          _buildDietSection('Foods to Avoid', plan['foods_to_avoid'], Icons.cancel, Colors.red),
          const SizedBox(height: 16),
          _buildDietSection('Meal Timing', plan['meal_timing'], Icons.schedule, Colors.blue),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'General Tips',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E7D32),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildTip('Eat mindfully and chew food properly'),
                  _buildTip('Drink warm water throughout the day'),
                  _buildTip('Avoid eating when stressed or emotional'),
                  _buildTip('Listen to your body\'s hunger signals'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDietSection(String title, List<String> items, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2E7D32),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item,
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTip(String tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.lightbulb, color: Colors.amber, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              tip,
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}