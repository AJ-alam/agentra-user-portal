import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/agent_side_drawer.dart';
import '../../widgets/custom_button.dart';

class AgentDashboardScreen extends StatelessWidget {
  const AgentDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: AppColors.textPrimary),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.backgroundLight,
              child: const Icon(Icons.person, color: AppColors.primary, size: 24),
            ),
          ),
        ],
      ),
      drawer: const AgentSideDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            RichText(
              text: TextSpan(
                style: AppTextStyles.headingLarge.copyWith(fontSize: 26),
                children: const [
                  TextSpan(
                    text: 'Explore the\nBeautiful ',
                    style: TextStyle(color: AppColors.textPrimary),
                  ),
                  TextSpan(
                    text: 'world!',
                    style: TextStyle(color: AppColors.orange),
                  ),
                ],
              ),
            ),
            // Empty State
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No Packages',
                      style: AppTextStyles.headingMedium.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                    const SizedBox(height: 32),
                    CustomButton(
                      text: '+ Add New Package',
                      onPressed: () {
                        Navigator.pushNamed(context, '/agent/create-package');
                      },
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                         Navigator.pushReplacementNamed(context, '/home');
                      },
                      child: const Text('Back to User Mode'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
