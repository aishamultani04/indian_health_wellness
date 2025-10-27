import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> followUps = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadData();
  }

  _loadData() {
    // Mock data for demonstration
    setState(() {
      users = [
        {
          'name': 'John Doe',
          'age': '28',
          'prakriti': 'Vata',
          'lastActive': '2024-01-15',
          'progress': 75,
        },
        {
          'name': 'Jane Smith',
          'age': '34',
          'prakriti': 'Pitta',
          'lastActive': '2024-01-14',
          'progress': 60,
        },
        {
          'name': 'Mike Johnson',
          'age': '42',
          'prakriti': 'Kapha',
          'lastActive': '2024-01-13',
          'progress': 85,
        },
      ];

      followUps = [
        {
          'user': 'John Doe',
          'type': 'Diet Compliance',
          'status': 'Pending',
          'date': '2024-01-16',
          'priority': 'High',
        },
        {
          'user': 'Jane Smith',
          'type': 'Exercise Routine',
          'status': 'Completed',
          'date': '2024-01-15',
          'priority': 'Medium',
        },
        {
          'user': 'Mike Johnson',
          'type': 'Meditation Practice',
          'status': 'In Progress',
          'date': '2024-01-14',
          'priority': 'Low',
        },
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Dashboard', icon: Icon(Icons.dashboard)),
            Tab(text: 'Users', icon: Icon(Icons.people)),
            Tab(text: 'Follow-ups', icon: Icon(Icons.follow_the_signs)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDashboard(),
          _buildUsers(),
          _buildFollowUps(),
        ],
      ),
    );
  }

  Widget _buildDashboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overview',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildStatCard('Total Users', '${users.length}', Icons.people, Colors.blue)),
              const SizedBox(width: 16),
              Expanded(child: _buildStatCard('Active Today', '2', Icons.online_prediction, Colors.green)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildStatCard('Pending Follow-ups', '1', Icons.pending_actions, Colors.orange)),
              const SizedBox(width: 16),
              Expanded(child: _buildStatCard('Completed Today', '1', Icons.check_circle, Colors.purple)),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Prakriti Distribution',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildPrakritiBar('Vata', 1, users.length, Colors.blue),
                  const SizedBox(height: 12),
                  _buildPrakritiBar('Pitta', 1, users.length, Colors.red),
                  const SizedBox(height: 12),
                  _buildPrakritiBar('Kapha', 1, users.length, Colors.green),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsers() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFF2E7D32),
              child: Text(
                user['name'][0],
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              user['name'],
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Age: ${user['age']} | Prakriti: ${user['prakriti']}'),
                const SizedBox(height: 4),
                Text('Last Active: ${user['lastActive']}'),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: user['progress'] / 100,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
                ),
                const SizedBox(height: 4),
                Text('Progress: ${user['progress']}%', style: const TextStyle(fontSize: 12)),
              ],
            ),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'view', child: Text('View Details')),
                const PopupMenuItem(value: 'followup', child: Text('Schedule Follow-up')),
                const PopupMenuItem(value: 'message', child: Text('Send Message')),
              ],
              onSelected: (value) {
                _handleUserAction(value, user);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildFollowUps() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: followUps.length,
      itemBuilder: (context, index) {
        final followUp = followUps[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Icon(
              _getFollowUpIcon(followUp['type']),
              color: _getPriorityColor(followUp['priority']),
            ),
            title: Text(
              followUp['type'],
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('User: ${followUp['user']}'),
                Text('Date: ${followUp['date']}'),
                Text('Priority: ${followUp['priority']}'),
              ],
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getStatusColor(followUp['status']),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                followUp['status'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onTap: () => _handleFollowUpAction(followUp),
          ),
        );
      },
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrakritiBar(String prakriti, int count, int total, Color color) {
    double percentage = count / total;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(prakriti, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            Text('$count users', style: GoogleFonts.poppins(fontSize: 12)),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: percentage,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ],
    );
  }

  IconData _getFollowUpIcon(String type) {
    switch (type) {
      case 'Diet Compliance':
        return Icons.restaurant_menu;
      case 'Exercise Routine':
        return Icons.fitness_center;
      case 'Meditation Practice':
        return Icons.self_improvement;
      default:
        return Icons.assignment;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'In Progress':
        return Colors.orange;
      case 'Pending':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _handleUserAction(String action, Map<String, dynamic> user) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$action for ${user['name']}')),
    );
  }

  void _handleFollowUpAction(Map<String, dynamic> followUp) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Follow-up Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: ${followUp['type']}'),
            Text('User: ${followUp['user']}'),
            Text('Status: ${followUp['status']}'),
            Text('Priority: ${followUp['priority']}'),
            Text('Date: ${followUp['date']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Follow-up updated')),
              );
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}