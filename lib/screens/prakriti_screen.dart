import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrakritiScreen extends StatefulWidget {
  const PrakritiScreen({super.key});

  @override
  State<PrakritiScreen> createState() => _PrakritiScreenState();
}

class _PrakritiScreenState extends State<PrakritiScreen> {
  int currentQuestion = 0;
  Map<String, int> scores = {'Vata': 0, 'Pitta': 0, 'Kapha': 0};
  String? result;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'How would you describe your body frame?',
      'options': [
        {'text': 'Thin, light build', 'type': 'Vata'},
        {'text': 'Medium build, muscular', 'type': 'Pitta'},
        {'text': 'Large, heavy build', 'type': 'Kapha'},
      ]
    },
    {
      'question': 'How is your appetite generally?',
      'options': [
        {'text': 'Variable, sometimes forget to eat', 'type': 'Vata'},
        {'text': 'Strong, get irritable when hungry', 'type': 'Pitta'},
        {'text': 'Steady, can skip meals easily', 'type': 'Kapha'},
      ]
    },
    {
      'question': 'How do you handle stress?',
      'options': [
        {'text': 'Get anxious and worried', 'type': 'Vata'},
        {'text': 'Get angry and frustrated', 'type': 'Pitta'},
        {'text': 'Remain calm and withdrawn', 'type': 'Kapha'},
      ]
    },
    {
      'question': 'What is your sleep pattern like?',
      'options': [
        {'text': 'Light sleeper, wake up easily', 'type': 'Vata'},
        {'text': 'Sound sleep, moderate duration', 'type': 'Pitta'},
        {'text': 'Deep sleep, need lots of sleep', 'type': 'Kapha'},
      ]
    },
    {
      'question': 'How is your energy level throughout the day?',
      'options': [
        {'text': 'Comes in bursts, then crashes', 'type': 'Vata'},
        {'text': 'Steady and intense', 'type': 'Pitta'},
        {'text': 'Steady but slow to start', 'type': 'Kapha'},
      ]
    },
    {
      'question': 'How do you learn new things?',
      'options': [
        {'text': 'Quick to learn, quick to forget', 'type': 'Vata'},
        {'text': 'Sharp intellect, good retention', 'type': 'Pitta'},
        {'text': 'Slow to learn, excellent retention', 'type': 'Kapha'},
      ]
    },
    {
      'question': 'What is your skin type?',
      'options': [
        {'text': 'Dry, rough, cool', 'type': 'Vata'},
        {'text': 'Warm, oily, sensitive', 'type': 'Pitta'},
        {'text': 'Thick, oily, cool', 'type': 'Kapha'},
      ]
    },
    {
      'question': 'How do you make decisions?',
      'options': [
        {'text': 'Quick but often change mind', 'type': 'Vata'},
        {'text': 'Quick and decisive', 'type': 'Pitta'},
        {'text': 'Slow and deliberate', 'type': 'Kapha'},
      ]
    },
  ];

  void _answerQuestion(String type) {
    setState(() {
      scores[type] = scores[type]! + 1;
      if (currentQuestion < questions.length - 1) {
        currentQuestion++;
      } else {
        _calculateResult();
      }
    });
  }

  void _calculateResult() {
    String dominantType = scores.entries.reduce((a, b) => a.value > b.value ? a : b).key;
    setState(() {
      result = dominantType;
    });
    _saveResult(dominantType);
  }

  _saveResult(String prakriti) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('prakriti', prakriti);
  }

  void _resetQuiz() {
    setState(() {
      currentQuestion = 0;
      scores = {'Vata': 0, 'Pitta': 0, 'Kapha': 0};
      result = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prakriti Analysis'),
        centerTitle: true,
      ),
      body: result == null ? _buildQuiz() : _buildResult(),
    );
  }

  Widget _buildQuiz() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          LinearProgressIndicator(
            value: (currentQuestion + 1) / questions.length,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
          ),
          const SizedBox(height: 20),
          Text(
            'Question ${currentQuestion + 1} of ${questions.length}',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    questions[currentQuestion]['question'],
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ...questions[currentQuestion]['options'].map<Widget>((option) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _answerQuestion(option['type']),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF2E7D32),
                            side: const BorderSide(color: Color(0xFF2E7D32)),
                            padding: const EdgeInsets.all(16),
                          ),
                          child: Text(
                            option['text'],
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResult() {
    Map<String, Map<String, String>> prakritiInfo = {
      'Vata': {
        'description': 'You have a Vata constitution. Vata governs movement and is associated with air and space elements.',
        'characteristics': 'Creative, energetic, quick thinking, but prone to anxiety and irregular routines.',
        'recommendations': 'Focus on warm, cooked foods, regular routines, and calming practices like yoga and meditation.',
      },
      'Pitta': {
        'description': 'You have a Pitta constitution. Pitta governs metabolism and is associated with fire and water elements.',
        'characteristics': 'Intelligent, focused, natural leader, but can be irritable and prone to anger.',
        'recommendations': 'Eat cooling foods, avoid excessive heat, practice moderation, and engage in calming activities.',
      },
      'Kapha': {
        'description': 'You have a Kapha constitution. Kapha governs structure and is associated with earth and water elements.',
        'characteristics': 'Calm, stable, compassionate, but can be sluggish and resistant to change.',
        'recommendations': 'Eat light, spicy foods, engage in regular exercise, and maintain an active lifestyle.',
      },
    };

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
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
                  Icons.psychology,
                  size: 60,
                  color: Colors.white,
                ),
                const SizedBox(height: 16),
                Text(
                  'Your Prakriti: $result',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E7D32),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    prakritiInfo[result!]!['description']!,
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Characteristics',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E7D32),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    prakritiInfo[result!]!['characteristics']!,
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Recommendations',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E7D32),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    prakritiInfo[result!]!['recommendations']!,
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _resetQuiz,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[600],
                  ),
                  child: const Text('Retake Quiz'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/diet'),
                  child: const Text('View Diet Plan'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}