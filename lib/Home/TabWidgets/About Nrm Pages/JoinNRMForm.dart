import 'package:flutter/material.dart';

class JoinNRMForm extends StatefulWidget {
  const JoinNRMForm({super.key});

  @override
  State<JoinNRMForm> createState() => _JoinNRMFormState();
}

class _JoinNRMFormState extends State<JoinNRMForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _otherNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ninController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController _subCountyController = TextEditingController();
  final TextEditingController _parishController = TextEditingController();
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();

  // Gender and political party
  String? _selectedGender;
  String? _selectedPoliticalParty;

  // Checkbox
  bool _agreedToTerms = false;

  // Date picker
  Future<void> _pickDate(TextEditingController controller) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      controller.text = "${date.day}/${date.month}/${date.year}";
    }
  }

  @override
  void dispose() {
    _surnameController.dispose();
    _otherNameController.dispose();
    _phoneController.dispose();
    _ninController.dispose();
    _districtController.dispose();
    _villageController.dispose();
    _subCountyController.dispose();
    _parishController.dispose();
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Join NRM'),
        backgroundColor: const Color(0xFFFFD401),
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'Welcome to NRM registry, Please fill in your personal details below to continue',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Surname and Other Name side by side
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _surnameController,
                      decoration: InputDecoration(
                        labelText: 'Surname',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator:
                          (value) => value!.isEmpty ? 'Enter surname' : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _otherNameController,
                      decoration: InputDecoration(
                        labelText: 'Other Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator:
                          (value) => value!.isEmpty ? 'Enter other name' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Phone
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator:
                    (value) => value!.isEmpty ? 'Enter phone number' : null,
              ),
              const SizedBox(height: 16),

              // NIN
              TextFormField(
                controller: _ninController,
                decoration: InputDecoration(
                  labelText: 'National ID (NIN)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) => value!.isEmpty ? 'Enter NIN' : null,
              ),
              const SizedBox(height: 16),

              // Gender dropdown
              DropdownButtonFormField<String>(
                value: _selectedGender,
                items:
                    ['Male', 'Female']
                        .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                        .toList(),
                onChanged: (value) => setState(() => _selectedGender = value),
                decoration: InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) => value == null ? 'Select gender' : null,
              ),
              const SizedBox(height: 16),

              // District, Village, Sub County, Parish
              TextFormField(
                controller: _districtController,
                decoration: InputDecoration(
                  labelText: 'District',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _villageController,
                decoration: InputDecoration(
                  labelText: 'Village',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _subCountyController,
                decoration: InputDecoration(
                  labelText: 'Sub County',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _parishController,
                decoration: InputDecoration(
                  labelText: 'Parish',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Previous NRM membership
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'Have you ever been NRM party before? If yes, specify the time period below',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _fromDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'From',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      onTap: () => _pickDate(_fromDateController),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _toDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'To',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      onTap: () => _pickDate(_toDateController),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Other party
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'Have you ever been in any other party before? If yes, specify the party below',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedPoliticalParty,
                items:
                    ["People Power", "Democratic Party", "Forum for Democratic Change", "Conservative Party",
                      "People's Development Party", "Alliance for National Transformation", "Federal Democratic Party", "Uganda People's Movement",
                      "Justice Forum", "Labour Party", "Uganda People's Congress", "Uganda Federal Alliance"
                        ]
                        .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                        .toList(),
                onChanged:
                    (value) => setState(() => _selectedPoliticalParty = value),
                decoration: InputDecoration(
                  labelText: 'Select Political Party',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Terms and conditions
              Row(
                children: [
                  Checkbox(
                    value: _agreedToTerms,
                    onChanged:
                        (value) => setState(() => _agreedToTerms = value!),
                  ),
                  const Expanded(
                    child: Text(
                      'I have read and agreed to NRM terms and conditions',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Join Button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() && _agreedToTerms) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Form submitted!')),
                        );
                      } else if (!_agreedToTerms) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please agree to the terms and conditions',
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: const Color(0xFFFFD401),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Join',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
