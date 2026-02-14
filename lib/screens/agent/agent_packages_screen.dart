import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/agent_side_drawer.dart';
import '../../widgets/custom_button.dart';

class AgentPackagesScreen extends StatelessWidget {
  const AgentPackagesScreen({Key? key}) : super(key: key);

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                const SizedBox(height: 16),
                CustomButton(
                  text: '+ Add New Package',
                  onPressed: () {
                    Navigator.pushNamed(context, '/agent/create-package');
                  },
                ),
              ],
            ),
          ),
          // Package List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 4,
              itemBuilder: (context, index) {
                return _buildPackageCard(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackageCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          // Package Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.image, color: AppColors.textTertiary),
          ),
          const SizedBox(width: 12),
          // Package Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lahore',
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Travel for 50000 | Includes transport & hotel',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Rating
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                const Icon(Icons.star, color: AppColors.star, size: 14),
                const SizedBox(width: 4),
                Text(
                  '4.1',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
