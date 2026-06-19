import 'package:flutter/material.dart';
import '../../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscurePassword = true;
  bool rememberMe = true;

  final emailController = TextEditingController(
    text: "manager@crushertrack.io",
  );

  final passwordController = TextEditingController(
    text: "password",
  );

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //--------------------------------------------------
                // TOP BAR
                //--------------------------------------------------

                Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2563EB),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.landscape_outlined,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(width: 10),

                    const Text(
                      "CrusherTrack",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const Spacer(),

                    PopupMenuButton<String>(
                      icon: const Icon(Icons.language),
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: "en",
                          child: Text("English"),
                        ),
                        PopupMenuItem(
                          value: "fr",
                          child: Text("Français"),
                        ),
                        PopupMenuItem(
                          value: "ar",
                          child: Text("العربية"),
                        ),
                      ],
                    ),

                    PopupMenuButton<String>(
                      icon: Icon(
                        isDark
                            ? Icons.dark_mode_outlined
                            : Icons.light_mode_outlined,
                      ),

                      onSelected: (value) {
                        if (value == "light") {
                          CrusherTrackApp.of(context)
                              .changeTheme(
                            ThemeMode.light,
                          );
                        }

                        if (value == "dark") {
                          CrusherTrackApp.of(context)
                              .changeTheme(
                            ThemeMode.dark,
                          );
                        }

                        if (value == "system") {
                          CrusherTrackApp.of(context)
                              .changeTheme(
                            ThemeMode.system,
                          );
                        }
                      },

                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: "light",
                          child: Row(
                            children: [
                              Icon(Icons.light_mode),
                              SizedBox(width: 10),
                              Text("Light"),
                            ],
                          ),
                        ),

                        PopupMenuItem(
                          value: "dark",
                          child: Row(
                            children: [
                              Icon(Icons.dark_mode),
                              SizedBox(width: 10),
                              Text("Dark"),
                            ],
                          ),
                        ),

                        PopupMenuItem(
                          value: "system",
                          child: Row(
                            children: [
                              Icon(Icons.desktop_windows),
                              SizedBox(width: 10),
                              Text("System"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 90),

                //--------------------------------------------------
                // TITLE
                //--------------------------------------------------

                const Text(
                  "Welcome back",
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Sign in to manage your projects",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 45),

                //--------------------------------------------------
                // EMAIL
                //--------------------------------------------------

                const Text(
                  "Email",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon:
                        const Icon(Icons.email_outlined),

                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                //--------------------------------------------------
                // PASSWORD
                //--------------------------------------------------

                const Text(
                  "Password",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,

                  decoration: InputDecoration(
                    prefixIcon:
                        const Icon(Icons.lock_outline),

                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),

                      onPressed: () {
                        setState(() {
                          obscurePassword =
                              !obscurePassword;
                        });
                      },
                    ),

                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                //--------------------------------------------------
                // REMEMBER ME
                //--------------------------------------------------

                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value!;
                        });
                      },
                    ),

                    const Text("Remember me"),

                    const Spacer(),

                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot password?",
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                //--------------------------------------------------
                // BUTTON
                //--------------------------------------------------

                SizedBox(
                  width: double.infinity,
                  height: 56,

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF2563EB),

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(14),
                      ),
                    ),

                    onPressed: () {},

                    child: const Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                //--------------------------------------------------
                // FOOTER
                //--------------------------------------------------

                const Center(
                  child: Text.rich(
                    TextSpan(
                      text: "Need access? ",
                      children: [
                        TextSpan(
                          text:
                              "Contact your administrator",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}