import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Community'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Feed', icon: Icon(Icons.home)),
            Tab(text: 'Groups', icon: Icon(Icons.group)),
            Tab(text: 'Challenges', icon: Icon(Icons.emoji_events)),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6A1B9A),
              Color(0xFF8E24AA),
              Color(0xFFAB47BC),
            ],
          ),
        ),
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildFeed(),
            _buildGroups(),
            _buildChallenges(),
          ],
        ),
      ),
    );
  }

  Widget _buildFeed() {
    final posts = [
      {
        'user': 'Sarah M.',
        'avatar': 'S',
        'time': '2h ago',
        'content': 'Just completed my 30-day meditation challenge! Feeling more centered and peaceful than ever. 🧘‍♀️',
        'likes': 24,
        'comments': 8,
      },
      {
        'user': 'Raj P.',
        'avatar': 'R',
        'time': '4h ago',
        'content': 'Morning yoga session done! The sun salutation sequence really energized me for the day ahead. ☀️',
        'likes': 18,
        'comments': 5,
      },
      {
        'user': 'Maya K.',
        'avatar': 'M',
        'time': '6h ago',
        'content': 'Trying out the Kapha diet recommendations from my Prakriti analysis. Already feeling lighter and more energetic! 🥗',
        'likes': 32,
        'comments': 12,
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 140, 16, 16),
      child: Column(
        children: posts.map((post) => _buildPostCard(post)).toList(),
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.3),
                child: Text(
                  post['avatar'],
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post['user'],
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      post['time'],
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            post['content'],
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildActionButton(Icons.favorite_border, post['likes'].toString()),
              const SizedBox(width: 20),
              _buildActionButton(Icons.comment_outlined, post['comments'].toString()),
              const SizedBox(width: 20),
              _buildActionButton(Icons.share_outlined, 'Share'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white.withOpacity(0.8), size: 20),
        const SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildGroups() {
    final groups = [
      {'name': 'Meditation Masters', 'members': '1.2k', 'description': 'Daily meditation practice and mindfulness'},
      {'name': 'Yoga Enthusiasts', 'members': '856', 'description': 'Share poses, sequences, and yoga wisdom'},
      {'name': 'Ayurvedic Living', 'members': '2.1k', 'description': 'Traditional wellness and natural healing'},
      {'name': 'Healthy Recipes', 'members': '3.4k', 'description': 'Nutritious meals for every Prakriti type'},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 140, 16, 16),
      child: Column(
        children: groups.map((group) => _buildGroupCard(group)).toList(),
      ),
    );
  }

  Widget _buildGroupCard(Map<String, String> group) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(Icons.group, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group['name']!,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${group['members']} members',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  group['description']!,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.2),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: const Text('Join'),
          ),
        ],
      ),
    );
  }

  Widget _buildChallenges() {
    final challenges = [
      {
        'title': '30-Day Meditation',
        'description': 'Meditate for 10 minutes daily',
        'participants': '234',
        'daysLeft': '12',
        'progress': 0.6,
      },
      {
        'title': 'Hydration Hero',
        'description': 'Drink 8 glasses of water daily',
        'participants': '567',
        'daysLeft': '5',
        'progress': 0.8,
      },
      {
        'title': 'Morning Yoga',
        'description': 'Practice yoga every morning',
        'participants': '189',
        'daysLeft': '18',
        'progress': 0.4,
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 140, 16, 16),
      child: Column(
        children: challenges.map((challenge) => _buildChallengeCard(challenge)).toList(),
      ),
    );
  }

  Widget _buildChallengeCard(Map<String, dynamic> challenge) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                challenge['title'],
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${challenge['daysLeft']} days left',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            challenge['description'],
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${challenge['participants']} participants',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: challenge['progress'],
            backgroundColor: Colors.white.withOpacity(0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.2),
                foregroundColor: Colors.white,
              ),
              child: const Text('Join Challenge'),
            ),
          ),
        ],
      ),
    );
  }
}