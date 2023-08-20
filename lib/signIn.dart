import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:incident_reporter/makeaReport.dart';
import 'signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'makeaReport.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isPasswordHidden = true;
  bool isLoading = true;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController emailcontroller = new TextEditingController();
  final TextEditingController passwordcontroller = new TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Image.asset("assets/img/logo.png"),
                SizedBox(height: 60),
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromARGB(255, 240, 239, 239),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      TextFormField(
                        validator: (String? value) {
                          if (value!.isEmpty) return "Please enter your email";
                        },
                        controller: emailcontroller,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Email Address',
                        ),
                      ),
                      TextFormField(
                        validator: (String? value) {
                          if (value!.isEmpty)
                            return "Please enter your password";
                        },
                        controller: passwordcontroller,
                        obscureText: isPasswordHidden,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Password',
                          prefix: Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              isPasswordHidden = !isPasswordHidden;
                              setState(() {});
                            },
                            child: Icon(isPasswordHidden
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forgot Password",
                                style: TextStyle(color: Colors.amber),
                              ))),
                      SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .6,
                        child: ElevatedButton(
                          onPressed: () => _onSignIn(),
                          child: Text("Sign In"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.amber, elevation: 5),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Im a new user"),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignUp()));
                            },
                            child: Text("Sign Up",
                                style: TextStyle(color: Colors.amber)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onSignIn() async {
    if (formKey.currentState!.validate()) {
      try {
        await auth.signInWithEmailAndPassword(
            email: emailcontroller.text, password: passwordcontroller.text);

        setState(() {
          isLoading = false;
        });
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MakeAReport()));
      } on Exception catch (e) {
        Fluttertoast.showToast(
            msg: e.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16,
            backgroundColor: Colors.red);
      }
    }
  }
}
