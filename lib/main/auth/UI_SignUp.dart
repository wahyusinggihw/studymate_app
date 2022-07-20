import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Widget/widget_TextField.dart';
import 'UI_SignIn.dart';
import 'package:provider/provider.dart';
import 'auth_model.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _nomorController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: Material(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Union.png'),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Vector.png'),
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 80.0, 30.0, 30.0),
              // child: SingleChildScrollView(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  Column(
                    children: [
                      Text(
                        "SIGN UP",
                        style: GoogleFonts.poppins(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(children: [
                          TextFieldsWidget(
                            controller: _firstNameController,
                            hintText: 'First name',
                            obscureText: false,
                            prefixIconData: Icons.person,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "first name can't be empty";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFieldsWidget(
                            controller: _lastNameController,
                            hintText: 'Last name',
                            obscureText: false,
                            prefixIconData: Icons.person,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "last name can't be empty";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFieldsWidget(
                            controller: _emailController,
                            hintText: 'Email',
                            obscureText: false,
                            prefixIconData: Icons.email,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "email can't be empty";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFieldsWidget(
                            controller: _passwordController,
                            hintText: 'Password',
                            obscureText: true,
                            prefixIconData: Icons.lock,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "password can't be empty";
                              } else if (value.length < 8 && value.isNotEmpty) {
                                return "password should contain more than 8 characters";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFieldsWidget(
                            controller: _confirmPasswordController,
                            hintText: 'Confirm Password',
                            obscureText: true,
                            prefixIconData: Icons.lock,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return null;
                              } else if (value != _passwordController.text) {
                                return 'value is unvalid';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 100,
                                height: 40,
                                child: FloatingActionButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    'Sign Up',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      var message = await authService.signUp(
                                          firstName: _firstNameController.text,
                                          lastName: _lastNameController.text,
                                          email: _emailController.text,
                                          password: _passwordController.text);

                                      if (message!.contains('Success')) {
                                        // print("success");
                                        var snackBar = SnackBar(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.blue,
                                          duration: Duration(seconds: 4),
                                          content: Text(
                                              'Register berhasil, silahkan login'),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                        Navigator.pushNamed(context, '/login');
                                      } else {
                                        var snackBar = SnackBar(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.red,
                                          duration: Duration(seconds: 4),
                                          content: Text(message.toString()),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Have an account?',
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/');
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'or signup with',
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle),
                                  child: Image.asset(
                                    'assets/images/google.png',
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                                Text(
                                  ' Google',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.facebook,
                                  color: Colors.blueAccent,
                                ),
                                Text(
                                  ' Facebook',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // ),
            ),
          ),
        ),
      ),
    );
  }
}
