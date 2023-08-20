import 'package:flutter/material.dart';
import 'package:incident_reporter/signIn.dart';
import 'package:incident_reporter/signUp.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(36, 56, 74, 1),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Text(
                        "Incident Reporter",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                      ),
                      SizedBox(height: 40),
                      Image.asset("assets/img/girls.png"),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 60),
              Text(
                "Join Our Community",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 25),
              SizedBox(
                width: MediaQuery.of(context).size.width * .6,
                child: ElevatedButton(
                  onPressed: () {Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUp()));},
                  child: Text("Sign Up"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.amber, elevation: 5),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * .6,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignIn()));
                  },
                  child: Text("Sign In"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.amber,
                      elevation: 5),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
