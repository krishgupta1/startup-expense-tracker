import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'expense_details_screen.dart';

class SearchExpenseScreen extends StatefulWidget {
  const SearchExpenseScreen({super.key});

  @override
  State<SearchExpenseScreen> createState() => _SearchExpenseScreenState();
}

class _SearchExpenseScreenState extends State<SearchExpenseScreen> {
  // 1. FILTER STATE
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  // 2. FILTER OPTIONS
  final years = {'2024': '2024', '2023': '2023', '2022': '2022'};
  final months = {
    'all': 'All',
    'jan': 'Jan',
    'feb': 'Feb',
    'mar': 'Mar',
    'apr': 'Apr',
    'may': 'May',
    'jun': 'Jun',
    'jul': 'Jul',
    'aug': 'Aug',
    'sep': 'Sep',
    'oct': 'Oct',
    'nov': 'Nov',
    'dec': 'Dec',
  };
  final categories = {
    'all': 'All',
    'infrastructure': 'Infrastructure',
    'software': 'Software',
    'office': 'Office',
    'marketing': 'Marketing',
    'meals': 'Meals',
  };

  String _selectedYear = "2024";
  String _selectedMonth = "nov"; // Default to current month
  String _selectedCategory = "all";

  // 3. MOCK DATA (With formatted dates)
  final List<Map<String, dynamic>> _allTransactions = [
    {
      "title": "AWS Server",
      "cat": "Infrastructure",
      "amt": "240.00",
      "date": "Nov 24, 2024",
    },
    {
      "title": "Figma Pro",
      "cat": "Software",
      "amt": "45.00",
      "date": "Nov 23, 2024",
    },
    {
      "title": "WeWork",
      "cat": "Office",
      "amt": "850.00",
      "date": "Nov 22, 2024",
    },
    {
      "title": "Uber Business",
      "cat": "Transport",
      "amt": "24.50",
      "date": "Nov 21, 2024",
    },
    {
      "title": "Slack",
      "cat": "Software",
      "amt": "12.00",
      "date": "Oct 20, 2024",
    },
    {
      "title": "Google Ads",
      "cat": "Marketing",
      "amt": "500.00",
      "date": "Oct 19, 2024",
    },
    {
      "title": "Client Dinner",
      "cat": "Meals",
      "amt": "120.00",
      "date": "Sep 18, 2024",
    },
    {
      "title": "Apple Store",
      "cat": "Infrastructure",
      "amt": "2200.00",
      "date": "Nov 15, 2023",
    }, // Old year
  ];

  // 4. FILTER LOGIC
  List<Map<String, dynamic>> get _filteredTransactions {
    return _allTransactions.where((tx) {
      final dateStr = tx["date"] as String; // e.g., "Nov 24, 2024"

      // Text Search
      final matchesQuery = tx["title"].toString().toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );

      // Category Filter
      final matchesCategory =
          _selectedCategory == "All" || tx["cat"] == _selectedCategory;

      // Year Filter
      final matchesYear = dateStr.contains(_selectedYear);

      // Month Filter
      final matchesMonth =
          _selectedMonth == "All" || dateStr.startsWith(_selectedMonth);

      return matchesQuery && matchesCategory && matchesYear && matchesMonth;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09090B), // Deep Matte Black
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          child: Column(
            children: [
              // --- HEADER & SEARCH ---
              Container(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Filter Expenses",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFF141416),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.04),
                              ),
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

                    // Search Bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF141416),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.04),
                        ),
                      ),
                      child: TextField(
                        controller: _searchController,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        cursorColor: const Color(0xFF30D158),
                        decoration: InputDecoration(
                          hintText: "Search title...",
                          hintStyle: GoogleFonts.inter(color: Colors.white24),
                          border: InputBorder.none,
                          icon: const Icon(
                            Icons.search,
                            color: Colors.white38,
                            size: 20,
                          ),
                        ),
                        onChanged: (val) => setState(() => _searchQuery = val),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // --- FILTERS SECTION ---
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    // YEAR SELECTOR
                    _buildDropdownTrigger(
                      label: "Year: ${years[_selectedYear]}",
                      onTap: () => _showBottomSheet(years.keys.toList(), (val) {
                        setState(() => _selectedYear = val);
                      }),
                    ),
                    const SizedBox(width: 12),

                    // MONTH SELECTOR
                    _buildHorizontalSelector(
                      months.keys.toList(),
                      _selectedMonth,
                      (val) {
                        setState(() => _selectedMonth = val);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // CATEGORY CHIPS
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final cat = categories.keys.toList()[index];
                    final isSelected = _selectedCategory == cat;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedCategory = cat),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF141416),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? Colors.white
                                : Colors.white.withOpacity(0.04),
                          ),
                        ),
                        child: Text(
                          categories[cat]!,
                          style: GoogleFonts.inter(
                            color: isSelected ? Colors.black : Colors.white54,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),
              const Divider(color: Color(0xFF1F1F22), height: 1),

              // --- RESULTS LIST ---
              Expanded(
                child: _filteredTransactions.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.all(24),
                        physics: const BouncingScrollPhysics(),
                        itemCount: _filteredTransactions.length,
                        itemBuilder: (context, index) {
                          final tx = _filteredTransactions[index];
                          return _buildTransactionRow(tx);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGETS ---

  Widget _buildDropdownTrigger({
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF141416),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white54,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalSelector(
    List<String> items,
    String selected,
    Function(String) onSelect,
  ) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(width: 8),
      itemBuilder: (context, index) {
        // Only showing first 4 months for demo space in horizontal list logic
        // In real app, remove shrinkWrap/physics to scroll all months
        if (index > 4 && selected != items[index]) {
          return const SizedBox.shrink();
        }

        final item = items[index];
        final isSelected = selected == item;
        return GestureDetector(
          onTap: () => onSelect(item),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF30D158).withOpacity(0.15)
                  : const Color(0xFF141416),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF30D158)
                    : Colors.white.withOpacity(0.04),
              ),
            ),
            child: Text(
              months[item]!,
              style: GoogleFonts.inter(
                color: isSelected ? const Color(0xFF30D158) : Colors.white54,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTransactionRow(Map<String, dynamic> tx) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ExpenseDetailsScreen()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF141416),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.04)),
              ),
              child: const Icon(Icons.receipt, color: Colors.white38, size: 20),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tx["title"],
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "${tx["cat"]} • ${tx["date"]}",
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
              "-\$${tx["amt"]}",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontFeatures: [const FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.filter_list_off, color: Colors.white12, size: 48),
          const SizedBox(height: 16),
          Text(
            "No expenses found",
            style: GoogleFonts.inter(color: Colors.white38, fontSize: 14),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(List<String> items, Function(String) onSelect) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF141416),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 20),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                items[index],
                style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              onTap: () {
                onSelect(items[index]);
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}
