import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_shop_app/controllers/auth_controller.dart';
import 'package:multi_shop_app/views/screens/auth/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // const RegisterScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthController _authController = AuthController();

  late String email;

  late String fullName;

  late String password;

  Uint8List? _image;

  selectProfileImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  capureImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.camera);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Register Account',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Stack(
                    children: [
                      _image == null
                          ? const CircleAvatar(
                              radius: 65,
                              child: Icon(
                                Icons.person,
                                size: 70,
                                // color: Colors.white,
                              ),
                            )
                          : CircleAvatar(
                              radius: 65,
                              backgroundImage: MemoryImage(_image!),
                            ),
                      Positioned(
                        right: 0,
                        top: 15,
                        child: IconButton(
                          onPressed: () {
                            selectProfileImage();
                          },
                          icon: const Icon(
                            CupertinoIcons.photo,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Email Address must be Not Empty';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      labelStyle: GoogleFonts.aBeeZee(),
                      hintText: "Enter Email Address",
                      hintStyle: GoogleFonts.aBeeZee(),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.pink,
                      ),
                      // border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      fullName = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Full Name Must not be empty';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      labelStyle: GoogleFonts.aBeeZee(),
                      hintText: 'Enter Full Name',
                      hintStyle: GoogleFonts.aBeeZee(),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Password Must not be Empty';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: GoogleFonts.aBeeZee(),
                      hintText: 'Enter your password',
                      hintStyle: GoogleFonts.aBeeZee(),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // print(email);
                        // print(fullName);
                        // print(password);
                        _authController.createNewUser(
                          email,
                          fullName,
                          password,
                          _image,
                        );
                      } else {
                        print('Not valid');
                      }
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Register',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 4,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Already Have An Account?',
                      style: GoogleFonts.aBeeZee(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
