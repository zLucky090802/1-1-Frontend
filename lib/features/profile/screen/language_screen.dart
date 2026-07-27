import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLanguage = 'English (us)';
  String _searchQuery = '';

  final List<Map<String, String>> _languages = [
    {'name': 'English (us)', 'code': 'us'},
    {'name': 'Español', 'code': 'es'},
  ];

  @override
  Widget build(BuildContext context) {
    // Filter languages based on search query
    final filteredLanguages = _languages.where((lang) {
      return lang['name']!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7), // Warm cozy background
      body: SafeArea(
        child: Column(
          children: [
            // Header Section with Back Button and Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Color(0xFF2C1D11)),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(width: 24),
                  const Text(
                    'Language',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C1D11),
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
            
            // Search Bar Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  style: const TextStyle(color: Color(0xFF2C1D11), fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Search language...',
                    hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                    prefixIcon: Icon(Icons.search, color: Colors.grey.shade400, size: 20),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 12),

            // Language Grid View
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GridView.builder(
                  itemCount: filteredLanguages.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.95,
                  ),
                  itemBuilder: (context, index) {
                    final lang = filteredLanguages[index];
                    final isSelected = _selectedLanguage == lang['name'];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedLanguage = lang['name']!;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? const Color(0xFFC88A65) : Colors.transparent,
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Flag Representation Container
                            Container(
                              width: 64,
                              height: 44,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: _buildFlagIcon(lang['code']!),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              lang['name']!,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                color: const Color(0xFF2C1D11),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to render flags cleanly
  Widget _buildFlagIcon(String code) {
    if (code == 'es') {
      return Container(
        color: const Color(0xFFAA151B),
        child: Column(
          children: [
            Expanded(flex: 1, child: Container(color: const Color(0xFFAA151B))),
            Expanded(
              flex: 2,
              child: Container(
                color: const Color(0xFFF1BF00),
                alignment: Alignment.center,
                child: const Icon(Icons.star, size: 8, color: Color(0xFFAA151B)),
              ),
            ),
            Expanded(flex: 1, child: Container(color: const Color(0xFFAA151B))),
          ],
        ),
      );
    } else {
      return Container(
        color: Colors.white,
        child: Column(
          children: List.generate(6, (i) => Expanded(
            child: Container(
              color: i % 2 == 0 ? const Color(0xFFB22234) : Colors.white,
            ),
          )),
        ),
      );
    }
  }
}