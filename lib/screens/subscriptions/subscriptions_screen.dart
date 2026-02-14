import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

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
          'Subscriptions',
          style: AppTextStyles.headingSmall,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSubscriptionCard(
            'Basic Plan',
            'PKR 999/month',
            [
              '5 Bookings per month',
              'Standard support',
              'Basic features',
            ],
            false,
          ),
          const SizedBox(height: 16),
          _buildSubscriptionCard(
            'Premium Plan',
            'PKR 2,499/month',
            [
              'Unlimited bookings',
              'Priority support',
              'All features',
              '10% discount on all packages',
            ],
            true,
          ),
          const SizedBox(height: 16),
          _buildSubscriptionCard(
            'Enterprise Plan',
            'PKR 4,999/month',
            [
              'Unlimited bookings',
              '24/7 dedicated support',
              'All features',
              '20% discount on all packages',
              'Custom packages',
            ],
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionCard(
    String title,
    String price,
    List<String> features,
    bool isActive,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radius),
        border: Border.all(
          color: isActive ? AppColors.primary : AppColors.border,
          width: isActive ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.headingSmall.copyWith(fontSize: 18),
              ),
              if (isActive)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Active',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: AppTextStyles.headingMedium.copyWith(
              color: AppColors.primary,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 16),
          ...features.map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: AppColors.success,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        feature,
                        style: AppTextStyles.bodyMedium,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
