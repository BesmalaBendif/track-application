import 'package:flutter/material.dart';
import '../../core/widgets/app_drawer.dart';

class ProductionScreen extends StatefulWidget {
  const ProductionScreen({super.key});

  @override
  State<ProductionScreen> createState() =>
      _ProductionScreenState();
}

class _ProductionScreenState extends State<ProductionScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      drawer: const AppDrawer(),

      appBar: AppBar(
        title: const Text("Production"),

        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.translate),
          ),

          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(14),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                isDark ? Icons.dark_mode : Icons.light_mode,
              ),
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

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 1.15,

              children: const [
                ProductionCard(
                  title: "TODAY",
                  value: "540 t",
                  icon: Icons.factory_outlined,
                  color: Color(0xFF3B82F6),
                ),

                ProductionCard(
                  title: "WEEK",
                  value: "3.9k t",
                  icon: Icons.trending_up,
                  color: Color(0xFFF59E0B),
                ),

                ProductionCard(
                  title: "MONTH",
                  value: "14.9k t",
                  icon: Icons.layers_outlined,
                  color: Color(0xFF3B82F6),
                ),

                ProductionCard(
                  title: "AVG/DAY",
                  value: "495 t",
                  icon: Icons.factory,
                  color: Color(0xFF3B82F6),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
              ),

              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _tabButton("Daily", 0),
                  _tabButton("Weekly", 1),
                  _tabButton("Monthly", 2),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Container(
              width: double.infinity,
              height: 320,
              padding: const EdgeInsets.all(24),

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
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.end,
                      mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,

                      children: [
                        _bar(410),
                        _bar(500),
                        _bar(470),
                        _bar(550),
                        _bar(610),
                        _bar(530),
                        _bar(320),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Mon"),
                      Text("Tue"),
                      Text("Wed"),
                      Text("Thu"),
                      Text("Fri"),
                      Text("Sat"),
                      Text("Sun"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            _infoSection(
              context,
              title: "By machine",
              items: const [
                ["Jaw Crusher JC-450", "2,400 tons"],
                ["CAT 390F Excavator", "2,020 tons"],
                ["Cone Crusher CC-220", "1,640 tons"],
                ["Volvo A40G Hauler", "1,260 tons"],
              ],
            ),

            const SizedBox(height: 20),

            _infoSection(
              context,
              title: "By project",
              items: const [
                ["North Quarry Expansion", "12,400 tons"],
                ["Route 14 Aggregate Supply", "8,600 tons"],
                ["South Bypass Roadworks", "0 tons"],
                ["Industrial Park Foundations", "5,200 tons"],
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _tabButton(String text, int index) {
    final selected = selectedTab == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),

        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 10,
        ),

        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(14),

          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 6,
                  ),
                ]
              : [],
        ),

        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: selected
                ? Colors.black
                : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }

  Widget _bar(double height) {
    return Container(
      width: 28,
      height: height / 2,

      decoration: BoxDecoration(
        color: const Color(0xFF2563EB),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _infoSection(
    BuildContext context, {
    required String title,
    required List<List<String>> items,
  }) {
    return Container(
      width: double.infinity,
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
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 16),

              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item[0],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),

                  Text(
                    item[1],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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

class ProductionCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const ProductionCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),

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
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                    fontSize: 13,
                  ),
                ),
              ),

              CircleAvatar(
                radius: 18,
                backgroundColor: color.withOpacity(.12),

                child: Icon(
                  icon,
                  color: color,
                  size: 18,
                ),
              ),
            ],
          ),

          const Spacer(),

          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}