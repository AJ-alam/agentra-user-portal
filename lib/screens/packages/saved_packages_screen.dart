import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/package_card.dart';

class SavedPackagesScreen extends StatelessWidget {
  const SavedPackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Saved Packages',
          style: AppTextStyles.headingSmall,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return PackageCard(
            imageUrl: 'https://via.placeholder.com/100',
            title: 'Nathia Gali Adventure',
            duration: '2 Days',
            price: 'PKR 15,000',
            description: 'Experience the beauty of nature',
            rating: 4.5,
            showSaleBadge: false,
            onTap: () {
              Navigator.pushNamed(context, '/package-detail', arguments: '$index');
            },
          );
        },
      ),
    );
  }
}
