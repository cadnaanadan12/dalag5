import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/user_profile.dart';
import '../providers/language_provider.dart';
import '../providers/user_provider.dart';
import '../theme/app_theme.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _nameController = TextEditingController();
  final _cityController = TextEditingController();
  String? _photoPath;

  @override
  void initState() {
    super.initState();
    final user = context.read<UserProvider>().user;
    if (user != null) {
      _nameController.text = user.name;
      _cityController.text = user.city;
      _photoPath = user.photoPath;
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _photoPath = picked.path);
    }
  }

  void _save() {
    final userProvider = context.read<UserProvider>();
    final current = userProvider.user!;
    final updated = UserProfile(
      username: current.username,
      email: current.email,
      name: _nameController.text.trim(),
      city: _cityController.text.trim(),
      photoPath: _photoPath,
    );
    userProvider.updateProfile(updated);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    return Scaffold(
      appBar: AppBar(title: Text(lang.t('edit_profile'))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.lightGreenChip,
                  backgroundImage:
                      _photoPath != null ? FileImage(File(_photoPath!)) : null,
                  child: _photoPath == null
                      ? const Icon(Icons.person,
                          size: 50, color: AppColors.primaryGreen)
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    tooltip: lang.t('change_photo'),
                    icon: const Icon(Icons.camera_alt,
                        color: AppColors.primaryGreen),
                    onPressed: _pickImage,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: lang.t('name')),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _cityController,
              decoration: InputDecoration(labelText: lang.t('city')),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _save,
              child: Text(lang.t('save')),
            ),
          ],
        ),
      ),
    );
  }
}
