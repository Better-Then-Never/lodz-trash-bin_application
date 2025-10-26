import 'package:flutter/material.dart';
import 'package:lodz_trash_bin/decorations/input_decorations.dart';
import 'package:lodz_trash_bin/main.dart';
import 'package:lodz_trash_bin/services/auth_service.dart';
import 'package:lodz_trash_bin/services/user_service.dart';
import 'package:lodz_trash_bin/views/widgets/common/custom_card.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _authService = AuthService();

  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/ecopoint-logo.png',
                  width: screenWidth * 0.3,
                  height: screenWidth * 0.3,
                ),
                Column(
                  children: [
                    SizedBox(height: 16),
                    Text(
                      isLogin ? 'Witamy z Powrotem!' : 'Dołącz do EcoPoint',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      isLogin
                          ? 'Zaloguj się do swojego eko-konta'
                          : 'Utwórz konto i zacznij zbierać punkty',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                CustomCard(
                  child: Column(
                    children: [
                      if (!isLogin) ...[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Imię i nazwisko',
                            style: TextStyle(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        TextField(
                          controller: _nameController,
                          decoration: InputDecorations.greyRounded(
                            hintText: 'John Pork',
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Username',
                            style: TextStyle(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecorations.greyRounded(
                            hintText: 'johnpork_eco',
                          ),
                        ),
                      ],
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Email',
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecorations.greyRounded(
                          hintText: 'johnpork@gmail.com',
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Hasło',
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecorations.greyRounded(
                          hintText: 'haslo#123',
                        ),
                        obscureText: true,
                      ),

                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            final email = _emailController.text.trim();
                            final password = _passwordController.text.trim();

                            if (isLogin) {
                              final user = await _authService.login(
                                email,
                                password,
                              );
                              if (user != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Login successful!'),
                                  ),
                                );
                              }
                              final userService = context.read<UserService>();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ChangeNotifierProvider.value(
                                    value: userService,
                                    child: NavigationView(),
                                  ),
                                ),
                              );
                            } else {
                              final name = _nameController.text.trim();
                              final username = _usernameController.text.trim();
                              final user = await _authService.signUp(
                                email,
                                password,
                                name,
                                username,
                              );
                              if (user != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Sign up successful!'),
                                  ),
                                );
                              }
                              final userService = context.read<UserService>();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ChangeNotifierProvider.value(
                                    value: userService,
                                    child: const NavigationView(),
                                  ),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            isLogin ? 'Zaloguj się' : 'Zarejestruj się',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: TextButton(
          onPressed: () => setState(() => isLogin = !isLogin),
          child: Text(
            isLogin ? 'Nie masz konta? Utwórz' : 'Już masz konto? Zaloguj się',
          ),
        ),
      ),
    );
  }
}
