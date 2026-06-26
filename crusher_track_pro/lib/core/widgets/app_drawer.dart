import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2563EB),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.landscape_outlined,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(width: 12),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              "CrusherTrack",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),

                            Text(
                              "Industrial project management",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.cancel_outlined,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),
                  const Divider(),
                ],
              ),
            ),

            // Menu
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                ),
                children: [
                  _drawerItem(
                    context,
                    icon: Icons.dashboard_outlined,
                    title: "Dashboard",
                    route: '/dashboard',
                  ),

                  _drawerItem(
                    context,
                    icon:
                        Icons.business_center_outlined,
                    title: "Projects",
                    route: '/projects',
                  ),

                  _drawerItem(
                    context,
                    icon: Icons.factory_outlined,
                    title: "Production",
                    route: '/production',
                  ),

                  _drawerItem(
                    context,
                    icon:
                        Icons.local_shipping_outlined,
                    title: "Machines",
                    route: '/machines',
                  ),

                  _drawerItem(
                    context,
                    icon: Icons.people_outline,
                    title: "Employees",
                    route: '/employees',
                  ),

                  _drawerItem(
                    context,
                    icon: Icons.payments_outlined,
                    title: "Expenses",
                    route: '/expenses',
                  ),

                  _drawerItem(
                    context,
                    icon: Icons.bar_chart_outlined,
                    title: "Reports & Analytics",
                    route: '/reports',
                  ),

                  _drawerItem(
                    context,
                    icon:
                        Icons.notifications_none_outlined,
                    title: "Notifications",
                    route: '/notifications',
                  ),

                  _drawerItem(
                    context,
                    icon: Icons.person_outline,
                    title: "Profile",
                    route: '/profile',
                  ),

                  _drawerItem(
                    context,
                    icon: Icons.settings_outlined,
                    title: "Settings",
                    route: '/settings',
                  ),
                ],
              ),
            ),

            // Bottom Section
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              child: Column(
                children: [
                  const Divider(),

                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),

                    leading: const Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),

                    title: const Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
onTap: () {
  Navigator.pop(context);

  Navigator.pushNamedAndRemoveUntil(
    context,
    '/login', // or '/signin' depending on your route name
    (route) => false,
  );
},
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
  }) {
    // Detect current route
    final String currentRoute =
        ModalRoute.of(context)?.settings.name ?? '';

    final bool selected = currentRoute == route;

    return Container(
      margin: const EdgeInsets.only(bottom: 6),

      decoration: BoxDecoration(
        color: selected
            ? const Color(0xFFE8F0FE)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),

      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),

        leading: Icon(
          icon,
          color: selected
              ? const Color(0xFF2563EB)
              : Colors.grey.shade700,
        ),

        title: Text(
          title,
          style: TextStyle(
            color: selected
                ? const Color(0xFF2563EB)
                : Colors.grey.shade800,
            fontWeight: selected
                ? FontWeight.w600
                : FontWeight.normal,
          ),
        ),

        onTap: () {
          Navigator.pop(context);

          // Prevent reopening same page
          if (!selected) {
            Navigator.pushReplacementNamed(
              context,
              route,
            );
          }
        },
      ),
    );
  }
}