import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Info {
  final String title;
  final IconData icon;
  final Color color;
  final String description;
  final String? videoUrl;

  Info({
    required this.title,
    required this.icon,
    required this.color,
    required this.description,
    this.videoUrl,
  });
}

class CustomCollapsibleItem {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isSelected;

  CustomCollapsibleItem({
    required this.text,
    required this.icon,
    required this.onPressed,
    this.isSelected = false,
  });
}

//! Animated Header with Main screen animation
class _AnimatedInfoHeader extends StatefulWidget {
  final String title;
  final BuildContext parentContext;

  const _AnimatedInfoHeader({required this.title, required this.parentContext});

  @override
  State<_AnimatedInfoHeader> createState() => _AnimatedInfoHeaderState();
}

class _AnimatedInfoHeaderState extends State<_AnimatedInfoHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> slideAnimation;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    slideAnimation = Tween<double>(begin: -30, end: 0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOutCubic),
    );

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );

    scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.elasticOut),
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(slideAnimation.value, 0),
          child: Opacity(
            opacity: fadeAnimation.value,
            child: child,
          ),
        );
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.5, end: 1.0),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.elasticOut,
                  builder: (context, value, child) {
                    return Transform.scale(scale: value, child: child);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xff2177C7), Color(0xff1a5f9e)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff2177C7).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.help_outline, color: Colors.white, size: 24),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutBack,
              builder: (context, value, child) {
                return Transform.scale(scale: value, child: child);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: _AnimatedCloseButton(
                  onPressed: () => Navigator.pop(widget.parentContext),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Animated close button with hover effect
class _AnimatedCloseButton extends StatefulWidget {
  final VoidCallback onPressed;

  const _AnimatedCloseButton({required this.onPressed});

  @override
  State<_AnimatedCloseButton> createState() => _AnimatedCloseButtonState();
}

class _AnimatedCloseButtonState extends State<_AnimatedCloseButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isHovered = true),
      onTapUp: (_) => setState(() => _isHovered = false),
      onTapCancel: () => setState(() => _isHovered = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _isHovered ? Colors.red.withOpacity(0.1) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: AnimatedRotation(
          turns: _isHovered ? 0.25 : 0,
          duration: const Duration(milliseconds: 200),
          child: Icon(
            Icons.close,
            color: _isHovered ? Colors.red : Colors.grey[600],
            size: 20,
          ),
        ),
      ),
    );
  }
}

Widget _buildVideoSection(String? videoUrl, Color color) {
  if (videoUrl == null || videoUrl.isEmpty) return const SizedBox.shrink();
  String? videoId = YoutubePlayer.convertUrlToId(videoUrl);
  if (videoId == null) return const SizedBox.shrink();

  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeOutCubic,
    builder: (context, value, child) {
      return Transform.translate(
        offset: Offset(0, 20 * (1 - value)),
        child: Opacity(opacity: value, child: child),
      );
    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.play_circle_outline, color: color, size: 18),
              const SizedBox(width: 8),
              Text("Tutorial Video", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: YoutubePlayer(
                controller: YoutubePlayerController(
                  initialVideoId: videoId,
                  flags: const YoutubePlayerFlags(autoPlay: false, mute: false, enableCaption: true),
                ),
                showVideoProgressIndicator: true,
                progressIndicatorColor: color,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text("Watch the tutorial to learn more", style: TextStyle(fontSize: 12, color: Colors.grey[600], fontStyle: FontStyle.italic)),
        ],
      ),
    ),
  );
}

//! Animated details content with smooth transitions
class _AnimatedDetails extends StatelessWidget {
  final Info info;
  final Key contentKey;

