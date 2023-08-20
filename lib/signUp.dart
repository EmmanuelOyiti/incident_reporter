import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:incident_reporter/makeaReport.dart';
import 'makeaReport.dart';
import 'package:incident_reporter/signIn.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isPasswordHidden = true;
  bool isLoading = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController fullNamecontroller = new TextEditingController();
  final TextEditingController emailcontroller = new TextEditingController();
  final TextEditingController passwordcontroller = new TextEditingController();
  final TextEditingController phoneNumbercontroller =
      new TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(36, 56, 74, 1),
      body: Form(
        key: formKey,
        child: Center(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset("assets/img/logo.png"),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 73),
                    SizedBox(height: 70),
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
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          TextFormField(
                            validator: (String? value) {
                              if (value!.isEmpty)
                                return "Please enter your fullName";
                            },
                            controller: fullNamecontroller,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Full Name',
                            ),
                          ),
                          TextFormField(
                            validator: (String? value) {
                              if (value!.isEmpty)
                                return "Please enter your phone number";
                            },
                            controller: phoneNumbercontroller,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Phone number',
                            ),
                          ),
                          TextFormField(
                            validator: (String? value) {
                              if (value!.isEmpty)
                                return "Please enter your email";
                            },
                            controller: emailcontroller,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Email Address',
                            ),
                          ),
                          TextFormField(
                            obscureText: isPasswordHidden,
                            validator: (String? value) {
                              if (value!.isEmpty)
                                return "Please enter your password";
                            },
                            controller: passwordcontroller,
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
                          SizedBox(height: 40),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .6,
                            child: ElevatedButton(
                              onPressed: () => _onSignUp(),
                              child: Text("Sign Up"),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.amber, elevation: 5),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SignIn()));
                                },
                                child: Text("Sign In",
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
              if (isLoading)
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white.withOpacity(0.4),
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onSignUp() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        // create user account
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
                email: emailcontroller.text, password: passwordcontroller.text);
        // getting user unique ID
        String userId = userCredential.user!.uid;

        // saving user details to database table 'Users'
        DatabaseReference reference = FirebaseDatabase.instance.ref("Users");
        await reference.child(userId).set({
          "userId": userId,
          "fullName": fullNamecontroller.text,
          "email": emailcontroller.text,
          "phone": phoneNumbercontroller.text,
        });

        setState(() {
          isLoading = false;
        });
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MakeAReport()));
      } on Exception catch (e) {
        setState(() {
          isLoading = false;
        });
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
