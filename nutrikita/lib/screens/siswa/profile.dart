import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              floating: true,
              pinned: true,
              snap: true,
              expandedHeight: 120,
              backgroundColor: theme.scaffoldBackgroundColor,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: const EdgeInsets.only(left: 24.0, bottom: 32.0),
                title: Text(
                  'Profil Saya',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.onBackground,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // User Photo and Name Section
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Rafii Ahmad Fahreza',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'NISN: 1234567890',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Status Gizi: ',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Icon(
                          Icons.circle,
                          color: theme.colorScheme.tertiary,
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Baik',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Profile Options/Actions Section
                    Card(
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.edit,
                                color: theme.colorScheme.primary,
                              ),
                              title: Text(
                                'Edit Profil',
                                style: theme.textTheme.titleMedium,
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              onTap: () {
                                // TODO: Navigate to Edit Profile screen
                              },
                            ),
                            Divider(
                              indent: 16,
                              endIndent: 16,
                              color: theme.dividerTheme.color,
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.bar_chart,
                                color: theme.colorScheme.primary,
                              ),
                              title: Text(
                                'Riwayat Data Gizi',
                                style: theme.textTheme.titleMedium,
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              onTap: () {
                                // TODO: Navigate to Nutrition History screen
                              },
                            ),
                            Divider(
                              indent: 16,
                              endIndent: 16,
                              color: theme.dividerTheme.color,
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.settings,
                                color: theme.colorScheme.primary,
                              ),
                              title: Text(
                                'Pengaturan',
                                style: theme.textTheme.titleMedium,
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              onTap: () {
                                // TODO: Navigate to Settings screen
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Logout Button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          // TODO: Implement logout logic
                        },
                        child: Text(
                          'Keluar',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.error,
                          ),
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
      ),
    );
  }
}
