import 'package:flutter/material.dart';
import '../widget/bottom_nav_bar.dart';
import '../screens/profile.dart'; // Pastikan path sudah benar

class OrtuScreen extends StatefulWidget {
  const OrtuScreen({super.key});

  @override
  State<OrtuScreen> createState() => _OrtuScreenState();
}

class _OrtuScreenState extends State<OrtuScreen> {
  String selectedQuality = '';
  final TextEditingController feedbackController = TextEditingController();
  int _selectedIndex = 0;

  void selectQuality(String quality) {
    setState(() {
      selectedQuality = quality;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<Widget> _widgetOptions = [
      _OrtuFeedbackContent(
        selectedQuality: selectedQuality,
        feedbackController: feedbackController,
        selectQuality: selectQuality,
      ),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar:
          _selectedIndex == 0
              ? AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: theme.scaffoldBackgroundColor,
                elevation: 0,
                title: Text(
                  'Feedback Orang Tua',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.onBackground,
                  ),
                ),
              )
              : null,
      body: IndexedStack(index: _selectedIndex, children: _widgetOptions),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// Widget untuk konten feedback ortu
class _OrtuFeedbackContent extends StatelessWidget {
  final String selectedQuality;
  final TextEditingController feedbackController;
  final Function(String) selectQuality;

  const _OrtuFeedbackContent({
    required this.selectedQuality,
    required this.feedbackController,
    required this.selectQuality,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Feedback Tumbuh dan Gizi Anak",
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onBackground,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: feedbackController,
                            maxLines: 4,
                            decoration: InputDecoration(
                              hintText: "Tuliskan umpan balik Anda di sini...",
                              filled: true,
                              fillColor: theme.colorScheme.surface,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Contoh: Perubahan yang Anda lihat pada anak, komentar tentang program makan gratis.",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            "Kualitas Makanan",
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onBackground,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: [
                              _qualityButton("Sangat Baik", theme),
                              _qualityButton("Baik", theme),
                              _qualityButton("Cukup", theme),
                              _qualityButton("Kurang", theme),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Text(
                            "Pengalaman Lain",
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onBackground,
                            ),
                          ),
                          Text(
                            "Berbagi pengalaman dan saran.",
                            style: theme.textTheme.bodySmall,
                          ),
                          const SizedBox(height: 16),
                          _feedbackItem(
                            "💡",
                            "Saran",
                            "Usulan lebih banyak sayuran.",
                            theme,
                          ),
                          const SizedBox(height: 12),
                          _feedbackItem(
                            "❤️",
                            "Testimoni",
                            "Anak saya lebih bertenaga!",
                            theme,
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.surface,
                                  side: BorderSide(
                                    color: theme.colorScheme.primary,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 12,
                                  ),
                                ),
                                child: Text(
                                  "Batal",
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (_) => AlertDialog(
                                          title: const Text("Feedback Dikirim"),
                                          content: const Text(
                                            "Terima kasih atas masukan Anda.",
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed:
                                                  () => Navigator.pop(context),
                                              child: const Text("OK"),
                                            ),
                                          ],
                                        ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 12,
                                  ),
                                ),
                                child: Text(
                                  "Kirim Feedback",
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    color: theme.colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _qualityButton(String label, ThemeData theme) {
    bool isSelected = selectedQuality == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: theme.colorScheme.primary,
      labelStyle: theme.textTheme.bodyMedium?.copyWith(
        color:
            isSelected
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSurface,
      ),
      onSelected: (_) => selectQuality(label),
      backgroundColor: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  Widget _feedbackItem(
    String emoji,
    String title,
    String text,
    ThemeData theme,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(text, style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}
