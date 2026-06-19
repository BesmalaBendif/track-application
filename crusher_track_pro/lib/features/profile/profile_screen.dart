import 'package:flutter/material.dart';
import '../../core/widgets/app_drawer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
        title: const Text("Profile"),

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
          children: [
            // HEADER CARD

            Container(
              padding: const EdgeInsets.all(20),

              decoration: _cardDecoration(cardColor),

              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xFFE2E8F0),

                    child: Text(
                      "KH",
                      style: TextStyle(
                        color: Color(0xFF2563EB),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        Text(
                          "Karim Haddad",
                          style: TextStyle(
                            color: titleColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          "Operations Manager · CrusherTrack Inc.",
                          style: TextStyle(
                            color: subtitleColor,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // USER INFO

            _buildInfoCard(
              context,
              cardColor,
              titleColor,
              subtitleColor,
              "User information",
              const [
                ["Name", "Karim Haddad"],
                ["Email", "karim@crushertrack.io"],
                ["Phone", "+212 600 000 000"],
              ],
            ),

            const SizedBox(height: 18),

            // COMPANY INFO

            _buildInfoCard(
              context,
              cardColor,
              titleColor,
              subtitleColor,
              "Company information",
              const [
                ["Company", "CrusherTrack Inc."],
                ["License", "Enterprise"],
                ["Sites", "4 active"],
              ],
            ),

            const SizedBox(height: 18),

            // CHANGE PASSWORD

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: _cardDecoration(cardColor),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Text(
                    "Change password",
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    "Current password",
                    style: TextStyle(
                      color: titleColor,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextField(
                    obscureText: true,
                    decoration: _inputDecoration(),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    "New password",
                    style: TextStyle(
                      color: titleColor,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextField(
                    obscureText: true,
                    decoration: _inputDecoration(),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    "Confirm password",
                    style: TextStyle(
                      color: titleColor,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextField(
                    obscureText: true,
                    decoration: _inputDecoration(),
                  ),

                  const SizedBox(height: 24),

                  ElevatedButton(
                    onPressed: () {},

                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF2563EB),

                      foregroundColor: Colors.white,

                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 14,
                      ),

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(14),
                      ),
                    ),

                    child: const Text("Save"),
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

  Widget _buildInfoCard(
    BuildContext context,
    Color cardColor,
    Color titleColor,
    Color subtitleColor,
    String title,
    List<List<String>> rows,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),

      decoration: _cardDecoration(cardColor),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 24),

          ...rows.map(
            (row) => Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        row[0],
                        style: TextStyle(
                          color: subtitleColor,
                          fontSize: 15,
                        ),
                      ),
                    ),

                    Text(
                      row[1],
                      style: TextStyle(
                        color: titleColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Divider(
                  color: Colors.grey.shade300,
                ),

                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration(Color color) {
    return BoxDecoration(
      color: color,

      borderRadius: BorderRadius.circular(28),

      border: Border.all(
        color: const Color(0xFFE2E8F0),
      ),

      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.transparent,

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),

        borderSide: const BorderSide(
          color: Color(0xFFE2E8F0),
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),

        borderSide: const BorderSide(
          color: Color(0xFF2563EB),
          width: 1.5,
        ),
      ),
    );
  }
}