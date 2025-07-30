import 'package:fdp_app/views/main/layout_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class InfromPage extends StatefulWidget {
  const InfromPage({super.key});

  @override
  State<InfromPage> createState() => _InfromPageState();
}

class _InfromPageState extends State<InfromPage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation1;
  late Animation<Color?> _colorAnimation2;
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation1 = ColorTween(
      begin: const Color(0xFF1A2980), // Deep blue
      end: const Color(0xFF26D0CE), // Teal
    ).animate(_controller);

    _colorAnimation2 = ColorTween(
      begin: const Color(0xFF6A82FB), // Purple
      end: const Color(0xFFFC5C7D), // Pink-red
    ).animate(_controller);
  }

  void switchPage(int pageIndex) {
    setState(() => _currentPage = pageIndex);
    _pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _colorAnimation1.value ?? Colors.deepPurple,
                  _colorAnimation2.value ?? Colors.black,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.home, color: Colors.white),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LayoutPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _animatedLogoTitle(screenWidth),
                  const SizedBox(height: 20),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        _loginForm(screenHeight, screenWidth),
                        _registerForm(screenHeight, screenWidth),
                        _forgotPasswordForm(screenHeight, screenWidth),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _animatedLogoTitle(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: screenWidth * 0.12,
          height: screenWidth * 0.12,
          child: Lottie.asset('assets/animation/macos - Apple Music icon.json'),
        ),
        const SizedBox(width: 12),
        Text(
          'FDP Music',
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.08, // Responsive text size
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }

  Widget _formWrapper({
    required List<Widget> children,
    required double screenHeight,
    required double screenWidth,
  }) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: screenHeight * 0.05,
        bottom: screenHeight * 0.02,
      ),
      child: Column(
        children: [
          ...children,
          SizedBox(height: screenHeight * 0.02),
          _navToggles(screenWidth), // 👈 Add toggle buttons under form
        ],
      ),
    );
  }

  Widget _navToggles(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_currentPage != 0) _navTextButton("Login", 0, screenWidth),
        if (_currentPage != 0) _dividerDot(),
        if (_currentPage != 1) _navTextButton("Register", 1, screenWidth),
        if (_currentPage != 1) _dividerDot(),
        if (_currentPage != 2) _navTextButton("Forgot", 2, screenWidth),
      ],
    );
  }

  Widget _navTextButton(String text, int pageIndex, double screenWidth) {
    final isSelected = _currentPage == pageIndex;
    return TextButton(
      onPressed: () => switchPage(pageIndex),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.purpleAccent : Colors.white70,
          fontSize: screenWidth * 0.035,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _dividerDot() {
    return const Text(
      "•",
      style: TextStyle(color: Colors.white38, fontSize: 14),
    );
  }

  Widget _loginForm(double screenHeight, double screenWidth) {
    return _formWrapper(
      children: [
        _textInput("Email", screenHeight, screenWidth),
        _textInput("Password", screenHeight, screenWidth, isPassword: true),
        _formButton("Login", screenHeight, screenWidth),
      ],
      screenHeight: screenHeight,
      screenWidth: screenWidth,
    );
  }

  Widget _registerForm(double screenHeight, double screenWidth) {
    return _formWrapper(
      children: [
        _textInput("Name", screenHeight, screenWidth),
        _textInput("Email", screenHeight, screenWidth),
        _textInput("Password", screenHeight, screenWidth, isPassword: true),
        _formButton("Register", screenHeight, screenWidth),
      ],
      screenHeight: screenHeight,
      screenWidth: screenWidth,
    );
  }

  Widget _forgotPasswordForm(double screenHeight, double screenWidth) {
    return _formWrapper(
      children: [
        _textInput("Email", screenHeight, screenWidth),
        _formButton("Send Reset Link", screenHeight, screenWidth),
      ],
      screenHeight: screenHeight,
      screenWidth: screenWidth,
    );
  }

  Widget _textInput(
    String hint,
    double screenHeight,
    double screenWidth, {
    bool isPassword = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.012,
        horizontal: screenWidth * 0.06,
      ),
      child: TextField(
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white12,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white54),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
          ),
        ),
      ),
    );
  }

  Widget _formButton(String text, double screenHeight, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.025,
        horizontal: screenWidth * 0.06,
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            // Handle form submission
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
            backgroundColor: const Color.fromARGB(255, 85, 176, 236),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.03),
            ),
          ),
          child: Text(text, style: const TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
