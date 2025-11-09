import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final avatarR = screenW * 0.22;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF7F7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.pinkAccent),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.pinkAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🌄 Stack the sky and avatar so they overlap
            SizedBox(
              width: screenW * 0.8,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [
                  // background sky image
                  AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/sky.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // overlapping avatar
                  Positioned(
                    bottom: -avatarR * 0.6, // controls how much it overlaps
                    child: CircleAvatar(
                      radius: avatarR + 6,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: avatarR,
                        backgroundImage:
                            const AssetImage('assets/images/BigProfile.png'),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // add extra space to account for overlap
            SizedBox(height: avatarR * 0.9 + 20),

            // 👇 name and subtitle
            const Text(
              'Nattachai',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE57373),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'the cyber security experts',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF80CBC4),
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
