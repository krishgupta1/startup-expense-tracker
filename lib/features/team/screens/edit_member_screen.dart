import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditMemberScreen extends StatefulWidget {
  const EditMemberScreen({super.key});

  @override
  State<EditMemberScreen> createState() => _EditMemberScreenState();
}

class _EditMemberScreenState extends State<EditMemberScreen> {
  late TextEditingController _nameController;
  late TextEditingController _roleController;
  late TextEditingController _emailController;
  
  String _selectedTeam = "Engineering";
  String _status = "Active";
  
  final List<String> _teams = ["Engineering", "Marketing", "Design", "Sales"];
  final List<String> _statuses = ["Active", "Paused", "On Leave"];

  @override
  void initState() {
    super.initState();
    // Pre-fill with mock data
    _nameController = TextEditingController(text: "James Carter");
    _roleController = TextEditingController(text: "Lead Engineer");
    _emailController = TextEditingController(text: "james.carter@company.com");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09090B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF09090B),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Edit Profile", style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600)),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("SAVE", style: GoogleFonts.inter(color: const Color(0xFF0A84FF), fontWeight: FontWeight.bold)),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
             // Avatar Edit
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 100, height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: const DecorationImage(image: NetworkImage("https://i.pravatar.cc/150?img=11"), fit: BoxFit.cover),
                    border: Border.all(color: Colors.white12),
                  ),
                ),
                Container(
                  width: 100, height: 100,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black.withOpacity(0.5)),
                  child: const Icon(Icons.camera_alt, color: Colors.white),
                )
              ],
            ),
            const SizedBox(height: 32),
            
            _buildInput("FULL NAME", _nameController),
            const SizedBox(height: 24),
            _buildInput("JOB TITLE", _roleController),
            const SizedBox(height: 24),
            _buildInput("EMAIL", _emailController),
            const SizedBox(height: 24),
            
            // Team Dropdown
            _buildDropdown("TEAM", _selectedTeam, _teams, (val) => setState(() => _selectedTeam = val!)),
            const SizedBox(height: 24),
             // Status Dropdown
            _buildDropdown("STATUS", _status, _statuses, (val) => setState(() => _status = val!)),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(color: const Color(0xFF141416), borderRadius: BorderRadius.circular(12)),
          child: TextField(
            controller: controller,
            style: GoogleFonts.inter(color: Colors.white),
            decoration: const InputDecoration(border: InputBorder.none),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(color: const Color(0xFF141416), borderRadius: BorderRadius.circular(12)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              dropdownColor: const Color(0xFF1E1E20),
              style: GoogleFonts.inter(color: Colors.white),
              items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
