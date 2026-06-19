import 'package:flutter/material.dart';
import '../../core/widgets/app_drawer.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isDark
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
      backgroundColor: backgroundColor,
      drawer: const AppDrawer(),

      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,

        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: titleColor,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),

        title: Text(
          "Notifications",
          style: TextStyle(
            color: titleColor,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.translate,
              color: titleColor,
            ),
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
            Text(
              "TODAY",
              style: TextStyle(
                color: subtitleColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 14),

            NotificationCard(
              cardColor: cardColor,
              titleColor: titleColor,
              subtitleColor: subtitleColor,
              icon: Icons.warning_amber_rounded,
              iconBg: const Color(0xFFFEE2E2),
              iconColor: Colors.red,
              title: "Machine CC-220 stopped",
              subtitle:
                  "Hydraulic pressure dropped below threshold.",
              time: "2h ago",
            ),

            const SizedBox(height: 14),

            NotificationCard(
              cardColor: cardColor,
              titleColor: titleColor,
              subtitleColor: subtitleColor,
              icon: Icons.build,
              iconBg: const Color(0xFFFDE7C7),
              iconColor: const Color(0xFF8A5A00),
              title: "Scheduled service: JC-450",
              subtitle:
                  "500-hour service due in 3 days.",
              time: "5h ago",
            ),

            const SizedBox(height: 28),

            Text(
              "EARLIER",
              style: TextStyle(
                color: subtitleColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 14),

            NotificationCard(
              cardColor: cardColor,
              titleColor: titleColor,
              subtitleColor: subtitleColor,
              icon: Icons.emoji_events_outlined,
              iconBg: const Color(0xFFDFF7E8),
              iconColor: Colors.green,
              title: "North Quarry hit 12,000 tons",
              subtitle:
                  "Project p1 reached monthly milestone.",
              time: "Yesterday",
            ),

            const SizedBox(height: 14),

            NotificationCard(
              cardColor: cardColor,
              titleColor: titleColor,
              subtitleColor: subtitleColor,
              icon: Icons.attach_money,
              iconBg: const Color(0xFFFDE7C7),
              iconColor: const Color(0xFF8A5A00),
              title: "Fuel spend +18% this week",
              subtitle:
                  "Review consumption on Site A.",
              time: "2 days ago",
            ),

            const SizedBox(height: 14),

            NotificationCard(
              cardColor: cardColor,
              titleColor: titleColor,
              subtitleColor: subtitleColor,
              icon: Icons.build_circle_outlined,
              iconBg: const Color(0xFFFDE7C7),
              iconColor: const Color(0xFF8A5A00),
              title: "Dozer D85 inspection overdue",
              subtitle:
                  "Last inspection 45 days ago.",
              time: "3 days ago",
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final Color cardColor;
  final Color titleColor;
  final Color subtitleColor;

  final IconData icon;
  final Color iconBg;
  final Color iconColor;

  final String title;
  final String subtitle;
  final String time;

  const NotificationCard({
    super.key,
    required this.cardColor,
    required this.titleColor,
    required this.subtitleColor,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),

        border: Border.all(
          color: const Color(0xFFE2E8F0),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: iconBg,

            child: Icon(
              icon,
              color: iconColor,
              size: 22,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  subtitle,
                  style: TextStyle(
                    color: subtitleColor,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  time,
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