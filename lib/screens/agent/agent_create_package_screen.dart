import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/agent_side_drawer.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_input.dart';

class AgentCreatePackageScreen extends StatefulWidget {
  const AgentCreatePackageScreen({Key? key}) : super(key: key);

  @override
  State<AgentCreatePackageScreen> createState() => _AgentCreatePackageScreenState();
}

class _AgentCreatePackageScreenState extends State<AgentCreatePackageScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Form controllers
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _priceController = TextEditingController();
  final _discountController = TextEditingController();
  final _provinceController = TextEditingController();
  final _departureCityController = TextEditingController();
  final _notIncludedController = TextEditingController();
  
  // Checkboxes
  bool _includeTransport = false;
  bool _includeAccommodation = false;
  bool _includeMeals = false;
  bool _isFeatured = false;
  bool _hasDiscount = false;
  
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _priceController.dispose();
    _discountController.dispose();
    _provinceController.dispose();
    _departureCityController.dispose();
    _notIncludedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Create New Package'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Upload Thumbnail
              _buildSection(
                'Package Thumbnail',
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(AppDimensions.radius),
                    border: Border.all(color: AppColors.border, style: BorderStyle.solid),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.cloud_upload_outlined,
                          size: 40,
                          color: AppColors.textTertiary,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Click to upload image',
                          style: AppTextStyles.bodyMedium,
                        ),
                        Text(
                          'PNG, JPG up to 5MB',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Basic Info
              _buildSection(
                'Basic Information',
                Column(
                  children: [
                    CustomInput(
                      label: 'Package Title',
                      controller: _titleController,
                      hint: 'e.g., 2-Day Nathia Gali Adventure',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter package title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomInput(
                      label: 'Description',
                      controller: _descriptionController,
                      hint: 'Describe your package...',
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: CustomInput(
                            label: 'Location',
                            controller: _locationController,
                            hint: 'e.g., Nathia Gali',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomInput(
                            label: 'Price (PKR)',
                            controller: _priceController,
                            hint: 'e.g., 15000',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Includes
              _buildSection(
                'What\'s Included',
                Column(
                  children: [
                    _buildCheckbox('Transport', _includeTransport, (value) {
                      setState(() => _includeTransport = value!);
                    }),
                    _buildCheckbox('Accommodation', _includeAccommodation, (value) {
                      setState(() => _includeAccommodation = value!);
                    }),
                    _buildCheckbox('Meals', _includeMeals, (value) {
                      setState(() => _includeMeals = value!);
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Highlight Options
              _buildSection(
                'Highlight Options',
                Column(
                  children: [
                    _buildCheckbox('Featured Package', _isFeatured, (value) {
                      setState(() => _isFeatured = value!);
                    }),
                    _buildCheckbox('Discount Available', _hasDiscount, (value) {
                      setState(() => _hasDiscount = value!);
                    }),
                    if (_hasDiscount) ...[
                      const SizedBox(height: 16),
                      CustomInput(
                        label: 'Discount Percentage',
                        controller: _discountController,
                        hint: 'e.g., 30',
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Additional Details
              _buildSection(
                'Additional Details',
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomInput(
                            label: 'Province',
                            controller: _provinceController,
                            hint: 'e.g., KP',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomInput(
                            label: 'Departure City',
                            controller: _departureCityController,
                            hint: 'e.g., Islamabad',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomInput(
                      label: 'What\'s Not Included',
                      controller: _notIncludedController,
                      hint: 'e.g., Personal expenses',
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Submit Button
              CustomButton(
                text: 'Create Package',
                onPressed: _handleSubmit,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.headingSmall.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 12),
        content,
      ],
    );
  }

  Widget _buildCheckbox(String label, bool value, Function(bool?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Package created successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    }
  }
}
