import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YogaScreen extends StatefulWidget {
  const YogaScreen({super.key});

  @override
  State<YogaScreen> createState() => _YogaScreenState();
}

class _YogaScreenState extends State<YogaScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _animations = List.generate(4, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(index * 0.2, 1.0, curve: Curves.easeOutBack),
        ),
      );
    });
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Yoga Practice'),
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
              Color(0xFFE65100),
              Color(0xFFFF9800),
              Color(0xFFFFC107),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
          child: Column(
            children: [
              _buildYogaSequences(),
              const SizedBox(height: 30),
              _buildYogaPoses(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildYogaSequences() {
    final sequences = [
      {'name': 'Sun Salutation', 'duration': '15 min', 'level': 'Beginner', 'poses': 12},
      {'name': 'Morning Flow', 'duration': '20 min', 'level': 'Intermediate', 'poses': 18},
      {'name': 'Evening Relaxation', 'duration': '25 min', 'level': 'All Levels', 'poses': 15},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Yoga Sequences',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        ...sequences.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, dynamic> sequence = entry.value;
          
          return AnimatedBuilder(
            animation: _animations[index % _animations.length],
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, 50 * (1 - _animations[index % _animations.length].value)),
                child: Opacity(
                  opacity: _animations[index % _animations.length].value,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              sequence['name'],
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                sequence['level'],
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(Icons.access_time, color: Colors.white.withOpacity(0.8), size: 16),
                            const SizedBox(width: 8),
                            Text(
                              sequence['duration'],
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Icon(Icons.fitness_center, color: Colors.white.withOpacity(0.8), size: 16),
                            const SizedBox(width: 8),
                            Text(
                              '${sequence['poses']} poses',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.2),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Start Practice'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ],
    );
  }

  Widget _buildYogaPoses() {
    final poses = [
      {'name': 'Mountain Pose', 'sanskrit': 'Tadasana', 'difficulty': 'Easy'},
      {'name': 'Downward Dog', 'sanskrit': 'Adho Mukha Svanasana', 'difficulty': 'Medium'},
      {'name': 'Warrior I', 'sanskrit': 'Virabhadrasana I', 'difficulty': 'Medium'},
      {'name': 'Tree Pose', 'sanskrit': 'Vrikshasana', 'difficulty': 'Easy'},
      {'name': 'Cobra Pose', 'sanskrit': 'Bhujangasana', 'difficulty': 'Easy'},
      {'name': 'Child\'s Pose', 'sanskrit': 'Balasana', 'difficulty': 'Easy'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Individual Poses',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemCount: poses.length,
          itemBuilder: (context, index) {
            final pose = poses[index];
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.accessibility_new,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    pose['name']!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pose['sanskrit']!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getDifficultyColor(pose['difficulty']!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      pose['difficulty']!,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Easy':
        return Colors.green.withOpacity(0.7);
      case 'Medium':
        return Colors.orange.withOpacity(0.7);
      case 'Hard':
        return Colors.red.withOpacity(0.7);
      default:
        return Colors.grey.withOpacity(0.7);
    }
  }
}