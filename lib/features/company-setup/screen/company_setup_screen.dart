import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:startup_expense_tracker/features/navigation/screens/navigation_wrapper.dart';

class CompanySetupScreen extends StatefulWidget {
  const CompanySetupScreen({super.key});

  @override
  State<CompanySetupScreen> createState() => _CompanySetupScreenState();
}

class _CompanySetupScreenState extends State<CompanySetupScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 6;

  // Validation State for Categories
  bool _showCategoryError = false;

  // --- CONTROLLERS & STATE ---

  // Step 1: Identity
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Step 2: Legal & Loc
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _workDescController = TextEditingController();
  String _companyType = "Sole Proprietorship";

  // Step 3: Financials
  final TextEditingController _fundingController = TextEditingController();
  final TextEditingController _runwayController = TextEditingController();

  // Step 4: Bank (Dynamic List)
  final List<Map<String, TextEditingController>> _bankAccounts = [
    {"name": TextEditingController(), "number": TextEditingController()},
  ];

  // Step 5: Categories
  final List<String> _allCategories = [
    "Marketing",
    "Server Cost",
    "Office Rent",
    "Legal",
    "Software",
    "Hardware",
    "Travel",
    "Meals",
    "Contractors",
  ];
  final Set<String> _selectedCategories = {};

  // Step 6: Team
  final List<String> _departments = ["Engineering", "Marketing"];
  final TextEditingController _deptController = TextEditingController();

  // --- METHODS ---

  void _addBankAccount() {
    setState(() {
      _bankAccounts.add({
        "name": TextEditingController(),
        "number": TextEditingController(),
      });
    });
  }

  void _removeBankAccount(int index) {
    if (_bankAccounts.length > 1) {
      setState(() {
        _bankAccounts.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09090B), // Deep Matte Black
      resizeToAvoidBottomInset: true,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          child: Column(
            children: [
              // 1. Header (Progress + Back)
              _buildHeader(),

              // 2. Swipeable Content
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (page) {
                    setState(() {
                      _currentPage = page;
                      // Reset error when user swipes away
                      if (page != 4) _showCategoryError = false;
                    });
                  },
                  children: [
                    _buildStep1Identity(),
                    _buildStep2Legal(),
                    _buildStep3Financials(),
                    _buildStep4Bank(),
                    _buildStep5Categories(),
                    _buildStep6Team(),
                  ],
                ),
              ),

              // 3. Navigation Footer
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  // --- PAGES ---

  Widget _buildStep1Identity() {
    return _buildPageContainer(
      title: "Identity",
      subtitle: "Let's start with the basics.",
      children: [
        _buildLabel("OWNER NAME"),
        _buildInputField(_ownerNameController, "Your Full Name"),
        const SizedBox(height: 32),
        _buildLabel("COMPANY NAME"),
        _buildInputField(_companyNameController, "Startup Name"),
        const SizedBox(height: 32),
        _buildLabel("OFFICIAL EMAIL"),
        _buildInputField(_emailController, "admin@company.com"),
      ],
    );
  }

  Widget _buildStep2Legal() {
    return _buildPageContainer(
      title: "Structure",
      subtitle: "Legal details and location.",
      children: [
        _buildLabel("COMPANY TYPE"),
        _buildDropdown(
          ["Sole Proprietorship", "Partnership", "LLP", "Pvt Ltd"],
          _companyType,
          (val) => setState(() => _companyType = val!),
        ),
        const SizedBox(height: 32),
        _buildLabel("WHAT IS THE WORK?"),
        _buildTextArea(_workDescController, "e.g. SaaS Platform..."),
        const SizedBox(height: 32),
        _buildLabel("REGISTERED ADDRESS"),
        _buildTextArea(_addressController, "Full Address..."),
      ],
    );
  }

  Widget _buildStep3Financials() {
    return _buildPageContainer(
      title: "Runway",
      subtitle: "Current financial health.",
      children: [
        Center(
          child: Column(
            children: [
              Text(
                "TOTAL FUNDS LEFT",
                style: GoogleFonts.inter(
                  color: Colors.white24,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              IntrinsicWidth(
                child: TextField(
                  controller: _fundingController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    prefixText: "₹ ",
                    prefixStyle: GoogleFonts.inter(
                      color: Colors.white38,
                      fontSize: 48,
                    ),
                    hintText: "0",
                    hintStyle: GoogleFonts.inter(color: Colors.white12),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 60),
        _buildLabel("TARGET RUNWAY (MONTHS)"),
        _buildInputField(_runwayController, "e.g. 18", isNumber: true),
      ],
    );
  }

  Widget _buildStep4Bank() {
    return _buildPageContainer(
      title: "Banking",
      subtitle: "Add source accounts for tracking.",
      children: [
        ...List.generate(_bankAccounts.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ACCOUNT 0${index + 1}",
                      style: GoogleFonts.inter(
                        color: Colors.white24,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    if (index > 0)
                      GestureDetector(
                        onTap: () => _removeBankAccount(index),
                        child: Text(
                          "REMOVE",
                          style: GoogleFonts.inter(
                            color: const Color(0xFFFF453A),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildInputField(
                  _bankAccounts[index]["name"]!,
                  "Bank Name (e.g. HDFC)",
                ),
                const SizedBox(height: 12),
                _buildInputField(
                  _bankAccounts[index]["number"]!,
                  "Account Number",
                  isNumber: true,
                ),
              ],
            ),
          );
        }),

        // Add Button
        GestureDetector(
          onTap: _addBankAccount,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Text(
                  "Add Another Account",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStep5Categories() {
    return _buildPageContainer(
      title: "Categories",
      subtitle: "What do you spend money on?",
      extraHeader: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: GoogleFonts.inter(
            color: _showCategoryError
                ? const Color(0xFFFF453A)
                : Colors.white38, // Text turns RED on error
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          child: Row(
            children: [
              if (_showCategoryError) ...[
                const Icon(
                  Icons.error_outline,
                  color: Color(0xFFFF453A),
                  size: 14,
                ),
                const SizedBox(width: 6),
              ],
              Text(
                _showCategoryError
                    ? "Please select at least one category"
                    : "Select all that apply",
              ),
            ],
          ),
        ),
      ),
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _allCategories.map((cat) {
            final isSelected = _selectedCategories.contains(cat);
            return GestureDetector(
              onTap: () {
                setState(() {
                  isSelected
                      ? _selectedCategories.remove(cat)
                      : _selectedCategories.add(cat);
                  // Hide error as soon as user selects something
                  if (_selectedCategories.isNotEmpty) {
                    _showCategoryError = false;
                  }
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : const Color(0xFF141416),
                  borderRadius: BorderRadius.circular(24),
                  // BORDER LOGIC SIMPLIFIED: No red border on error, just standard selection
                  border: Border.all(
                    color: isSelected
                        ? Colors.white
                        : Colors.white.withOpacity(0.1),
                  ),
                ),
                child: Text(
                  cat,
                  style: GoogleFonts.inter(
                    color: isSelected ? Colors.black : Colors.white70,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStep6Team() {
    return _buildPageContainer(
      title: "Departments",
      subtitle: "Who spends the money?",
      children: [
        ..._departments.map(
          (dept) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF141416),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.04)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dept,
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _departments.remove(dept)),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white38,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildInputField(_deptController, "Add Dept (e.g. Sales)"),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                if (_deptController.text.isNotEmpty) {
                  setState(() {
                    _departments.add(_deptController.text);
                    _deptController.clear();
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.arrow_upward,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          // Segmented Progress Bar
          Row(
            children: List.generate(_totalPages, (index) {
              return Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: index <= _currentPage
                        ? Colors.white
                        : const Color(0xFF1F1F22),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 24),
          // Clean Navigation Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_currentPage > 0)
                GestureDetector(
                  onTap: () => _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                )
              else
                const SizedBox(width: 24),

              if (_currentPage == 5)
                GestureDetector(
                  onTap: () {
                    // Skip Logic
                  },
                  child: Text(
                    "Skip",
                    style: GoogleFonts.inter(
                      color: Colors.white54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPageContainer({
    required String title,
    required String subtitle,
    required List<Widget> children,
    Widget? extraHeader,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              title,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w600,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: GoogleFonts.inter(color: Colors.white54, fontSize: 16),
            ),
            const SizedBox(height: 24),
            ?extraHeader,
            ...children,
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF09090B).withOpacity(0.0),
            const Color(0xFF09090B),
          ],
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: () {
            // Validation for Categories
            if (_currentPage == 4 && _selectedCategories.isEmpty) {
              setState(() {
                _showCategoryError = true;
              });
              return; // Stop navigation
            }

            // Validation passed or not required
            setState(() => _showCategoryError = false);

            if (_currentPage < _totalPages - 1) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            } else {
              // Finish Logic - Navigate to Homepage
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const NavigationWrapper(),
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          child: Text(
            _currentPage == _totalPages - 1 ? "Finish Setup" : "Next Step",
            style: GoogleFonts.inter(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: Colors.white38,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildInputField(
    TextEditingController controller,
    String hint, {
    bool isNumber = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF141416),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.04)),
      ),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.inter(color: Colors.white24),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  Widget _buildTextArea(TextEditingController controller, String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF141416),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.04)),
      ),
      child: TextField(
        controller: controller,
        maxLines: 3,
        style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.inter(color: Colors.white24),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  Widget _buildDropdown(
    List<String> items,
    String value,
    Function(String?) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF141416),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.04)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: const Color(0xFF1E1E20),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white38),
          style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
