import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyAssurancesScreen extends StatelessWidget {
  const PrivacyAssurancesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09090B), // Deep Matte Black
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header
                _buildHeader(context, "Privacy Assurances"),

                const SizedBox(height: 32),

                // 2. Hero Section
                Text(
                  "Your data belongs to you.",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "We believe financial privacy is a fundamental right. Here is exactly how we handle your information.",
                  style: GoogleFonts.inter(
                    color: Colors.white54,
                    fontSize: 15,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 40),

                // 3. Assurance Cards
                _buildSectionLabel("SECURITY STANDARDS"),
                _buildAssuranceCard(
                  Icons.lock_outline,
                  "Zero-Knowledge Encryption",
                  "Your data is encrypted on your device before it reaches our servers. Only you hold the keys.",
                ),
                const SizedBox(height: 16),
                _buildAssuranceCard(
                  Icons.visibility_off_outlined,
                  "No Ad Tracking",
                  "We do not sell, rent, or share your personal data with advertisers or third parties.",
                ),
                const SizedBox(height: 16),
                _buildAssuranceCard(
                  Icons.storage,
                  "Data Residency",
                  "All your financial records are stored in enterprise-grade data centers within your region (India).",
                ),
                const SizedBox(height: 16),
                _buildAssuranceCard(
                  Icons.delete_outline,
                  "Right to Erasure",
                  "Delete your account and every single byte of your data is permanently wiped from our backups instantly.",
                ),

                const SizedBox(height: 40),

                // 4. Certification Badge (Visual Trust)
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF30D158).withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF30D158).withOpacity(0.05),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Color(0xFF30D158),
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "SOC2 Compliant & ISO 27001 Certified",
                          style: GoogleFonts.inter(
                            color: const Color(0xFF30D158),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
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
      ),
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildHeader(BuildContext context, String title) {
    return Row(
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
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          title,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20, // Matched with Settings Page
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 4),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: Colors.white24,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildAssuranceCard(IconData icon, String title, String desc) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF141416),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.04)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Container matching other pages
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  desc,
                  style: GoogleFonts.inter(
                    color: Colors.white54,
                    fontSize: 13,
                    height: 1.5,
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
