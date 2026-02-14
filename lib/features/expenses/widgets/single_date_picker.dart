import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SingleDatePicker extends StatefulWidget {
  const SingleDatePicker({super.key});

  @override
  State<SingleDatePicker> createState() => _SingleDatePickerState();
}

class _SingleDatePickerState extends State<SingleDatePicker> {
  ShadDateTimeRange? _selectedRange;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF141416),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Select Date Range",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Date Range Picker
            ShadDateRangePickerFormField(
              label: const Text('Select date range'),
              initialValue: _selectedRange, // Set initial value
              onChanged: (ShadDateTimeRange? range) {
                setState(() {
                  _selectedRange = range;
                });
              },
              validator: (ShadDateTimeRange? range) {
                if (range == null) return 'Please select a date range';
                return null;
              },
            ),

            // Display selected range below picker for better UX
            if (_selectedRange != null) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A84FF).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Selected: ${_selectedRange != null ? '${_formatDate(_selectedRange!.start)} - ${_formatDate(_selectedRange!.end)}' : 'No range selected'}",
                  style: GoogleFonts.inter(
                    color: const Color(0xFF0A84FF),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF141416),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.08),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.inter(
                            color: Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (_selectedRange != null) {
                        Navigator.pop(context, _selectedRange);
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0A84FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "Apply",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }
}
