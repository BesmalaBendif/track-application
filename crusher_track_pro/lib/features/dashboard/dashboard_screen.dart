import 'package:flutter/material.dart';
import '../../core/widgets/app_drawer.dart';
import '../../main.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      drawer: const AppDrawer(),

      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor,
        surfaceTintColor: Colors.transparent,

        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),

        title: Text(
          "Dashboard",
          style: TextStyle(
            color: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.color,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),

        actions: [
          PopupMenuButton<String>(
            icon: Icon(
              Icons.translate_outlined,
              color: Theme.of(context).iconTheme.color,
            ),
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'en',
                child: Text('English'),
              ),
              PopupMenuItem(
                value: 'fr',
                child: Text('Français'),
              ),
              PopupMenuItem(
                value: 'ar',
                child: Text('العربية'),
              ),
            ],
          ),

          PopupMenuButton<String>(
            icon: Icon(
              Icons.dark_mode_outlined,
              color: Theme.of(context).iconTheme.color,
            ),

            onSelected: (value) {
              if (value == 'light') {
                CrusherTrackApp.of(context)
                    .changeTheme(ThemeMode.light);
              }

              if (value == 'dark') {
                CrusherTrackApp.of(context)
                    .changeTheme(ThemeMode.dark);
              }

              if (value == 'system') {
                CrusherTrackApp.of(context)
                    .changeTheme(ThemeMode.system);
              }
            },

            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'light',
                child: Text('Light'),
              ),
              PopupMenuItem(
                value: 'dark',
                child: Text('Dark'),
              ),
              PopupMenuItem(
                value: 'system',
                child: Text('System'),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(
              right: 16,
              left: 8,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/profile',
                );
              },

              child: const CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFFE3F2FD),

                child: Text(
                  "KH",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
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
              "Operations Dashboard",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.color,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "Monitor projects, production and expenses",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 24),

            GridView.count(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),

              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,

              children: const [
                DashboardCard(
                  title: "Projects",
                  value: "12",
                  icon:
                      Icons.business_center_outlined,
                  color: Colors.blue,
                ),

                DashboardCard(
                  title: "Production",
                  value: "2,450 T",
                  icon: Icons.account_balance,
                  color: Colors.green,
                ),

                DashboardCard(
                  title: "Expenses",
                  value: "320K DZD",
                  icon: Icons.payments_outlined,
                  color: Colors.orange,
                ),

                DashboardCard(
                  title: "Machines",
                  value: "23",
                  icon: Icons
                      .precision_manufacturing,
                  color: Colors.purple,
                ),
              ],
            ),

            const SizedBox(height: 24),

            Text(
              "Project Overview",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.color,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              height: 220,
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,

                borderRadius:
                    BorderRadius.circular(20),

                boxShadow: [
                  BoxShadow(
                    color:
                        Colors.grey.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: Column(
                children: [
                  Text(
                    "Overall Progress",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.color,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,

                        child:
                            CircularProgressIndicator(
                          value: 0.72,
                          strokeWidth: 12,
                          backgroundColor:
                              Colors.grey.shade300,
                          color: Colors.green,
                        ),
                      ),

                      Text(
                        "72%",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight:
                              FontWeight.bold,
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              "Recent Activity",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.color,
              ),
            ),

            const SizedBox(height: 12),

            const ActivityTile(
              icon:
                  Icons.local_shipping_outlined,
              title: "Fuel expense added",
              subtitle:
                  "Loader 01 • 50,000 DZD",
            ),

            const ActivityTile(
              icon: Icons.account_balance,
              title: "Production recorded",
              subtitle: "Crusher A • 450 Tons",
            ),

            const ActivityTile(
              icon: Icons.engineering_outlined,
              title: "Employee checked in",
              subtitle: "Ahmed Benali",
            ),

            const ActivityTile(
              icon: Icons.build_outlined,
              title: "Maintenance completed",
              subtitle: "Excavator 02",
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const DashboardCard({
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

        borderRadius:
            BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor:
                color.withOpacity(0.15),

            child: Icon(
              icon,
              color: color,
            ),
          ),

          const Spacer(),

          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.color,
            ),
          ),

          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

class ActivityTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const ActivityTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness ==
            Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,

      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(16),
      ),

      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isDark
              ? Colors.blueGrey.shade800
              : Colors.blue.shade50,

          child: Icon(
            icon,
            color: Colors.blue,
          ),
        ),

        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}