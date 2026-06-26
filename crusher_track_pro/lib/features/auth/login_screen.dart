import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

import '../../providers/auth_provider.dart';

import '../dashboard/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  //--------------------------------------------------
  // Controllers
  //--------------------------------------------------

  final _formKey =
      GlobalKey<FormState>();

  final TextEditingController
      emailController =
      TextEditingController();

  final TextEditingController
      passwordController =
      TextEditingController();

  //--------------------------------------------------
  // Variables
  //--------------------------------------------------

  bool obscurePassword = true;

  //--------------------------------------------------
  // Init
  //--------------------------------------------------

  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      emailController.text =
          "admin@gmail.com";

      passwordController.text =
          "123456";
    }
  }

  //--------------------------------------------------
  // Dispose
  //--------------------------------------------------

  @override
  void dispose() {

    emailController.dispose();

    passwordController.dispose();

    super.dispose();
  }

  //--------------------------------------------------
  // Login
  //--------------------------------------------------

  Future<void> login() async {

    if (!_formKey.currentState!
        .validate()) {
      return;
    }

    final provider =
        Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    try {

      await provider.login(

        email:
            emailController.text.trim(),

        password:
            passwordController.text,

      );

      if (!mounted) return;

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (_) =>
              const DashboardScreen(),

        ),

      );

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          backgroundColor: Colors.red,

          content: Text(
            e.toString(),
          ),

        ),

      );
    }
  }

  //--------------------------------------------------
  // Build
  //--------------------------------------------------

  @override
  Widget build(BuildContext context) {

    final auth =
        context.watch<AuthProvider>();

    final isDark =
        Theme.of(context).brightness ==
            Brightness.dark;

    return Scaffold(

      body: SafeArea(

        child: Center(

          child: SingleChildScrollView(

            padding:
                const EdgeInsets.all(24),

            child: ConstrainedBox(

              constraints:
                  const BoxConstraints(
                maxWidth: 450,
              ),

              child: Form(

                key: _formKey,

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    //--------------------------------------------------
                    // Top Bar
                    //--------------------------------------------------

                    Row(

                      children: [

                        Container(

                          width: 48,

                          height: 48,

                          decoration:
                              BoxDecoration(

                            color:
                                Colors.blue,

                            borderRadius:
                                BorderRadius.circular(
                              14,
                            ),

                          ),

                          child:
                              const Icon(

                            Icons.precision_manufacturing,

                            color:
                                Colors.white,

                          ),

                        ),

                        const SizedBox(
                          width: 14,
                        ),

                        const Text(

                          "CrusherTrack",

                          style:
                              TextStyle(

                            fontSize:
                                22,

                            fontWeight:
                                FontWeight.bold,

                          ),

                        ),

                        const Spacer(),

                        PopupMenuButton<String>(

                          icon: const Icon(
                            Icons.language,
                          ),

                          itemBuilder:
                              (context) =>

                                  const [

                            PopupMenuItem(

                              value:
                                  "en",

                              child: Text(
                                  "English"),

                            ),

                            PopupMenuItem(

                              value:
                                  "fr",

                              child:
                                  Text(
                                "Français",
                              ),

                            ),

                            PopupMenuItem(

                              value:
                                  "ar",

                              child:
                                  Text(
                                "العربية",
                              ),

                            ),

                          ],

                        ),

                        PopupMenuButton<String>(

                          icon: Icon(

                            isDark
                                ? Icons.dark_mode
                                : Icons.light_mode,

                          ),

                          onSelected:
                              (value) {

                            if (value ==
                                "light") {

                              CrusherTrackApp.of(
                                      context)
                                  .changeTheme(

                                ThemeMode.light,

                              );

                            }

                            if (value ==
                                "dark") {

                              CrusherTrackApp.of(
                                      context)
                                  .changeTheme(

                                ThemeMode.dark,

                              );

                            }

                            if (value ==
                                "system") {

                              CrusherTrackApp.of(
                                      context)
                                  .changeTheme(

                                ThemeMode.system,

                              );

                            }

                          },

                          itemBuilder:
                              (context) =>

                                  const [

                            PopupMenuItem(

                              value:
                                  "light",

                              child:
                                  Text(
                                "Light",
                              ),

                            ),

                            PopupMenuItem(

                              value:
                                  "dark",

                              child:
                                  Text(
                                "Dark",
                              ),

                            ),

                            PopupMenuItem(

                              value:
                                  "system",

                              child:
                                  Text(
                                "System",
                              ),

                            ),

                          ],

                        ),

                      ],

                    ),

                    const SizedBox(
                      height: 80,
                    ),
                                        //--------------------------------------------------
                    // Title
                    //--------------------------------------------------

                    const Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Sign in to continue managing your crusher projects.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 45),

                    //--------------------------------------------------
                    // Email
                    //--------------------------------------------------

                    const Text(
                      "Email",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextFormField(
                      controller: emailController,

                      keyboardType:
                          TextInputType.emailAddress,

                      validator: (value) {

                        if (value == null ||
                            value.trim().isEmpty) {

                          return "Please enter your email";
                        }

                        if (!value.contains("@")) {

                          return "Please enter a valid email";
                        }

                        return null;
                      },

                      decoration: InputDecoration(

                        hintText: "Enter your email",

                        prefixIcon: const Icon(
                          Icons.email_outlined,
                        ),

                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(14),
                        ),

                        enabledBorder:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(14),
                        ),

                        focusedBorder:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(14),
                          borderSide:
                              const BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    //--------------------------------------------------
                    // Password
                    //--------------------------------------------------

                    const Text(
                      "Password",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextFormField(

                      controller:
                          passwordController,

                      obscureText:
                          obscurePassword,

                      validator: (value) {

                        if (value == null ||
                            value.isEmpty) {

                          return "Please enter your password";
                        }

                        if (value.length < 6) {

                          return "Password must contain at least 6 characters";
                        }

                        return null;
                      },

                      decoration: InputDecoration(

                        hintText: "Enter your password",

                        prefixIcon: const Icon(
                          Icons.lock_outline,
                        ),

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

                        enabledBorder:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(14),
                        ),

                        focusedBorder:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(14),
                          borderSide:
                              const BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 35),

                    //--------------------------------------------------
                    // Login Button
                    //--------------------------------------------------

                    SizedBox(

                      width: double.infinity,

                      height: 56,

                      child: ElevatedButton(

                        onPressed: auth.isLoading
                            ? null
                            : login,

                        style: ElevatedButton.styleFrom(

                          backgroundColor:
                              Colors.blue,

                          foregroundColor:
                              Colors.white,

                          shape:
                              RoundedRectangleBorder(

                            borderRadius:
                                BorderRadius.circular(
                              14,
                            ),

                          ),

                        ),

                        child: auth.isLoading

                            ? const SizedBox(

                                width: 24,

                                height: 24,

                                child:
                                    CircularProgressIndicator(

                                  strokeWidth: 2,

                                  color: Colors.white,

                                ),

                              )

                            : const Text(

                                "Sign In",

                                style: TextStyle(

                                  fontSize: 17,

                                  fontWeight:
                                      FontWeight.bold,

                                ),

                              ),

                      ),

                    ),

                    const SizedBox(height: 40),

                    //--------------------------------------------------
                    // Footer
                    //--------------------------------------------------

                    const Center(

                      child: Text(

                        "CrusherTrack © 2026\nCrusher Management System",

                        textAlign: TextAlign.center,

                        style: TextStyle(
                          color: Colors.grey,
                        ),

                      ),

                    ),
                                      ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}