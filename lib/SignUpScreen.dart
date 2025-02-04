import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  static String? registeredEmail;
  static String? registeredPassword;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _errorMessage;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Email validation using a regular expression.
  bool _isValidEmail(String email) {
    final emailRegex =
    RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(email);
  }

  // Display error message using SnackBar.
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  Future<void> _signUp() async {
    // Ensure all fields are filled.
    if (_firstNameController.text.trim().isEmpty ||
        _lastNameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty ||
        _confirmPasswordController.text.trim().isEmpty ||
        _phoneController.text.trim().isEmpty) {
      _showError("Please fill in all fields.");
      return;
    }

    // Validate email format.
    if (!_isValidEmail(_emailController.text.trim())) {
      _showError('Please enter a valid email address.');
      return;
    }

    // Validate phone number: exactly 12 digits.
    if (_phoneController.text.trim().length != 12 ||
        !_phoneController.text.trim().contains(RegExp(r'^[0-9]+$'))) {
      _showError('Phone number must be exactly 12 digits.');
      return;
    }

    // Validate password length.
    if (_passwordController.text.trim().length < 6) {
      _showError('Password must be at least 6 characters long.');
      return;
    }

    // Validate that password and confirm password match.
    if (_passwordController.text.trim() !=
        _confirmPasswordController.text.trim()) {
      _showError('Passwords do not match.');
      return;
    }

    try {
      // Create the user.
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      User? user = userCredential.user;

      if (user != null) {
        // Save user details in Firestore.
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .set({
          'firstName': _firstNameController.text.trim(),
          'lastName': _lastNameController.text.trim(),
          'email': _emailController.text.trim(),
          'phone': _phoneController.text.trim(),
          // Add any additional fields if needed.
        });

        // Show success message.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Sign-up successful! Please log in."),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to login screen.
        Navigator.pushReplacementNamed(context, '/');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        _showError("This email is already in use.");
      } else if (e.code == 'weak-password') {
        _showError("The password is too weak. Try using a stronger password.");
      } else {
        _showError(e.message ?? "An error occurred.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Curved top section.
          Container(
            height: deviceHeight * 0.9,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Positioned.fill(
              child: Image.asset(
                'waves.png', // Replace with your background image.
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),

          // White form section.
          Positioned(
            top: deviceHeight * 0.25,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: SingleChildScrollView(
                padding:
                const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back to Login.
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back,color: Color(0xFF8D7E73), size:20),
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/');
                            },
                          ),
                          const SizedBox(width: 2),
                          Text(
                            "Back to Login",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF8D7E73),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // "Sign Up" heading.
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 35,
                        color: Color(0xFF8D7E73),
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: Offset(3, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // First Name & Last Name row.
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person,
                                  color: Color(0x99B6ABA4)),
                              hintText: 'First Name',
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person,
                                  color: Color(0x99B6ABA4)),
                              hintText: 'Last Name',
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Email field.
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email, color: Color(0x99B6ABA4)),
                        hintText: 'Email',
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 23),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Password field.
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: Color(0x99B6ABA4)),
                        hintText: 'Password',
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 25),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Confirm Password field.
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: Color(0x99B6ABA4)),
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 25),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Phone field.
                    TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon:
                        Icon(Icons.phone, color: Color(0x99B6ABA4)),
                        hintText: 'Phone',
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 25),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Sign Up button.
                    ElevatedButton(
                      onPressed: _signUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF8D7E73),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Text('Sign Up',
                            style:
                            TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
