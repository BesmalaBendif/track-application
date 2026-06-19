import 'package:flutter/material.dart';
import '../../core/widgets/app_drawer.dart';

class EmployeesScreen extends StatelessWidget {
  const EmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      drawer: const AppDrawer(),

      appBar: AppBar(
        title: const Text("Employees"),

        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.translate),
          ),

          IconButton(
            onPressed: () {},
            icon: Icon(
              isDark
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(right: 14),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFFE3F2FD),
              child: Text(
                "KH",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: const [
          EmployeeCard(
            initials: "KH",
            name: "Karim Haddad",
            role: "Site Engineer",
            project: "North Quarry Expansion",
            status: "Active",
          ),

          SizedBox(height: 14),

          EmployeeCard(
            initials: "FZ",
            name: "Fatima Zahra",
            role: "Operations Manager",
            project: "North Quarry Expansion",
            status: "Active",
          ),

          SizedBox(height: 14),

          EmployeeCard(
            initials: "MD",
            name: "Marc Dubois",
            role: "Crusher Operator",
            project: "Route 14 Aggregate Supply",
            status: "Active",
          ),

          SizedBox(height: 14),

          EmployeeCard(
            initials: "AM",
            name: "Aisha Mansouri",
            role: "Safety Officer",
            project: "Route 14 Aggregate Supply",
            status: "Active",
          ),

          SizedBox(height: 14),

          EmployeeCard(
            initials: "LB",
            name: "Lucas Bernard",
            role: "Mechanic",
            project: "Industrial Park Foundations",
            status: "Active",
          ),

          SizedBox(height: 14),

          EmployeeCard(
            initials: "YN",
            name: "Yara Nouri",
            role: "Accountant",
            project: "Head Office",
            status: "Active",
          ),
        ],
      ),
    );
  }
}

class EmployeeCard extends StatelessWidget {
  final String initials;
  final String name;
  final String role;
  final String project;
  final String status;

  const EmployeeCard({
    super.key,
    required this.initials,
    required this.name,
    required this.role,
    required this.project,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(26),

        border: Border.all(
          color: Colors.grey.shade300,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFFE2E8F0),

            child: Text(
              initials,
              style: const TextStyle(
                color: Color(0xFF2563EB),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  role,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  project,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),

            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.12),
              borderRadius: BorderRadius.circular(30),
            ),

            child: Row(
              children: [
                const CircleAvatar(
                  radius: 3,
                  backgroundColor: Colors.green,
                ),

                const SizedBox(width: 6),

                Text(
                  status,
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}