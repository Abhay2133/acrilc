import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StartingBG extends StatelessWidget {
  final Widget mainUI;
  final bool showBackButton;
  const StartingBG({
    super.key,
    required this.mainUI,
    this.showBackButton = false,
  });

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
              Container(
                alignment: Alignment.center,
                // color: Colors.red,
                height: MediaQuery.of(context).size.height,
                child: mainUI,
              ),
              showBackButton
                  ? Positioned(
                    top: 40,
                    left: 20,
                    child: IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: Icon(Icons.arrow_back_ios_rounded),
                    ),
                  )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
