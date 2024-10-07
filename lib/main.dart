import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FadingTextAnimation(),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation>
    with SingleTickerProviderStateMixin {
  bool _isVisible = true;
  late AnimationController controller;
  late Animation<Color?> colorAnimation;
  late Animation<double> sizeAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    colorAnimation =
        ColorTween(begin: Colors.blue, end: Colors.yellow).animate(controller);
    sizeAnimation = Tween<double>(begin: 24.0, end: 48.0).animate(controller);

    // Rebuilding the screen when animation goes ahead
    controller.addListener(() {
      setState(() {});
    });
    controller.repeat();
  }

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;

      if (_isVisible) {
        controller.reverse(); // Reverse animation when hiding
      } else {
        controller.forward(); // Start animation when showing
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fading Text Animation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated text with background color
            AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: Duration(seconds: 1),
              child: Container(
                color: colorAnimation.value, // Apply color animation
                child: Text(
                  'Hello, Flutter!',
                  style: TextStyle(
                      fontSize: sizeAnimation.value), // Apply size animation
                ),
              ),
            ),
            SizedBox(height: 20),
            // Fading image that appears when the text is hidden
            AnimatedOpacity(
              opacity: _isVisible ? 0.0 : 1.0,
              duration: Duration(seconds: 1),
              child: Image.asset(
                'assets/fadeImage1.png', // Local asset image path
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
