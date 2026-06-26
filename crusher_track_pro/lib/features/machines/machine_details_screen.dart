import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/widgets/app_drawer.dart';

class MachineDetailsScreen extends StatelessWidget {
  const MachineDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark
        ? const Color(0xFF020817)
        : const Color(0xFFF8FAFC);

    final cardColor = isDark
        ? const Color(0xFF0F172A)
        : Colors.white;

    final titleColor = isDark
        ? Colors.white
        : const Color(0xFF0F172A);

    final subtitleColor = isDark
        ? Colors.white70
        : const Color(0xFF64748B);

    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: bgColor,

      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,

        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: titleColor),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),

        title: Text(
          "Jaw Crusher JC-450",
          style: TextStyle(
            color: titleColor,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.translate, color: titleColor),
          ),

          IconButton(
            onPressed: () {},
            icon: Icon(
              isDark
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
              color: titleColor,
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFFE2E8F0),
              child: Text(
                "KH",
                style: TextStyle(
                  color: Color(0xFF2563EB),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    size: 18,
                    color: subtitleColor,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "Machines",
                    style: TextStyle(
                      color: subtitleColor,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xFFE2E8F0),
                ),
              ),

              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Jaw Crusher JC-450",
                        style: TextStyle(
                          color: titleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "Primary crusher",
                        style: TextStyle(
                          color: subtitleColor,
                        ),
                      ),
                    ],
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),

                    decoration: BoxDecoration(
                      color: const Color(0xFFDFF7E8),
                      borderRadius:
                          BorderRadius.circular(30),
                    ),

                    child: const Text(
                      "● Running",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            GridView.count(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.1,

              children: [
                _metricCard(
                  cardColor,
                  titleColor,
                  subtitleColor,
                  "FUEL TODAY",
                  "184 L",
                  Icons.local_gas_station_outlined,
                  const Color(0xFFE8F0FE),
                ),

                _metricCard(
                  cardColor,
                  titleColor,
                  subtitleColor,
                  "WORKING\nHOURS",
                  "1240 h",
                  Icons.access_time,
                  const Color(0xFFFDE7C7),
                ),

                _metricCard(
                  cardColor,
                  titleColor,
                  subtitleColor,
                  "PRODUCTION\nCONTRIBUTION",
                  "32%",
                  Icons.factory_outlined,
                  const Color(0xFFE8F0FE),
                ),

                _metricCard(
                  cardColor,
                  titleColor,
                  subtitleColor,
                  "NEXT SERVICE",
                  "3 days",
                  Icons.build_outlined,
                  const Color(0xFFE8F0FE),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              height: 280,
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xFFE2E8F0),
                ),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    "Fuel today — 7 days",
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Expanded(
                    child: LineChart(
                      LineChartData(
                        minY: 0,
                        maxY: 260,

                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                        ),

                        borderData:
                            FlBorderData(show: false),

                        titlesData: FlTitlesData(
                          topTitles:
                              const AxisTitles(),
                          rightTitles:
                              const AxisTitles(),

                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,

                              getTitlesWidget:
                                  (value, meta) {
                                const days = [
                                  'D1',
                                  'D2',
                                  'D3',
                                  'D4',
                                  'D5',
                                  'D6',
                                  'D7'
                                ];

                                return Text(
                                  days[value.toInt()],
                                  style: TextStyle(
                                    color:
                                        subtitleColor,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        lineBarsData: [
                          LineChartBarData(
                            spots: const [
                              FlSpot(0, 180),
                              FlSpot(1, 210),
                              FlSpot(2, 195),
                              FlSpot(3, 220),
                              FlSpot(4, 240),
                              FlSpot(5, 215),
                              FlSpot(6, 185),
                            ],

                            color: Colors.orange,
                            barWidth: 3,
                            isCurved: true,

                            dotData: FlDotData(
                              show: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xFFE2E8F0),
                ),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    "Maintenance history",
                    style: TextStyle(
                      color: titleColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: 20),

                  _historyItem(
                    titleColor,
                    subtitleColor,
                    "500-hour service",
                    "2026-06-10 · Lucas B.",
                  ),

                  _historyItem(
                    titleColor,
                    subtitleColor,
                    "Filter replacement",
                    "2026-05-22 · Mechanic crew",
                  ),

                  _historyItem(
                    titleColor,
                    subtitleColor,
                    "Belt inspection",
                    "2026-04-08 · Marc D.",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _metricCard(
    Color cardColor,
    Color titleColor,
    Color subtitleColor,
    String title,
    String value,
    IconData icon,
    Color iconBg,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
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
                    color: const Color(0xFF64748B),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),

              CircleAvatar(
                radius: 16,
                backgroundColor: iconBg,
                child: Icon(
                  icon,
                  size: 18,
                  color: Colors.blue,
                ),
              ),
            ],
          ),

          const Spacer(),

          Text(
            value,
            style: TextStyle(
              color: titleColor,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget _historyItem(
    Color titleColor,
    Color subtitleColor,
    String title,
    String subtitle,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),

      child: Row(
        children: [
          const Icon(
            Icons.build_outlined,
            color: Colors.blue,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: titleColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Text(
                  subtitle,
                  style: TextStyle(
                    color: subtitleColor,
                    fontSize: 13,
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
