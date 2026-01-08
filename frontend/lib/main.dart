import 'package:flutter/material.dart';
import 'flip_card_info_overlay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Info Window Showcase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff2177C7)),
        useMaterial3: true,
      ),
      home: const ShowcaseHomePage(),
    );
  }
}

class ShowcaseHomePage extends StatefulWidget {
  const ShowcaseHomePage({super.key});

  @override
  State<ShowcaseHomePage> createState() => _ShowcaseHomePageState();
}

class _ShowcaseHomePageState extends State<ShowcaseHomePage>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _cardsController;
  late Animation<double> _headerSlideAnimation;
  late Animation<double> _headerFadeAnimation;

  @override
  void initState() {
    super.initState();

    _headerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _headerSlideAnimation = Tween<double>(begin: -50, end: 0).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeOutCubic),
    );

    _headerFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeOut),
    );

    _cardsController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _cardsController.forward();
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _cardsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<InfoPanelItem> infoPanels = [
      InfoPanelItem(
        title: 'UI Components',
        subtitle: 'Buttons, Cards, Inputs & more',
        icon: Icons.widgets_rounded,
        color: const Color(0xff2177C7),
        onTap: () => InfoCardButton.showHomeInfoPanel(context),
      ),
      InfoPanelItem(
        title: 'Flutter Widgets',
        subtitle: 'Container, Row, Column, Stack',
        icon: Icons.view_quilt_rounded,
        color: const Color(0xFF10B981),
        onTap: () => InfoCardButton.showKPIInfoPanel(context),
      ),
      InfoPanelItem(
        title: 'State Management',
        subtitle: 'setState, Provider, Riverpod',
        icon: Icons.account_tree_rounded,
        color: const Color(0xFF8B5CF6),
        onTap: () => InfoCardButton.showDashboardInfoPanel(context),
      ),
      InfoPanelItem(
        title: 'Navigation',
        subtitle: 'Routes, Tabs, Drawers',
        icon: Icons.navigation_rounded,
        color: const Color(0xFF6B7280),
        onTap: () => InfoCardButton.showSettingInfoPanel(context),
      ),
      InfoPanelItem(
        title: 'Animations',
        subtitle: 'Implicit & Explicit animations',
        icon: Icons.animation_rounded,
        color: const Color(0xFFF59E0B),
        onTap: () => InfoCardButton.showTrackingInfoPanel(context),
      ),
      InfoPanelItem(
        title: 'Theming',
        subtitle: 'Colors, Typography, Dark Mode',
        icon: Icons.palette_rounded,
        color: const Color(0xFFEF4444),
        onTap: () => InfoCardButton.showAlertandNotifiInfoPanel(context),
      ),
      InfoPanelItem(
        title: 'Responsive Design',
        subtitle: 'MediaQuery, LayoutBuilder',
        icon: Icons.devices_rounded,
        color: Colors.teal,
        onTap: () => InfoCardButton.showHomeScreenGroupInfoPanel(context),
      ),
      InfoPanelItem(
        title: 'Getting Started',
        subtitle: 'Setup, Hot Reload, Debugging',
        icon: Icons.rocket_launch_rounded,
        color: Colors.indigo,
        onTap: () =>
            InfoCardButton.showHomeScreenDeviceOnboardingInfoPanel(context),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff2177C7),
        foregroundColor: Colors.white,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Flutter Info Window',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Interactive Info Panels Showcase',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'Flutter Info Window',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2026 Flutter Info Window Showcase',
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'A showcase of beautiful, interactive info panels with collapsible sidebars, YouTube video integration, and smooth animations.',
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedBuilder(
              animation: _headerController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _headerSlideAnimation.value),
                  child: Opacity(
                    opacity: _headerFadeAnimation.value,
                    child: child,
                  ),
                );
              },
              child: _AnimatedHeaderCard(),
            ),
            const SizedBox(height: 24),

            AnimatedBuilder(
              animation: _headerController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(-30 * (1 - _headerFadeAnimation.value), 0),
                  child: Opacity(
                    opacity: _headerFadeAnimation.value,
                    child: child,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 12),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xff2177C7),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Available Info Panels',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff333333),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
              ),
              itemCount: infoPanels.length,
              itemBuilder: (context, index) {
                final item = infoPanels[index];
                return _StaggeredAnimatedCard(
                  index: index,
                  controller: _cardsController,
                  child: _InfoPanelCard(item: item),
                );
              },
            ),

            const SizedBox(height: 24),

            AnimatedBuilder(
              animation: _cardsController,
              builder: (context, child) {
                final progress = Curves.easeOutCubic.transform(
                  (_cardsController.value * 1.5).clamp(0.0, 1.0),
                );
                return Transform.translate(
                  offset: Offset(0, 30 * (1 - progress)),
                  child: Opacity(opacity: progress, child: child),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  children: [
                    Icon(Icons.code, color: Colors.grey[400], size: 32),
                    const SizedBox(height: 8),
                    Text(
                      'Built with Flutter',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Showcasing reusable info panel components',
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
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


//! HEADER
class _AnimatedHeaderCard extends StatefulWidget {
  @override
  State<_AnimatedHeaderCard> createState() => _AnimatedHeaderCardState();
}

class _AnimatedHeaderCardState extends State<_AnimatedHeaderCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [
                Color(0xff2177C7),
                Color(0xff1a5f9e),
                Color(0xff2177C7),
              ],
              stops: [0.0, _shimmerController.value, 1.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff2177C7).withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: child,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.8, end: 1.0),
                duration: const Duration(milliseconds: 1000),
                curve: Curves.elasticOut,
                builder: (context, value, child) {
                  return Transform.scale(scale: value, child: child);
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.widgets_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Interactive Info Panels',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Tap any card below to explore',
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.touch_app, color: Colors.white70, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Features: Collapsible Sidebar • YouTube Integration • Smooth Animations',
                    style: const TextStyle(fontSize: 11, color: Colors.white70),
                    overflow: TextOverflow.ellipsis,
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

//! GRID ITEM
class _StaggeredAnimatedCard extends StatelessWidget {
  final int index;
  final AnimationController controller;
  final Widget child;

  const _StaggeredAnimatedCard({
    required this.index,
    required this.controller,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final startTime = (index * 0.1).clamp(0.0, 0.6);
    final endTime = (startTime + 0.4).clamp(0.0, 1.0);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final opacityProgress = Interval(
          startTime,
          endTime,
          curve: Curves.easeOutCubic,
        ).transform(controller.value);

        final transformProgress = Interval(
          startTime,
          endTime,
          curve: Curves.easeOutBack,
        ).transform(controller.value);

        return Transform.translate(
          offset: Offset(0, 50 * (1 - transformProgress)),
          child: Transform.scale(
            scale: 0.8 + (0.2 * transformProgress),
            child: Opacity(
              opacity: opacityProgress.clamp(0.0, 1.0),
              child: child,
            ),
          ),
        );
      },
      child: child,
    );
  }
}

class InfoPanelItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  InfoPanelItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}

class _InfoPanelCard extends StatefulWidget {
  final InfoPanelItem item;

  const _InfoPanelCard({required this.item});

  @override
  State<_InfoPanelCard> createState() => _InfoPanelCardState();
}

class _InfoPanelCardState extends State<_InfoPanelCard>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );

    _elevationAnimation = Tween<double>(begin: 8, end: 2).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _hoverController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _hoverController.reverse();
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
    _hoverController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _hoverController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            onTap: widget.item.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _isPressed
                    ? widget.item.color.withOpacity(0.05)
                    : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: widget.item.color.withOpacity(
                      _isPressed ? 0.2 : 0.1,
                    ),
                    blurRadius: _elevationAnimation.value,
                    offset: Offset(0, _elevationAnimation.value / 2),
                  ),
                ],
                border: Border.all(
                  color: widget.item.color.withOpacity(_isPressed ? 0.4 : 0.2),
                  width: _isPressed ? 2 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 1.0, end: _isPressed ? 1.1 : 1.0),
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutBack,
                    builder: (context, value, child) {
                      return Transform.scale(scale: value, child: child);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            widget.item.color,
                            widget.item.color.withOpacity(0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: widget.item.color.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        widget.item.icon,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.item.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff333333),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.item.subtitle,
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
