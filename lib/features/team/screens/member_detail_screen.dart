import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_member_screen.dart';
import 'adjust_salary_screen.dart';

class MemberDetailScreen extends StatelessWidget {
  const MemberDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    const String name = "James Carter";
    const String role = "Lead Engineer";
    const String team = "Engineering";
    const String status = "Active";
    const String salary = "\$12,000";
    const String email = "james.carter@company.com";
    const String avatar = "https://i.pravatar.cc/150?img=11";

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
                    children: [
                      const SizedBox(height: 24),

                      // --- PROFILE HERO ---
                      _buildProfileHero(name, role, team, avatar, status),

                      const SizedBox(height: 32),

                      // --- FINANCIAL HERO ---
                      _buildCostCard(salary),

                      const SizedBox(height: 32),

                      // --- AI INSIGHT ---
                      _buildAIPill(),

                      const SizedBox(height: 32),

                      // --- DETAILS SECTION ---
                      _buildSectionTitle("EMPLOYMENT DETAILS"),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: const Color(0xFF141416),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.04),
                          ),
                        ),
                        child: Column(
                          children: [
                            _buildDetailRow(
                              "Email",
                              email,
                              Icons.email_outlined,
                            ),
                            _buildDivider(),
                            _buildDetailRow(
                              "Joined",
                              "Aug 12, 2023",
                              Icons.calendar_today,
                            ),
                            _buildDivider(),
                            _buildDetailRow(
                              "Type",
                              "Full-time",
                              Icons.badge_outlined,
                            ),
                            _buildDivider(),
                            _buildDetailRow(
                              "Location",
                              "Remote (NY)",
                              Icons.location_on_outlined,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // --- RECENT PAYOUTS ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildSectionTitle("PAYMENT HISTORY"),
                          Text(
                            "VIEW ALL",
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
                      _buildPaymentHistory(),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
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

          Text(
            "Member Profile",
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          // More Actions (Edit, Fire, Pause)
          GestureDetector(
            onTap: () => _showMemberActionSheet(context),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF141416),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white.withOpacity(0.04)),
              ),
              child: const Icon(
                Icons.more_horiz,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHero(
    String name,
    String role,
    String team,
    String avatarUrl,
    String status,
  ) {
    Color statusColor = status == "Active"
        ? const Color(0xFF30D158)
        : const Color(0xFFFF9F0A);

    return Column(
      children: [
        // Avatar with Ring
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: statusColor.withOpacity(0.5), width: 2),
            image: DecorationImage(
              image: NetworkImage(avatarUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          name,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "$role • $team",
          style: GoogleFonts.inter(
            color: Colors.white54,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        // Status Pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: statusColor.withOpacity(0.2)),
          ),
          child: Text(
            status.toUpperCase(),
            style: GoogleFonts.inter(
              color: statusColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCostCard(String salary) {
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
            "MONTHLY COST",
            style: GoogleFonts.inter(
              color: Colors.white38,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            salary,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w600,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.trending_flat, color: Colors.white38, size: 16),
              const SizedBox(width: 6),
              Text(
                "No change from last month",
                style: GoogleFonts.inter(color: Colors.white38, fontSize: 12),
              ),
            ],
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
                "PERFORMANCE INSIGHT",
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
            "James's cost efficiency is in the top 10% of engineers. Market rate for this role is currently \$14k/mo.",
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

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.white38, size: 20),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.white38,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Divider(color: Colors.white.withOpacity(0.04), height: 1),
    );
  }

  Widget _buildPaymentHistory() {
    // Mock List
    final payments = [
      {"date": "Nov 01, 2024", "amt": "\$12,000"},
      {"date": "Oct 01, 2024", "amt": "\$12,000"},
      {"date": "Sep 01, 2024", "amt": "\$12,000"},
    ];

    return Column(
      children: payments.map((p) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFF141416),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.04)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.arrow_outward,
                        color: Colors.white54,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Salary Payout",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      p['amt']!,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      p['date']!,
                      style: GoogleFonts.inter(
                        color: Colors.white38,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: GoogleFonts.inter(
          color: Colors.white24,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  // --- ACTIONS BOTTOM SHEET ---
  void _showMemberActionSheet(BuildContext context) {
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
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 32),

                // 1. EDIT PROFILE -> Navigates to Edit Screen
                _buildActionOption(Icons.edit_outlined, "Edit Profile", () {
                  Navigator.pop(context); // Close sheet
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditMemberScreen(),
                    ),
                  );
                }),
                const SizedBox(height: 16),

                // 2. ADJUST SALARY -> Navigates to Salary Screen
                _buildActionOption(Icons.attach_money, "Adjust Salary", () {
                  Navigator.pop(context); // Close sheet
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdjustSalaryScreen(),
                    ),
                  );
                }),
                const SizedBox(height: 16),

                // 3. PAUSE MEMBER -> Shows Snackbar/Confirmation
                _buildActionOption(
                  Icons.pause_circle_outline,
                  "Pause Member",
                  () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: const Color(0xFF141416),
                        content: Text(
                          "Member paused. Payroll suspended.",
                          style: GoogleFonts.inter(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24),
                const Divider(color: Colors.white10),
                const SizedBox(height: 16),

                // 4. REMOVE MEMBER -> Shows Dialog
                _buildActionOption(
                  Icons.person_remove_outlined,
                  "Remove Member",
                  () {
                    Navigator.pop(context);
                    _showDeleteConfirmation(context);
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
        padding: const EdgeInsets.symmetric(vertical: 8),
        color: Colors.transparent,
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

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF141416),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          "Remove Member?",
          style: GoogleFonts.inter(color: Colors.white),
        ),
        content: Text(
          "This will remove James Carter from the team and archive all payment history.",
          style: GoogleFonts.inter(color: Colors.white54),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "CANCEL",
              style: GoogleFonts.inter(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              // Delete Logic Here
              Navigator.pop(context); // Close Dialog
              Navigator.pop(context); // Go back to Team List
            },
            child: Text(
              "REMOVE",
              style: GoogleFonts.inter(color: const Color(0xFFFF453A)),
            ),
          ),
        ],
      ),
    );
  }
}
