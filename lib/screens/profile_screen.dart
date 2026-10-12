import 'package:flutter/material.dart';

const String studentName = 'Tandika Winata';

const String studentId = '2415051080';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Profile',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 24),

          Center(
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person_rounded,
                    size: 56,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  studentName,
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 4),

                const Text(studentId),
              ],
            ),
          ),

          const SizedBox(height: 28),

          const Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  _ProfileRow(
                    icon: Icons.badge_outlined,
                    label: 'Name',
                    value: 'Tandika Winata',
                  ),

                  Divider(),

                  _ProfileRow(
                    icon: Icons.numbers_rounded,
                    label: 'NIM',
                    value: '2415051080',
                  ),

                  Divider(),

                  _ProfileRow(
                    icon: Icons.school_outlined,
                    label: 'Class',
                    value: 'PTI 5B',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ProfileRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon),

          const SizedBox(width: 14),

          Expanded(child: Text(label)),

          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
