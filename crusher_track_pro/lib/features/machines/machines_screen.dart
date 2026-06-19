import 'package:flutter/material.dart';
import '../../core/widgets/app_drawer.dart';

class MachinesScreen extends StatelessWidget {
  const MachinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      drawer: const AppDrawer(),

      appBar: AppBar(
        title: const Text("Machines"),

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
          MachineCard(
            name: "Jaw Crusher JC-450",
            subtitle: "Primary crusher",
            fuel: "184 L",
            hours: "1240 h",
            status: "Running",
            statusColor: Colors.green,
          ),

          SizedBox(height: 16),

          MachineCard(
            name: "CAT 390F Excavator",
            subtitle: "Excavator",
            fuel: "220 L",
            hours: "980 h",
            status: "Running",
            statusColor: Colors.green,
          ),

          SizedBox(height: 16),

          MachineCard(
            name: "Cone Crusher CC-220",
            subtitle: "Secondary crusher",
            fuel: "0 L",
            hours: "0 h",
            status: "Maintenance",
            statusColor: Colors.orange,
          ),

          SizedBox(height: 16),

          MachineCard(
            name: "Volvo A40G Hauler",
            subtitle: "Hauler",
            fuel: "110 L",
            hours: "860 h",
            status: "Idle",
            statusColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}

class MachineCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final String fuel;
  final String hours;
  final String status;
  final Color statusColor;

  const MachineCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.fuel,
    required this.hours,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(28),

        border: Border.all(
          color: Colors.grey.shade300,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor:
                    const Color(0xFFE8F0FE),

                child: const Icon(
                  Icons.local_shipping_outlined,
                  color: Color(0xFF2563EB),
                ),
              ),

              const Spacer(),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),

                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius:
                      BorderRadius.circular(30),
                ),

                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 3,
                      backgroundColor: statusColor,
                    ),

                    const SizedBox(width: 6),

                    Text(
                      status,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Text(
            name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 22),

          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.local_gas_station_outlined,
                    size: 18,
                    color: Colors.grey.shade600,
                  ),

                  const SizedBox(width: 6),

                  Text(
                    fuel,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 40),

              Row(
                children: [
                  Icon(
                    Icons.access_time_outlined,
                    size: 18,
                    color: Colors.grey.shade600,
                  ),

                  const SizedBox(width: 6),

                  Text(
                    hours,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}