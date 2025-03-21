
import 'package:flutter/material.dart';

class StartingBG extends StatelessWidget {
  final Widget mainUI;
  const StartingBG({super.key, required this.mainUI});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      
      body: SingleChildScrollView(
        // physics: const NeverScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            // fit: StackFit.expand,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                // color: Colors.red,
              ),
              // top-left - Shape
              Positioned(
                left: -200, // Adjust position as needed
                top: -150, // Adjust position as needed
                child: Transform.rotate(
                  angle: 0,
                  child: Image.asset(
                    'assets/images/shape.png',
                    width: 300, // Set width
                    fit: BoxFit.cover, // Adjust fit as needed
                  ),
                ),
              ),
              // bottom-right - Shape
              Positioned(
                right: -100, // Adjust position as needed
                bottom: 80, // Adjust position as needed
                child: Transform.rotate(
                  angle: 0,
                  child: Image.asset(
                    'assets/images/shape.png',
                    width: 320, // Set width
                    fit: BoxFit.cover, // Adjust fit as needed
                  ),
                ),
              ),
              // bottom-left
              Positioned(
                left: -0, // Adjust position as needed
                bottom: 0, // Adjust position as needed
                child: Transform.rotate(
                  angle: 0, // Rotate 30 degrees (convert degrees to radians)
                  child: Image.asset(
                    'assets/images/bg-bottom-left.png',
                    width: 300, // Set width
                    // height: 200, // Set height
                    fit: BoxFit.cover, // Adjust fit as needed
                  ),
                ),
              ),
              // Top - Right
              Positioned(
                right: 0, // Adjust position as needed
                top: 0, // Adjust position as needed
                child: Transform.rotate(
                  angle: 0, // Rotate 30 degrees (convert degrees to radians)
                  child: Image.asset(
                    'assets/images/bg-top-right.png',
                    width: 300, // Set width
                    // height: 200, // Set height
                    fit: BoxFit.cover, // Adjust fit as needed
                  ),
                ),
              ),

              // Main Content
              SizedBox(
                // color: Colors.red,
                height: MediaQuery.of(context).size.height,
                child: Center(child: mainUI),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
