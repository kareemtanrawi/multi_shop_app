import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_shop_app/views/screens/auth/register_screen.dart';

class LoginPage extends StatelessWidget {
  // const LoginPage({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login Account",
                style: GoogleFonts.aBeeZee(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                onChanged: (value){
                  _email= value;
                },
                validator: (value){
                  if(value!.isEmpty){
                    return 'Please Email Must noe be Empty';
                  }else{
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  hintText: "Enter you Email",
                  hintStyle: GoogleFonts.aBeeZee(),
                  labelStyle: GoogleFonts.aBeeZee(),
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.pink,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                onChanged: (value){
                  _password = value;
                },
                validator: (value){
                  if(value!.isEmpty){
                    return 'password must be not empty';
                  }else{
                    return null;
                  }
                },
                decoration: InputDecoration(

                  labelText: 'Password',
                  hintText: "Enter your Password",
                  hintStyle: GoogleFonts.aBeeZee(),
                  labelStyle: GoogleFonts.aBeeZee(),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.pink,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  if(_formKey.currentState!.validate()){
                    // print('valid') ;
                    print(_email);
                    print(_password);
                  }else{
                    print("not valid");

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
                      'Login',
                      style: GoogleFonts.aBeeZee(
                        letterSpacing: 4,
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              // InkWell(
              //   onTap: (){},
              //   child: Text(
              //     'Need an account?',
              //     style: GoogleFonts.aBeeZee(),
              //   ),
              // ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  );
                },
                child: Text(
                  'Need an account?',
                  style: GoogleFonts.aBeeZee(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