  const _AnimatedDetails({required this.info, required this.contentKey});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.05, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: Column(
        key: contentKey,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 500),
                curve: Curves.elasticOut,
                builder: (context, value, child) {
                  return Transform.scale(scale: value, child: child);
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [info.color, info.color.withOpacity(0.8)]),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: info.color.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(info.icon, color: Colors.white, size: 28),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(info.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey[800])),
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 60.0),
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutCubic,
                      builder: (context, value, child) {
                        return Container(
                          margin: const EdgeInsets.only(top: 4),
                          height: 3,
                          width: value,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [info.color, info.color.withOpacity(0.5)]),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 15 * (1 - value)),
                child: Opacity(opacity: value, child: child),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: info.color.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: info.color.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: info.color, size: 18),
                      const SizedBox(width: 8),
                      Text("Overview", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: info.color)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(info.description, style: TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.5)),
                ],
              ),
            ),
          ),
          _buildVideoSection(info.videoUrl, info.color),
        ],
      ),
    );
  }
}

// Animated sidebar item with press effect
class _AnimatedSidebarItem extends StatefulWidget {
  final CustomCollapsibleItem item;
  final bool isCollapsed;
  final double maxWidth;
  final int index;

  const _AnimatedSidebarItem({
    required this.item,
    required this.isCollapsed,
    required this.maxWidth,
    required this.index,
  });

  @override
  State<_AnimatedSidebarItem> createState() => _AnimatedSidebarItemState();
}

class _AnimatedSidebarItemState extends State<_AnimatedSidebarItem>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  late AnimationController _entranceController;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      duration: Duration(milliseconds: 300 + (widget.index * 50)),
      vsync: this,
    );
    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _entranceController,
      builder: (context, child) {
        // Use easeOutCubic for opacity to stay within 0-1 range
        final opacityProgress = Curves.easeOutCubic.transform(_entranceController.value);
        // Use easeOutBack for transform (can overshoot)
        final transformProgress = Curves.easeOutBack.transform(_entranceController.value);
        return Transform.translate(
          offset: Offset(-30 * (1 - transformProgress), 0),
          child: Opacity(opacity: opacityProgress.clamp(0.0, 1.0), child: child),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          onTap: widget.item.onPressed,
          child: AnimatedScale(
            scale: _isPressed ? 0.95 : 1.0,
            duration: const Duration(milliseconds: 100),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: widget.isCollapsed ? 8 : 12,
              ),
              decoration: BoxDecoration(
                gradient: widget.item.isSelected
                    ? LinearGradient(
                        colors: [
                          const Color(0xff2177C7),
                          const Color(0xff2177C7).withOpacity(0.8),
                        ],
                      )
                    : null,
                color: _isPressed && !widget.item.isSelected
                    ? Colors.grey[200]
                    : null,
                borderRadius: BorderRadius.circular(8),
                boxShadow: widget.item.isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xff2177C7).withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisAlignment: widget.isCollapsed
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  AnimatedScale(
                    scale: widget.item.isSelected ? 1.1 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      widget.item.icon,
                      color: widget.item.isSelected ? Colors.white : Colors.grey[700],
                      size: 18,
                    ),
                  ),
                  if (!widget.isCollapsed && widget.maxWidth > 120) ...[
                    const SizedBox(width: 10),
                    Expanded(
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: widget.item.isSelected ? Colors.white : Colors.grey[800],
                        ),
                        child: Text(
                          widget.item.text,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildResponsiveLayout(
  BuildContext context,
  ScrollController scrollController,
  bool isCollapsed,
  List<CustomCollapsibleItem> sidebarItems,
  Widget contentWidget,
  VoidCallback onToggle,
) {
  return LayoutBuilder(
    builder: (context, constraints) {
      double sidebarMinWidth = 60;
      double sidebarMaxWidth = constraints.maxWidth * 0.45;

      return Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOutCubic,
            width: isCollapsed ? sidebarMinWidth : sidebarMaxWidth,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border(right: BorderSide(color: Colors.grey[200]!)),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  child: _AnimatedToggleButton(
                    isCollapsed: isCollapsed,
                    onToggle: onToggle,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: sidebarItems.length,
                    itemBuilder: (context, index) {
                      final item = sidebarItems[index];
                      return _AnimatedSidebarItem(
                        item: item,
                        isCollapsed: isCollapsed,
                        maxWidth: sidebarMaxWidth,
                        index: index,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(16),
              child: contentWidget,
            ),
          ),
        ],
      );
    },
  );
}

//! toggle button for sidebar
class _AnimatedToggleButton extends StatefulWidget {
  final bool isCollapsed;
  final VoidCallback onToggle;

  const _AnimatedToggleButton({required this.isCollapsed, required this.onToggle});

  @override
  State<_AnimatedToggleButton> createState() => _AnimatedToggleButtonState();
}

class _AnimatedToggleButtonState extends State<_AnimatedToggleButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isHovered = true),
      onTapUp: (_) => setState(() => _isHovered = false),
      onTapCancel: () => setState(() => _isHovered = false),
      onTap: widget.onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _isHovered ? const Color(0xff2177C7).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: AnimatedRotation(
          turns: widget.isCollapsed ? 0 : 0.5,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutBack,
          child: Icon(
            widget.isCollapsed ? Icons.menu : Icons.menu_open,
            color: _isHovered ? const Color(0xff2177C7) : Colors.grey[600],
            size: 20,
          ),
        ),
      ),
    );
  }
}

