import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class FundsOverviewScreen extends StatelessWidget {
  const FundsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09090B),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                _buildHeader(context),

                const SizedBox(height: 32),

                // Main Funds Card
                _buildMainFundsCard(),

                const SizedBox(height: 32),

                // Bank Accounts
                _buildBankAccountsSection(),

                const SizedBox(height: 32),

                // Funding Milestones
                _buildFundingMilestones(),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF141416),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Funds Overview",
              style: GoogleFonts.inter(
                color: Colors.white38,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Capital Analysis",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMainFundsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF141416),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF30D158).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: const Color(0xFF30D158).withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  "HEALTHY",
                  style: GoogleFonts.inter(
                    color: const Color(0xFF30D158),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                "Last updated: Today",
                style: GoogleFonts.inter(
                  color: Colors.white38,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$482",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 72,
                  fontWeight: FontWeight.w300,
                  height: 1.0,
                  letterSpacing: -3,
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  "thousand",
                  style: GoogleFonts.inter(
                    color: Colors.white38,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Available for Operations",
                  style: GoogleFonts.inter(
                    color: Colors.white38,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "\$439,500 (91% of total)",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBankAccountsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Bank Accounts",
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF141416),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
          ),
          child: Column(
            children: [
              _buildBankAccount(
                "Chase Business",
                "****4582",
                "\$382,000",
                "Primary",
              ),
              const SizedBox(height: 16),
              _buildBankAccount(
                "Wells Fargo",
                "****7821",
                "\$75,000",
                "Reserve",
              ),
              const SizedBox(height: 16),
              _buildBankAccount(
                "Stripe",
                "****9234",
                "\$25,000",
                "Payment Processing",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBankAccount(
    String bank,
    String account,
    String balance,
    String type,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F22),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.account_balance,
              color: Colors.white38,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bank,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "$account • $type",
                  style: GoogleFonts.inter(
                    color: Colors.white38,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Text(
            balance,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFeatures: [const FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFundingMilestones() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Business Goals",
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF141416),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
          ),
          child: Column(
            children: [
              _buildMilestone(
                "Series A Target",
                "\$2,000,000",
                "Q2 2025",
                "In Progress",
              ),
              const SizedBox(height: 16),
              _buildMilestone(
                "Break-even Revenue",
                "\$50,000/mo",
                "Q4 2025",
                "On Track",
              ),
              const SizedBox(height: 16),
              _buildMilestone(
                "Team Expansion",
                "15 employees",
                "Q1 2025",
                "Completed",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMilestone(
    String title,
    String target,
    String timeline,
    String status,
  ) {
    Color statusColor = status == "Completed"
        ? const Color(0xFF30D158)
        : status == "On Track"
        ? const Color(0xFF30D158)
        : const Color(0xFFFF9F0A);

    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "$target • $timeline",
                style: GoogleFonts.inter(
                  color: Colors.white38,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: statusColor.withValues(alpha: 0.3)),
          ),
          child: Text(
            status,
            style: GoogleFonts.inter(
              color: statusColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }
}
