import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_team_screen.dart';
import 'add_member_screen.dart';
import 'member_detail_screen.dart';

class TeamDetailScreen extends StatefulWidget {
  const TeamDetailScreen({super.key});

  @override
  State<TeamDetailScreen> createState() => _TeamDetailScreenState();
}

class _TeamDetailScreenState extends State<TeamDetailScreen> {
  // Mock Data
  final String teamName = "Engineering";
  final String monthlyCost = "\$42,500";
  final String memberCount = "8 Members";

  final List<Map<String, dynamic>> _members = [
    {
      "name": "James Carter",
      "role": "Lead Engineer",
      "salary": "\$12k/mo",
      "status": "Active",
      "img": "https://i.pravatar.cc/150?img=11",
    },
    {
      "name": "Sarah Miller",
      "role": "Frontend Dev",
      "salary": "\$8.5k/mo",
      "status": "Active",
      "img": "https://i.pravatar.cc/150?img=5",
    },
    {
      "name": "Michael Brown",
      "role": "Backend Dev",
      "salary": "\$9k/mo",
      "status": "Paused",
      "img": "https://i.pravatar.cc/150?img=3",
    },
    {
      "name": "David Wilson",
      "role": "DevOps",
      "salary": "\$7k/mo",
      "status": "Active",
      "img": "https://i.pravatar.cc/150?img=15",
    },
    {
      "name": "Emma Davis",
      "role": "QA Engineer",
      "salary": "\$6k/mo",
      "status": "Active",
      "img": "https://i.pravatar.cc/150?img=9",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09090B), // Deep Matte Black
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // 1. Header
              _buildHeader(context),

              // 2. Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),

                      // --- HERO STATS ---
                      _buildHeroStats(),

                      const SizedBox(height: 32),

                      // --- AI INSIGHT ---
                      _buildAIPill(),

                      const SizedBox(height: 40),

                      // --- MEMBERS LIST HEADER ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "TEAM MEMBERS",
                            style: GoogleFonts.inter(
                              color: Colors.white24,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                          Text(
                            "SORT BY COST",
                            style: GoogleFonts.inter(
                              color: Colors.white24,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // --- MEMBERS LIST ---
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _members.length,
                        itemBuilder: (context, index) {
                          return _buildMemberRow(_members[index]);
                        },
                      ),

                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // ADD MEMBER BUTTON
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddMemberScreen()),
          );
        },
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        icon: const Icon(Icons.person_add_alt_1_rounded),
        label: Text(
          "Add Member",
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF141416),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white.withOpacity(0.04)),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),

          Column(
            children: [
              Text(
                teamName,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                memberCount,
                style: GoogleFonts.inter(color: Colors.white38, fontSize: 12),
              ),
            ],
          ),

          // Settings / More for Team
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditTeamScreen()),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF141416),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white.withOpacity(0.04)),
              ),
              child: const Icon(
                Icons.settings_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroStats() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF141416),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.04)),
      ),
      child: Column(
        children: [
          Text(
            "TOTAL MONTHLY COST",
            style: GoogleFonts.inter(
              color: Colors.white38,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            monthlyCost,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.w600,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF0A84FF).withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Within Budget",
              style: GoogleFonts.inter(
                color: const Color(0xFF0A84FF),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIPill() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.auto_awesome,
                color: Color(0xFF0A84FF),
                size: 16,
              ),
              const SizedBox(width: 12),
              Text(
                "TEAM INSIGHT",
                style: GoogleFonts.inter(
                  color: const Color(0xFF0A84FF),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Backend development costs are 20% higher than industry average. Consider optimizing resource allocation.",
            style: GoogleFonts.inter(
              color: Colors.white70,
              fontSize: 14,
              height: 1.5,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberRow(Map<String, dynamic> member) {
    bool isPaused = member['status'] == 'Paused';

    return GestureDetector(
      // On Tap could go to dedicated member page later
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MemberDetailScreen()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF141416),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.04)),
          ),
          child: Row(
            children: [
              // Avatar
              Stack(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(member['img']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: isPaused
                            ? const Color(0xFFFF9F0A)
                            : const Color(0xFF30D158),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF141416),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member['name'],
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      member['role'],
                      style: GoogleFonts.inter(
                        color: Colors.white38,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Cost & Menu
              Row(
                children: [
                  Text(
                    member['salary'],
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.white24,
                      size: 20,
                    ),
                    onPressed: () =>
                        _showMemberOptions(context, member['name']),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- ACTIONS BOTTOM SHEET (SIMPLIFIED) ---
  void _showMemberOptions(BuildContext context, String memberName) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF141416),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "Manage $memberName",
                  style: GoogleFonts.inter(
                    color: Colors.white38,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 24),

                // Only Pause and Remove options as requested
                _buildActionOption(
                  Icons.pause_circle_outline,
                  "Pause Member",
                  () {
                    Navigator.pop(context);
                    // Add Pause Logic
                  },
                ),

                const SizedBox(height: 16),

                _buildActionOption(
                  Icons.person_remove_outlined,
                  "Remove from Team",
                  () {
                    Navigator.pop(context);
                    // Add Remove Logic
                  },
                  isDestructive: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionOption(
    IconData icon,
    String label,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        color: Colors.transparent, // Ensure hit test works on full width
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? const Color(0xFFFF453A) : Colors.white,
              size: 22,
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: GoogleFonts.inter(
                color: isDestructive ? const Color(0xFFFF453A) : Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