List<CustomCollapsibleItem> _buildCustomSidebarItems(List<Info> infoList, int selectedIndex, Function(int) onItemSelected) {
  return infoList.asMap().entries.map((entry) {
    return CustomCollapsibleItem(
      text: entry.value.title,
      icon: entry.value.icon,
      isSelected: selectedIndex == entry.key,
      onPressed: () => onItemSelected(entry.key),
    );
  }).toList();
}

//! Base Info Panel with animations
class _BaseInfoPanel extends StatefulWidget {
  final String title;
  final List<Info> infoList;

  const _BaseInfoPanel({required this.title, required this.infoList});

  @override
  State<_BaseInfoPanel> createState() => _BaseInfoPanelState();
}

class _BaseInfoPanelState extends State<_BaseInfoPanel> {
  int selectedIndex = 0;
  bool isCollapsed = true;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, -10),
              ),
            ],
          ),
          child: Column(
            children: [

              //! Animated drag handle
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 400),
                builder: (context, value, child) {
                  return Opacity(opacity: value, child: child);
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              _AnimatedInfoHeader(title: widget.title, parentContext: context),
              Expanded(
                child: _buildResponsiveLayout(
                  context,
                  scrollController,
                  isCollapsed,
                  _buildCustomSidebarItems(
                    widget.infoList,
                    selectedIndex,
                    (i) => setState(() => selectedIndex = i),
                  ),
                  _AnimatedDetails(
                    info: widget.infoList[selectedIndex],
                    contentKey: ValueKey(selectedIndex),
                  ),
                  () => setState(() => isCollapsed = !isCollapsed),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

//! Flutter Widgets Info Panel
class KPIInfoPanel extends StatelessWidget {
  const KPIInfoPanel({super.key});

  static final List<Info> _infoList = [
    Info(title: "Container Widget", icon: Icons.check_box_outline_blank, color: const Color(0xff2177C7), description: "The Container widget is one of the most versatile widgets in Flutter. It combines common painting, positioning, and sizing widgets into a single convenient package. You can use it to add padding, margins, borders, background colors, and even apply transformations.", videoUrl: "https://www.youtube.com/watch?v=c1xLMaTUWCY"),
    Info(title: "Row & Column", icon: Icons.view_column, color: Colors.red, description: "Row and Column are fundamental layout widgets that arrange their children in horizontal and vertical directions respectively. They use the flex layout model, allowing you to control how children are sized and positioned.", videoUrl: "https://www.youtube.com/watch?v=RJEnTRBxaSg"),
    Info(title: "Stack Widget", icon: Icons.layers, color: Colors.green, description: "The Stack widget allows you to overlay multiple children on top of each other. Children are positioned relative to the edges of the stack using the Positioned widget. Perfect for badges, overlays, and complex layouts.", videoUrl: "https://www.youtube.com/watch?v=liEGSeD3Zt8"),
    Info(title: "ListView Builder", icon: Icons.list, color: Colors.orange, description: "ListView.builder is an efficient way to create scrollable lists with a large number of items. It only builds the widgets that are currently visible on screen, making it memory-efficient for long lists.", videoUrl: "https://www.youtube.com/watch?v=KJpkjHGiI5A"),
    Info(title: "GridView", icon: Icons.grid_view, color: Colors.purple, description: "GridView displays items in a two-dimensional grid layout. Flutter provides several constructors for different use cases including GridView.count, GridView.extent, and GridView.builder for efficient lazy-loading.", videoUrl: "https://www.youtube.com/watch?v=bLOtZDTm4H8"),
    Info(title: "AnimatedContainer", icon: Icons.animation, color: Colors.cyan, description: "AnimatedContainer automatically animates between old and new values of its properties. When you change properties like color, padding, or dimensions, it smoothly transitions to the new values.", videoUrl: "https://www.youtube.com/watch?v=yI-8QHpGIP4"),
    Info(title: "Hero Animation", icon: Icons.flight, color: Colors.teal, description: "Hero animations create a visual connection between two screens by animating a shared element during navigation. Simply wrap the shared element with Hero and provide a matching tag.", videoUrl: "https://www.youtube.com/watch?v=Be9UH1kXFDw"),
    Info(title: "CustomPaint", icon: Icons.brush, color: Colors.indigo, description: "CustomPaint provides a canvas on which you can draw custom shapes, paths, and graphics using the CustomPainter class. This is Flutter's most powerful drawing tool for charts, graphs, and custom visuals.", videoUrl: "https://www.youtube.com/watch?v=kp14Y4uHpHs"),
  ];

  @override
  Widget build(BuildContext context) {
    return _BaseInfoPanel(title: 'Flutter Widgets Guide', infoList: _infoList);
  }
}

// UI Components Info Panel
class HomeInfoPanel extends StatelessWidget {
  const HomeInfoPanel({super.key});

  static final List<Info> _infoList = [
    Info(title: "Buttons", icon: Icons.smart_button, color: const Color(0xff2177C7), description: "Flutter provides ElevatedButton, TextButton, OutlinedButton, and IconButton. Each serves different purposes with full customization through ButtonStyle.", videoUrl: "https://www.youtube.com/watch?v=pTJJsmejUOQ"),
    Info(title: "Cards & Tiles", icon: Icons.credit_card, color: Colors.purple, description: "Card widgets display content with rounded corners and elevation. ListTile provides a standardized way to display items in lists with icons, titles, and subtitles.", videoUrl: "https://www.youtube.com/watch?v=Kn0e-HyD9Fg"),
    Info(title: "Input Fields", icon: Icons.text_fields, color: Colors.green, description: "TextField and TextFormField are essential for user input. They support validation, decoration, keyboard types, and input formatters for professional form design.", videoUrl: "https://www.youtube.com/watch?v=w3krSTSaNfk"),
    Info(title: "Dialogs & Sheets", icon: Icons.picture_in_picture, color: Colors.orange, description: "AlertDialog, SimpleDialog, and BottomSheet provide contextual information and actions without leaving the current screen.", videoUrl: "https://www.youtube.com/watch?v=75CsnyRXf5I"),
    Info(title: "Snackbars", icon: Icons.message, color: Colors.brown, description: "SnackBar provides brief messages at the bottom of the screen, perfect for confirming actions or showing status updates with optional action buttons.", videoUrl: "https://www.youtube.com/watch?v=HyBTsjPp3wM"),
    Info(title: "Progress Indicators", icon: Icons.hourglass_empty, color: Colors.grey, description: "CircularProgressIndicator and LinearProgressIndicator show loading states. Both can be determinate or indeterminate with customizable colors.", videoUrl: "https://www.youtube.com/watch?v=O-rhXZLtpv0"),
  ];

  @override
  Widget build(BuildContext context) {
    return _BaseInfoPanel(title: 'UI Components Guide', infoList: _infoList);
  }
}

// State Management Info Panel
class DashBoardInfoPanel extends StatelessWidget {
  const DashBoardInfoPanel({super.key});

  static final List<Info> _infoList = [
    Info(title: "setState", icon: Icons.refresh, color: const Color(0xff2177C7), description: "setState is Flutter's simplest state management, built into StatefulWidget. Perfect for local state that doesn't need to be shared across widgets.", videoUrl: "https://www.youtube.com/watch?v=o_0ZWg8ooBk"),
    Info(title: "Provider", icon: Icons.account_tree, color: const Color(0xFF8B5CF6), description: "Provider is the recommended state management by Flutter team. It uses InheritedWidget under the hood with a simpler API for reactive updates.", videoUrl: "https://www.youtube.com/watch?v=L_QMsE2v6dw"),
    Info(title: "Riverpod", icon: Icons.hub, color: const Color(0xFF10B981), description: "Riverpod is a complete rewrite of Provider that's compile-safe and supports multiple providers of the same type with better code organization.", videoUrl: "https://www.youtube.com/watch?v=BJtQ0dfI-RA"),
  ];

  @override
  Widget build(BuildContext context) {
    return _BaseInfoPanel(title: 'State Management Guide', infoList: _infoList);
  }
}

//! Navigation Info Panel
class SettingInfoPanel extends StatelessWidget {
  const SettingInfoPanel({super.key});

  static final List<Info> _infoList = [
    Info(title: "Navigator 2.0", icon: Icons.navigation, color: const Color(0xff2177C7), description: "Navigator 2.0 provides a declarative API for managing navigation. Better for deep linking, web URLs, and complex navigation patterns.", videoUrl: "https://www.youtube.com/watch?v=nyvwx7o277U"),
    Info(title: "Named Routes", icon: Icons.route, color: const Color(0xFF8B5CF6), description: "Named routes provide a clean way to navigate between screens using string identifiers. Centralizes route definitions for maintainability.", videoUrl: "https://www.youtube.com/watch?v=nyvwx7o277U"),
    Info(title: "Bottom Navigation", icon: Icons.view_agenda, color: const Color(0xFF10B981), description: "BottomNavigationBar provides easy navigation between top-level views. Supports 3-5 destinations with icons and optional labels.", videoUrl: "https://www.youtube.com/watch?v=xoKqQjSDZ60"),
    Info(title: "Drawer Navigation", icon: Icons.menu, color: const Color(0xFFF59E0B), description: "Drawer provides a slide-out navigation panel from the edge of the screen. Perfect for apps with many navigation destinations.", videoUrl: "https://www.youtube.com/watch?v=WRj86iHihgY"),
    Info(title: "Tab Navigation", icon: Icons.tab, color: const Color(0xFFEF4444), description: "TabBar and TabBarView provide horizontal tab navigation. Great for organizing content into categories within a single screen.", videoUrl: "https://www.youtube.com/watch?v=POtoEH-5l40"),
  ];

  @override
  Widget build(BuildContext context) {
    return _BaseInfoPanel(title: 'Navigation Guide', infoList: _infoList);
  }
}

//! Animations Info Panel
class TrackingInfoPanel extends StatelessWidget {
  const TrackingInfoPanel({super.key});

  static final List<Info> _infoList = [
    Info(title: "Implicit Animations", icon: Icons.auto_awesome, color: const Color(0xff2177C7), description: "Implicit animations like AnimatedContainer, AnimatedOpacity, and AnimatedPositioned automatically animate property changes without controllers.", videoUrl: "https://www.youtube.com/watch?v=IVTjpW3W33s"),
    Info(title: "Explicit Animations", icon: Icons.animation, color: const Color(0xFF8B5CF6), description: "Explicit animations use AnimationController for fine-grained control. Perfect for complex, custom animations with precise timing.", videoUrl: "https://www.youtube.com/watch?v=CunyH6unILQ"),
    Info(title: "Tween Animations", icon: Icons.trending_up, color: const Color(0xFF10B981), description: "Tween defines the range of values for animations. Combine with AnimationController to create smooth transitions between any values.", videoUrl: "https://www.youtube.com/watch?v=fneC7t4R_B0"),
    Info(title: "Curves", icon: Icons.show_chart, color: const Color(0xFFF59E0B), description: "Curves define the rate of change over time. Flutter provides many built-in curves like easeIn, easeOut, bounce, and elastic.", videoUrl: "https://www.youtube.com/watch?v=fneC7t4R_B0"),
    Info(title: "Staggered Animations", icon: Icons.layers, color: const Color(0xFFEF4444), description: "Staggered animations sequence multiple animations with delays. Create beautiful choreographed effects by timing animations together.", videoUrl: "https://www.youtube.com/watch?v=0fFvnZemmh8"),
    Info(title: "Physics Animations", icon: Icons.sports_basketball, color: Colors.teal, description: "Physics-based animations simulate real-world physics like springs and friction. Create natural, responsive animations that feel organic.", videoUrl: "https://www.youtube.com/watch?v=KPJhQRNnPdI"),
  ];

  @override
  Widget build(BuildContext context) {
    return _BaseInfoPanel(title: 'Animations Guide', infoList: _infoList);
  }
}

//! Theming Info Panel
class NotificationAndAlertInfoPanel extends StatelessWidget {
  const NotificationAndAlertInfoPanel({super.key});

  static final List<Info> _infoList = [
    Info(title: "ThemeData", icon: Icons.palette, color: const Color(0xff2177C7), description: "ThemeData defines the overall visual theme of your app including colors, typography, and component styles. Apply globally via MaterialApp.", videoUrl: "https://www.youtube.com/watch?v=oTvQDJOBXmM"),
    Info(title: "ColorScheme", icon: Icons.color_lens, color: Colors.purple, description: "ColorScheme provides a set of harmonious colors for your app. Use ColorScheme.fromSeed() to generate a complete palette from a single color.", videoUrl: "https://www.youtube.com/watch?v=oTvQDJOBXmM"),
    Info(title: "Dark Mode", icon: Icons.dark_mode, color: Colors.grey, description: "Implement dark mode with ThemeData.dark() or custom dark themes. Use ThemeMode to switch between light, dark, and system themes.", videoUrl: "https://www.youtube.com/watch?v=oTvQDJOBXmM"),
    Info(title: "Typography", icon: Icons.text_format, color: Colors.orange, description: "TextTheme defines text styles for your app. Customize headline, body, and label styles for consistent typography throughout.", videoUrl: "https://www.youtube.com/watch?v=oTvQDJOBXmM"),
    Info(title: "Custom Themes", icon: Icons.brush, color: Colors.teal, description: "Create custom themes by extending ThemeData. Override specific properties while inheriting defaults for comprehensive customization.", videoUrl: "https://www.youtube.com/watch?v=oTvQDJOBXmM"),
  ];

  @override
  Widget build(BuildContext context) {
    return _BaseInfoPanel(title: 'Theming Guide', infoList: _infoList);
  }
}

//! Responsive Design Info Panel
class GroupsInfoPanel extends StatelessWidget {
  const GroupsInfoPanel({super.key});

  static final List<Info> _infoList = [
    Info(title: "MediaQuery", icon: Icons.devices, color: const Color(0xff2177C7), description: "MediaQuery provides information about the device screen size, orientation, and pixel density. Essential for building responsive layouts that adapt to different devices.", videoUrl: "https://www.youtube.com/watch?v=A3WrA4zAaPw"),
    Info(title: "LayoutBuilder", icon: Icons.dashboard, color: Colors.purple, description: "LayoutBuilder provides the parent widget's constraints, allowing you to build different layouts based on available space. Perfect for responsive design.", videoUrl: "https://www.youtube.com/watch?v=A3WrA4zAaPw"),
    Info(title: "Flexible & Expanded", icon: Icons.open_with, color: Colors.green, description: "Flexible and Expanded widgets control how children of Row and Column flex to fill available space. Use flex factors to distribute space proportionally.", videoUrl: "https://www.youtube.com/watch?v=CI7x0mAZiY0"),
    Info(title: "AspectRatio", icon: Icons.aspect_ratio, color: Colors.orange, description: "AspectRatio widget sizes its child to a specific aspect ratio. Great for images, videos, and maintaining proportions across different screen sizes.", videoUrl: "https://www.youtube.com/watch?v=XcnP3_mO_Ms"),
    Info(title: "FittedBox", icon: Icons.fit_screen, color: Colors.teal, description: "FittedBox scales and positions its child within itself according to fit. Useful for scaling text and widgets to fit available space.", videoUrl: "https://www.youtube.com/watch?v=T4Uehk3_wlY"),
  ];

  @override
  Widget build(BuildContext context) {
    return _BaseInfoPanel(title: 'Responsive Design Guide', infoList: _infoList);
  }
}

//! Getting Started Info Panel
class DeviceOnboardingInfoPanel extends StatelessWidget {
  const DeviceOnboardingInfoPanel({super.key});

  static final List<Info> _infoList = [
    Info(title: "Flutter Setup", icon: Icons.download, color: const Color(0xff2177C7), description: "Install Flutter SDK, set up your IDE (VS Code or Android Studio), and configure your development environment. Flutter doctor helps verify your setup.", videoUrl: "https://www.youtube.com/watch?v=1ukSR1GRtMU"),
    Info(title: "First App", icon: Icons.rocket_launch, color: Colors.green, description: "Create your first Flutter app with 'flutter create'. Understand the project structure, main.dart entry point, and how widgets build the UI.", videoUrl: "https://www.youtube.com/watch?v=1ukSR1GRtMU"),
    Info(title: "Hot Reload", icon: Icons.flash_on, color: Colors.orange, description: "Hot reload instantly reflects code changes without losing app state. Hot restart reloads the entire app. Both dramatically speed up development.", videoUrl: "https://www.youtube.com/watch?v=1ukSR1GRtMU"),
    Info(title: "Debugging", icon: Icons.bug_report, color: Colors.red, description: "Use Flutter DevTools for debugging, performance profiling, and widget inspection. Set breakpoints, inspect variables, and analyze widget trees.", videoUrl: "https://www.youtube.com/watch?v=1ukSR1GRtMU"),
    Info(title: "Packages", icon: Icons.inventory_2, color: Colors.purple, description: "Add packages from pub.dev to extend Flutter's capabilities. Manage dependencies in pubspec.yaml and run 'flutter pub get' to install.", videoUrl: "https://www.youtube.com/watch?v=1ukSR1GRtMU"),
    Info(title: "Building Apps", icon: Icons.build, color: Colors.teal, description: "Build release versions for iOS, Android, web, and desktop. Configure app icons, splash screens, and platform-specific settings for deployment.", videoUrl: "https://www.youtube.com/watch?v=1ukSR1GRtMU"),
  ];

  @override
  Widget build(BuildContext context) {
    return _BaseInfoPanel(title: 'Getting Started Guide', infoList: _infoList);
  }
}

//! InfoCardButton helper class
class InfoCardButton {
  const InfoCardButton._();

  static void showHomeInfoPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const HomeInfoPanel(),
    );
  }

  static void showKPIInfoPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const KPIInfoPanel(),
    );
  }

  static void showAlertandNotifiInfoPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const NotificationAndAlertInfoPanel(),
    );
  }

  static void showHomeScreenDeviceOnboardingInfoPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const DeviceOnboardingInfoPanel(),
    );
  }

  static void showHomeScreenGroupInfoPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const GroupsInfoPanel(),
    );
  }

  static void showSettingInfoPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SettingInfoPanel(),
    );
  }

  static void showDashboardInfoPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const DashBoardInfoPanel(),
    );
  }

  static void showTrackingInfoPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const TrackingInfoPanel(),
    );
  }
}
