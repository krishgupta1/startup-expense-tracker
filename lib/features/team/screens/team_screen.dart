import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'create_team_screen.dart';
import 'team_detail_screen.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  // 1. Search State
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  bool _isSearching = false;

  // 2. Data Source
  final List<Map<String, dynamic>> _allTeams = [
    {
      "name": "Engineering",
      "members": "12 Members",
      "cost": "\$62,400",
      "icon": Icons.code,
      "color": const Color(0xFF0A84FF),
      "avatars": [
        "https://i.pravatar.cc/150?img=11",
        "https://i.pravatar.cc/150?img=3",
        "https://i.pravatar.cc/150?img=68",
      ],
    },
    {
      "name": "Marketing",
      "members": "5 Members",
      "cost": "\$18,200",
      "icon": Icons.campaign_outlined,
      "color": const Color(0xFFFF9F0A),
      "avatars": [
        "https://i.pravatar.cc/150?img=9",
        "https://i.pravatar.cc/150?img=47",
      ],
    },
    {
      "name": "Product Design",
      "members": "4 Members",
      "cost": "\$22,000",
      "icon": Icons.brush_outlined,
      "color": const Color(0xFFA259FF),
      "avatars": ["https://i.pravatar.cc/150?img=5"],
    },
    {
      "name": "Sales",
      "members": "8 Members",
      "cost": "\$35,500",
      "icon": Icons.attach_money,
      "color": const Color(0xFF30D158),
      "avatars": [
        "https://i.pravatar.cc/150?img=12",
        "https://i.pravatar.cc/150?img=33",
      ],
    },
  ];

  // 3. Filter Logic
  List<Map<String, dynamic>> get _filteredTeams {
    if (_searchQuery.isEmpty) return _allTeams;
    return _allTeams
        .where(
          (team) => team['name'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09090B), // Deep Matte Black
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header with Search
                _buildHeader(),

                const SizedBox(height: 32),

                // 2. AI Insight (Hide when searching to save space)
                if (!_isSearching) ...[
                  _buildAIPill(),
                  const SizedBox(height: 32),
                ],

                // 3. Teams List Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSectionTitle(
                      _isSearching ? "SEARCH RESULTS" : "YOUR TEAMS",
                    ),
                    if (!_isSearching)
                      const Icon(Icons.sort, color: Colors.white24, size: 20),
                  ],
                ),
                const SizedBox(height: 16),

                // 4. Filtered List
                _filteredTeams.isEmpty
                    ? _buildEmptyState()
                    : _buildTeamsList(context),

                const SizedBox(height: 80), // Bottom padding
              ],
            ),
          ),
        ),
      ),
      // Quick Action Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateTeamScreen()),
          );
        },
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        icon: const Icon(Icons.add),
        label: Text(
          "New Team",
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Title or Active Search Bar
        Expanded(
          child: _isSearching
              ? _buildActiveSearchBar()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Organization",
                      style: GoogleFonts.inter(
                        color: Colors.white38,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Teams Overview",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -1,
                      ),
                    ),
                  ],
                ),
        ),

        // Search Toggle Button (only show if not already searching)
        if (!_isSearching)
          GestureDetector(
            onTap: () {
              setState(() {
                _isSearching = true;
              });
            },
            child: Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF141416),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.04)),
              ),
              child: const Icon(Icons.search, color: Colors.white, size: 20),
            ),
          ),
      ],
    );
  }

  Widget _buildActiveSearchBar() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF141416),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.white54, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _searchController,
              autofocus: true,
              style: GoogleFonts.inter(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search teams...",
                hintStyle: GoogleFonts.inter(color: Colors.white24),
                border: InputBorder.none,
                isDense: true,
              ),
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                });
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _isSearching = false;
                _searchQuery = "";
                _searchController.clear();
              });
            },
            child: const Icon(Icons.close, color: Colors.white54, size: 20),
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
                "STAFFING INSIGHT",
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
            "Engineering costs have risen by 12% due to new hires. Marketing is currently under budget.",
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        color: Colors.white24,
        fontSize: 10,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildTeamsList(BuildContext context) {
    return Column(
      children: _filteredTeams
          .map((team) => _buildTeamCard(context, team))
          .toList(),
    );
  }

  Widget _buildTeamCard(BuildContext context, Map<String, dynamic> team) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TeamDetailScreen()),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF141416),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.04)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: (team['color'] as Color).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          team['icon'],
                          color: team['color'],
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            team['name'],
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            team['members'],
                            style: GoogleFonts.inter(
                              color: Colors.white54,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: Colors.white24,
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Divider(color: Colors.white.withOpacity(0.04), height: 1),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Avatar Pile
                  _buildAvatarPile(team['avatars']),

                  // Monthly Cost
                  Row(
                    children: [
                      Text(
                        "Monthly: ",
                        style: GoogleFonts.inter(
                          color: Colors.white38,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        team['cost'],
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarPile(List<String> images) {
    return SizedBox(
      height: 24,
      width: 100, // Fixed width to allow stacking
      child: Stack(
        children: List.generate(images.length > 3 ? 3 : images.length, (index) {
          return Positioned(
            left: index * 18.0, // Overlap amount
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF141416),
                  width: 2,
                ), // Cutout effect
                image: DecorationImage(
                  image: NetworkImage(images[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            const Icon(Icons.search_off, color: Colors.white12, size: 48),
            const SizedBox(height: 16),
            Text(
              "No teams found",
              style: GoogleFonts.inter(color: Colors.white38, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
