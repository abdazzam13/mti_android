import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mti_android/routes/app_routes.dart';

import '../../../network/api/googleSignInApi.dart';
import '../../../utils/SharedPreferences.dart';
import '../controller/LoginController.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isSigningIn = false;
  final LoginController loginController = Get.find();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isObscureText = true;
  final GlobalKey<FormState> _formKey = new GlobalKey(debugLabel: 'form');
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo.png"),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                      ),
                      controller: usernameController,
                      key: Key("username"),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      key: Key("password"),
                      obscureText: isObscureText,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)
                          ),
                          suffixIcon: InkWell(
                            child: Icon(Icons.remove_red_eye),
                            onTap: (){
                              setState(() {
                                isObscureText = !isObscureText;
                              });
                            },
                          )
                      ),
                      controller: passwordController,
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      key: Key("login"),
                      onPressed: () {
                        SharedPref.setUsername(usernameController.text);
                        SharedPref.setPassword(passwordController.text);
                        SharedPref.setIsLogin(true);
                        SharedPref.setIsLoginByGoogle(false);
                        Get.offNamed(AppRoutes.home);
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Sign in with Google",
                              style: TextStyle(
                                  color: const Color(0XFF0E1F40)),
                            )
                          ],
                        ),
                      ),
                      style: ElevatedButton.styleFrom(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    height: 20,
                    thickness: 2,
                    indent: 20,
                    endIndent: 10,
                  ),
                ),
                Text("atau",
                    style: TextStyle(
                        color: Color.fromRGBO(60, 60, 67, 0.6),
                        fontWeight: FontWeight.w400,
                        fontSize: 14)),
                Expanded(
                    child: Divider(
                      height: 20,
                      thickness: 2,
                      indent: 10,
                      endIndent: 20,
                    ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: LoginByGoogle.initializeFirebase(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error initializing Firebase');
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(20),
                    child: _isSigningIn
                        ? Center(
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.blue),
                              ),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isSigningIn = true;
                                SharedPref.setIsLogin(true);
                              });
                              loginController.loginByGoogle(context);

                              // print("USERLOGIN $user");
                              setState(() {
                                _isSigningIn = false;
                              });
                            },
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset("assets/google.png"),
                                  Text(
                                    "Sign in with Google",
                                    style: TextStyle(
                                        color: const Color(0XFF0E1F40)),
                                  )
                                ],
                              ),
                            ),
                            style: ElevatedButton.styleFrom(),
                          ),
                  );
                }
                return CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
