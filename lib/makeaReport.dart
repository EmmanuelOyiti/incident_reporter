import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:incident_reporter/policeForms.dart';
import 'package:incident_reporter/map.dart';
import 'package:incident_reporter/ecgForms.dart';
import 'package:incident_reporter/signIn.dart';
import 'package:incident_reporter/waterCompanyForms.dart';
import 'package:incident_reporter/fireServiceForms.dart';
import 'package:incident_reporter/policeForms.dart';

class MakeAReport extends StatelessWidget {
  const MakeAReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(36, 56, 74, 1),
        title: Center(child: const Text('Make a Report')),
        actions: [
          // Navigate to the Search Screen
          IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const SignIn())),
              icon: const Icon(Icons.close)),
          IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => Map(
                        placeToGo: LatLng(5.5886556, -0.2379377),
                      ))),
              icon: const Icon(Icons.map))
        ],
      ),
      backgroundColor: Color.fromARGB(255, 197, 196, 196),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 5),
              ButtonBar(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.red,
                          backgroundColor: Colors.white,
                          elevation: 10 // foreground
                          ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => PoliceForm()),
                        );
                      },
                      child: Text('Accident'),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white, // background
                          onPrimary: Color.fromARGB(255, 2, 90, 131),
                          elevation: 10 // foreground
                          ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => PoliceForm()),
                        );
                      },
                      child: Text('Police Report'),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white, // background
                          onPrimary: Colors.amber,
                          elevation: 10 // foreground
                          ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => PoliceForm()),
                        );
                      },
                      child: Text('Power Outage'),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white, // background
                          onPrimary: Colors.lightBlue,
                          elevation: 10 // foreground
                          ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ECGForm()),
                        );
                      },
                      child: Text('Water Damage '),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white, // background
                          onPrimary: Colors.orange,
                          elevation: 10 // foreground
                          ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => GhWaterForms()),
                        );
                      },
                      child: Text('Fire Outbreak'),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white, // background
                          onPrimary: Color.fromARGB(255, 2, 90, 131),
                          elevation: 10 // foreground
                          ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => FireServiceForm()),
                        );
                      },
                      child: Text('Police Report'),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white, // background
                          onPrimary: Colors.red,
                          elevation: 10 // foreground
                          ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => PoliceForm()),
                        );
                      },
                      child: Text('Accident'),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
