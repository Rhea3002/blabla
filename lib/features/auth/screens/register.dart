import 'package:ecomm/features/auth/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/auth_service.dart';

enum Auth {
  signin,
  signup,
}

enum AccountType {
  admin,
  user,
}

extension AccountTypeExtension on AccountType {
  String get value {
    return toString().split('.').last;
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _signUpFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  AccountType type = AccountType.user;
  var _isobscured;
  @override
  void initState() {
    super.initState();
    _isobscured = true;
  }

  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
      context: context,
      type: type.value,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey[300],
      body: SafeArea(
         
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Image.asset('assets/images/refer.png',
                  height: 150, width: 150),
                ),
                        
                Text(
                  'Create Account',
                  style: GoogleFonts.dmSerifDisplay(
                    fontWeight: FontWeight.bold,
                    fontSize: 38,
                  ),
                ),
                        
                SizedBox(
                  height: 10,
                ),
                        
                // Text(
                //   'We are Happy to have you',
                //   style: TextStyle(
                //     fontSize: 20,
                //   ),
                // ),
                // SizedBox(
                //   height: 50,
                // ),
                        
                Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      // Add the radio buttons for selecting the account type
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38),
                            // borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              Radio(
                                activeColor: Colors.cyan[300],
                                value: AccountType.user,
                                groupValue: type,
                                onChanged: (AccountType? val) {
                                  setState(() {
                                    type = val!;
                                  });
                                },
                              ),
                              const Text('Customer'),
                              Radio(
                                activeColor: Colors.cyan[300],
                                value: AccountType.admin,
                                groupValue: type,
                                onChanged: (AccountType? val) {
                                  setState(() {
                                    type = val!;
                                  });
                                },
                              ),
                              const Text('Seller'),
                            ],
                          ),
                        ),
                      ),
                        
                      //USER
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white)),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'User',
                                icon: Icon(Icons.person),
                              ),
                            ),
                          ),
                        ),
                      ),
                        
                      SizedBox(
                        height: 10,
                      ),
                        
                      //Email TextField
                        
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white)),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email',
                                icon: Icon(Icons.email),
                              ),
                            ),
                          ),
                        ),
                      ),
                        
                      SizedBox(
                        height: 10,
                      ),
                        
                      //Password TextField
                        
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white)),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: _isobscured,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: _isobscured
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _isobscured = !_isobscured;
                                    });
                                  },
                                ),
                                border: InputBorder.none,
                                hintText: 'Password',
                                icon: Icon(Icons.password),
                              ),
                            ),
                          ),
                        ),
                      ),
                        
                      SizedBox(
                        height: 10,
                      ),
                        
                      //Address
                        
                      // Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      //     child: Container(
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(12),
                      //           color: Colors.grey[200],
                      //           border: Border.all(color: Colors.white)),
                      //       child: Padding(
                      //         padding: EdgeInsets.only(left: 20.0),
                      //         child: TextFormField(
                      //           //obscureText: true,
                      //           decoration: InputDecoration(
                      //             border: InputBorder.none,
                      //             hintText: 'Address',
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                        
                      //   SizedBox(
                      //     height: 10,
                      //   ),
                        
                      // Sign in Button
                        
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                        child: GestureDetector(
                          onTap: () {
                            if (_signUpFormKey.currentState!.validate()) {
                              signUpUser();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 86, 221, 210),
                                  Color.fromARGB(255, 51, 63, 225),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                        
                        SizedBox(height: 10,),
                //Register Now
                        
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already a Member?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    GestureDetector(
                        onTap: () => Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            AuthScreen())),
                        child: Text(
                          '  LOG IN!!!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        )),
                ],
                )
                      ],
                    ),
              ),
            ),
          )),
    );
  }
}
