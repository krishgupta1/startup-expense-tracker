import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final payments = [
      {"date": "Nov 01, 2024", "amt": "\$12,000", "status": "Completed"},
      {"date": "Oct 01, 2024", "amt": "\$12,000", "status": "Completed"},
      {"date": "Sep 01, 2024", "amt": "\$12,000", "status": "Completed"},
      {"date": "Aug 01, 2024", "amt": "\$12,000", "status": "Completed"},
      {"date": "Jul 01, 2024", "amt": "\$12,000", "status": "Completed"},
      {"date": "Jun 01, 2024", "amt": "\$11,500", "status": "Completed"},
      {"date": "May 01, 2024", "amt": "\$11,500", "status": "Completed"},
      {"date": "Apr 01, 2024", "amt": "\$11,000", "status": "Completed"},
      {"date": "Mar 01, 2024", "amt": "\$11,000", "status": "Completed"},
      {"date": "Feb 01, 2024", "amt": "\$10,500", "status": "Completed"},
      {"date": "Jan 01, 2024", "amt": "\$10,500", "status": "Completed"},
      {"date": "Dec 01, 2023", "amt": "\$10,000", "status": "Completed"},
    ];

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

              // 2. Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 32),

                      // --- SUMMARY CARD ---
                      _buildSummaryCard(payments),

                      const SizedBox(height: 32),

                      // --- PAYMENT LIST ---
                      _buildPaymentList(payments),

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
                border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),

          Text(
            "Payment History",
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          // Export Button
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: const Color(0xFF141416),
                  content: Text(
                    "Export feature coming soon",
                    style: GoogleFonts.inter(color: Colors.white),
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF141416),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
              ),
              child: const Icon(Icons.download, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(List<Map<String, String>> payments) {
    final totalPaid = payments.fold<int>(
      0,
      (sum, payment) =>
          sum + int.parse(payment['amt']!.replaceAll(RegExp(r'[^0-9]'), '')),
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF141416),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "TOTAL PAID (12 MONTHS)",
            style: GoogleFonts.inter(
              color: Colors.white38,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "\$${totalPaid.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w600,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF30D158).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "All payments completed",
                  style: GoogleFonts.inter(
                    color: const Color(0xFF30D158),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentList(List<Map<String, String>> payments) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("ALL PAYMENTS"),
        const SizedBox(height: 16),
        Column(
          children: payments.map((payment) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF141416),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.04),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.arrow_outward,
                            color: Colors.white54,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Salary Payout",
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              payment['date']!,
                              style: GoogleFonts.inter(
                                color: Colors.white38,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          payment['amt']!,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF30D158,
                            ).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            payment['status']!,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF30D158),
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
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
}
