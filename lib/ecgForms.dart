import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(ECGForm());

class ECGForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Report Incident"),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = new TextEditingController();
  TextEditingController subject = new TextEditingController();
  TextEditingController body = new TextEditingController();
  TextEditingController incidentName = new TextEditingController();
  TextEditingController nameOfIndividuals =new TextEditingController();
  TextEditingController actionPlan =new TextEditingController();
  TextEditingController currentStatus =new TextEditingController();

  sendEmail(String incidentName, String description) async {
    final Email email = Email(
        bcc: const ['nameOfIndividuals'],
        subject: incidentName,
        recipients: ['ecgho@ecggh.com'],
        body: '''
        $description

        ${actionPlan.text}

        ${currentStatus.text}
        ''',
        // attachmentPaths: ['/path/to/attachment.zip']
        isHTML: false);
    print(body);
    await FlutterEmailSender.send(email);
  }
  final ImagePicker _imagePicker = new ImagePicker();
  String? _imagePath;
  String? _photoPath;
  String? _videoPath;

  Future<void> _pickImage() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _imagePath = image.path;
    }
    setState(() {});
  }

  Future<void> _pickVideo() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _videoPath = image.path;
    }
    setState(() {});
  }
  Future<void> _pickPhoto() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _photoPath = image.path;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: incidentName,
              decoration: InputDecoration(
                labelText: 'incident Name',
                border: UnderlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: nameOfIndividuals,
              decoration: InputDecoration(
                labelText: 'Names of Individuals',
                border: UnderlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: body,
              decoration: InputDecoration(
                labelText: 'Description',
                border: UnderlineInputBorder(),
              ),
            ),
            Row(
              children: [
                 SizedBox(width: 55,),
                IconButton(
                  
                    onPressed: () {
                      _pickImage();
                    },
                    icon: Icon(Icons.camera)),
                    SizedBox(width: 35,),
                     IconButton(
                onPressed: () {
                  _pickPhoto();
                },
                icon: Icon(Icons.photo)),
                SizedBox(width: 35,),
                IconButton(
                onPressed: () {
                  _pickVideo();
                },
                icon: Icon(Icons.video_call_rounded)), SizedBox(width: 55,),
              ],
            ),
            TextFormField(
              controller: actionPlan,
              decoration: InputDecoration(
                labelText: 'Action Plan',
                border: UnderlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: currentStatus,
              decoration: InputDecoration(
                labelText: 'Current Status',
                border: UnderlineInputBorder(),
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 150.0, top: 40.0),
                child: ElevatedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    _formKey.currentState!.save();
                    print('${email.text}');
                    sendEmail(incidentName.text, body.text);
                  },
                )),
          ],
        ),
      ),
    );
  }
}
