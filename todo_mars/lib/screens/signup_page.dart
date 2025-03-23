import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:todo_mars/controllers/auth_controller.dart';
import 'package:todo_mars/models/user_model.dart';
import 'package:todo_mars/screens/signin_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

late TextEditingController _usernameController;
late TextEditingController _emailController;
late TextEditingController _passwordController;
late GlobalKey<FormState> _formkey;
final controller = Get.put(AuthController());
bool _isObscure = true;

class _SignupPageState extends State<SignupPage> {
  @override
  void initState() {
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _formkey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          title: Text(
            "Sign Up",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Form(
                key: _formkey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Image.asset("assets/logo_text.png")),
                      Center(
                        child: Text(
                          "Create an account once and log in to all our services.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Username",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 76, 76, 76),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: "Username",
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.white,
                          ),
                        ),
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        validator:
                            MultiValidator([
                              RequiredValidator(
                                errorText: "username is required",
                              ),
                            ]).call,
                      ),
                      SizedBox(height: 10),
                      SizedBox(height: 10),
                      Text(
                        "Email",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 76, 76, 76),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: "Email",
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.white,
                          ),
                        ),
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        validator:
                            MultiValidator([
                              EmailValidator(
                                errorText: 'enter a valid email address',
                              ),
                              RequiredValidator(errorText: "email is required"),
                            ]).call,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Password",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 76, 76, 76),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: "password",
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          prefixIcon: Icon(Icons.lock, color: Colors.white),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            icon: Icon(
                              _isObscure
                                  ? CupertinoIcons.eye_slash
                                  : CupertinoIcons.eye,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        validator:
                            MultiValidator([
                              RequiredValidator(
                                errorText: 'password is required',
                              ),
                              MinLengthValidator(
                                8,
                                errorText:
                                    'password must be at least 8 digits long',
                              ),
                              MaxLengthValidator(
                                15,
                                errorText:
                                    'password must be at least 15 digits long',
                              ),
                            ]).call,
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CupertinoButton(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20),
                              onPressed: () async {
                                if (_formkey.currentState!.validate()) {
                                  final user = UserModel(
                                    nom: _usernameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  );
                                  var result = await controller
                                      .signupController(user);

                                  if (result['status'] == true) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(result['success']),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(result['error'])),
                                    );
                                  }
                                  print("success");
                                } else {
                                  print("failure");
                                }
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SigninPage(),
                                  ),
                                );
                              },
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style:
                                      Theme.of(
                                        context,
                                      ).textTheme.headlineSmall!,
                                  children: const <TextSpan>[
                                    TextSpan(text: "Have an account?  "),
                                    TextSpan(
                                      text: "Sign In",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
