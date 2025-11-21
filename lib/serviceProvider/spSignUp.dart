import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter_loginregister/serviceProvider/spLogin.dart';
import 'package:path/path.dart' as Path;

class ServiceProviderSignUpPage extends StatelessWidget {
  static const routeName = '/ServiceProvider-signup';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1c87ab),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        title: Text(
          'Service Provider Sign Up',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      body: ServiceProviderSignUpScreen(),
    );
  }
}

class ServiceProviderSignUpScreen extends StatefulWidget {
  @override
  _ServiceProviderSignUpScreenState createState() =>
      _ServiceProviderSignUpScreenState();
}

class _ServiceProviderSignUpScreenState
    extends State<ServiceProviderSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  //text field state'
  String name = '';
  String icNum = '';
  String email = '';
  String password = '';
  String phoneNum = '';
  String address = '';
  var categoryHolder = [];
  List<String> _locations = ['Selangor', 'WP Kuala Lumpur', 'WP Putrajaya'];
  String selectedLocation = 'Selangor';
  Map<String, bool> values = {
    'Aircond': false,
    'Plumbing': false,
    'Cleaning': false,
    'Disinfection': false,
    'Moving': false,
    'Appliances': false,
  };
  PickedFile pickedFile;
  final picker = ImagePicker();
  File _image, _certificate;

  getType() {
    values.forEach((key, value) {
      if (value == true) {
        categoryHolder.add(key);
      }
    });

    return categoryHolder;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Be a part of SPACO's Service Providers! \nFill in the details below and we'll get back to you in a few days once we've verified you! :) ",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.justify,
                ),

                //Name
                TextFormField(
                    onChanged: (value) {
                      name = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Full Name is empty';
                      }
                      return null;
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-z]+|\s')),
                    ],
                    decoration: InputDecoration(
                        labelText: 'Company name',
                        labelStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600)),
                    style: TextStyle(
                      fontSize: 20,
                    )),
                SizedBox(
                  height: 5,
                ),

                //IC Number
                TextFormField(
                    onChanged: (value) {
                      icNum = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'IC Number is empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(12),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                    decoration: InputDecoration(
                        labelText: 'Owner IC Number (Without -)',
                        labelStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600)),
                    style: TextStyle(
                      fontSize: 20,
                    )),
                SizedBox(
                  height: 15,
                ),

                //Upload IC
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Upload IC Photo',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                      ButtonTheme(
                        child: MaterialButton(
                          color: Color(0xff1c87ab),
                          textColor: Colors.black,
                          child: Text(
                            'Upload',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (builder) => bottomSheetIC());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                _image == null
                    ? Container()
                    : Image.file(
                        _image,
                        height: 150,
                        width: 200,
                      ),

                //Email
                TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Email is empty';
                      } else if (!(value.contains('@'))) {
                        return 'Email must contain @';
                      } else if (!(value.contains('.com'))) {
                        return 'Email must contain .com';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600)),
                    style: TextStyle(
                      fontSize: 20,
                    )),
                SizedBox(
                  height: 5,
                ),

                //Password
                TextFormField(
                    obscureText: true,
                    onChanged: (value) {
                      setState(() => password = value);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Password is empty';
                      } else if (value.length < 6) {
                        return 'Minimum 6 password characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600)),
                    style: TextStyle(
                      fontSize: 20,
                    )),
                SizedBox(height: 5),

                //Phone Number
                TextFormField(
                    onChanged: (value) {
                      phoneNum = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Phone Number is empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(11),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                    decoration: InputDecoration(
                        labelText: 'Phone Number (Without -)',
                        labelStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600)),
                    style: TextStyle(
                      fontSize: 20,
                    )),
                SizedBox(
                  height: 5,
                ),

                //Location
                DropdownButtonFormField(
                  isExpanded: true,
                  decoration: InputDecoration(
                      labelText: 'Location',
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 20)),
                  value: selectedLocation,
                  onChanged: (newValue) {
                    setState(() {
                      selectedLocation = newValue;
                    });
                  },
                  items: _locations.map((location) {
                    return DropdownMenuItem(
                      child: new Text(
                        location,
                        style: TextStyle(fontSize: 18),
                      ),
                      value: location,
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 5,
                ),

                //Address
                TextFormField(
                    onChanged: (value) {
                      address = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Address is empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Address',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        )),
                    style: TextStyle(
                      fontSize: 20,
                    )),
                SizedBox(
                  height: 15,
                ),

                //Upload Certificate
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Upload Certificate',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                      ButtonTheme(
                        child: MaterialButton(
                          color: Color(0xff1c87ab),
                          textColor: Colors.black,
                          child: Text(
                            'Upload',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (builder) => bottomSheetCertificate());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                _certificate == null
                    ? Container()
                    : Image.file(
                        _certificate,
                        height: 150,
                        width: 200,
                      ),
                SizedBox(
                  height: 20,
                ),

                //Category
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Service Category',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ),
                Column(
                  children: values.keys.map((String key) {
                    return ListTileTheme(
                      contentPadding: EdgeInsets.all(0),
                      child: new CheckboxListTile(
                        title: new Text(key),
                        value: values[key],
                        activeColor: Color(0xff1c87ab),
                        checkColor: Colors.white,
                        onChanged: (bool value) {
                          setState(() {
                            values[key] = value;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 5,
                ),

                //Button
                ButtonTheme(
                  height: 40,
                  child: MaterialButton(
                    color: Color(0xff1c87ab),
                    onPressed: () {
                      if (pickedFile == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Please upload IC Photo',
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 1),
                        ));
                      } else if (getType().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Please select your service category',
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: Colors.red,
                        ));
                      } else if (_formKey.currentState.validate()) {
                        storeUnverifiedSP();
                        categoryHolder = [];
                        _showMyDialog();
                      }
                      // uploadImageToFirebase();
                    },
                    child: Text(
                      "Apply",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget bottomSheetIC() {
    return Container(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: <Widget>[
              Text(
                'Upload IC Image by',
                style: TextStyle(fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  IconData(
                                    59343,
                                    fontFamily: 'MaterialIcons',
                                  ),
                                  color: Colors.black,
                                  size: 50,
                                ),
                                onPressed: () {
                                  getImage(true);
                                }),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18),
                              child: Text('Gallery'),
                            ),
                          ],
                        )),
                    SizedBox(
                      width: 50,
                    ),
                    Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                  size: 50,
                                ),
                                onPressed: () {
                                  getImage(false);
                                }),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18),
                              child: Text('Camera'),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future getImage(bool choice) async {
    if (choice == true) {
      pickedFile = await picker.getImage(source: ImageSource.gallery);
    } else {
      pickedFile = await picker.getImage(source: ImageSource.camera);
    }

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    Navigator.pop(context);
  }

  Future<void> storeUnverifiedSP() async {
    final firestoreInstance = FirebaseFirestore.instance;
    String serviceproviderID = UniqueKey().toString();
    String icImageURL = await uploadIC(_image);
    String certificateImageURL = await uploadCertificate(_certificate);

    return await firestoreInstance
        .collection("unverifiedServiceProviders")
        .doc(serviceproviderID)
        .set({
      'serviceproviderID': serviceproviderID,
      'serviceproviderICNum': icNum,
      'serviceproviderName': name,
      'serviceproviderEmail': email,
      'serviceproviderPassword': password,
      'serviceproviderPhoneNum': phoneNum,
      'serviceproviderAddress': address,
      'serviceproviderType': getType(),
      'serviceproviderICPhoto': icImageURL,
      'serviceproviderCertificate': certificateImageURL,
      // FieldValue.arrayUnion([imageURL]),
      'status': 'Unsuspended',
    }).then((value) => null);
  }

  Future<String> uploadIC(File _image) async {
    //"ServiceProvider IC Photo/unverified/${Path.basename(_image.path)}"
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child("ServiceProvider IC Photo/unverified/${name + ' ' + icNum}");
    UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask;
    print('File Uploaded');
    String returnURL;
    await storageReference.getDownloadURL().then((fileURL) {
      returnURL = fileURL;
    });
    return returnURL;
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Application Sent!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Your Application has been sent to us! We will get back to you in a few days. :)'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget bottomSheetCertificate() {
    return Container(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: <Widget>[
              Text(
                'Upload Certificate Image by',
                style: TextStyle(fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  IconData(
                                    59343,
                                    fontFamily: 'MaterialIcons',
                                  ),
                                  color: Colors.black,
                                  size: 50,
                                ),
                                onPressed: () {
                                  getCertificate(true);
                                }),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18),
                              child: Text('Gallery'),
                            ),
                          ],
                        )),
                    SizedBox(
                      width: 50,
                    ),
                    Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                  size: 50,
                                ),
                                onPressed: () {
                                  getCertificate(false);
                                }),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18),
                              child: Text('Camera'),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future getCertificate(bool choice) async {
    if (choice == true) {
      pickedFile = await picker.getImage(source: ImageSource.gallery);
    } else {
      pickedFile = await picker.getImage(source: ImageSource.camera);
    }

    setState(() {
      if (pickedFile != null) {
        _certificate = File(pickedFile.path);
      } else {
        print('No certificate image selected.');
      }
    });
    Navigator.pop(context);
  }

  Future<String> uploadCertificate(File _certificate) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child("ServiceProvider Certificate Photo/$name");
    UploadTask uploadTask = storageReference.putFile(_certificate);
    await uploadTask;
    print('File Uploaded');
    String returnURL;
    await storageReference.getDownloadURL().then((fileURL) {
      returnURL = fileURL;
    });
    return returnURL;
  }

  // Future uploadImageToFirebase() async {
  //   StorageReference firebaseStorageRef = FirebaseStorage.instance
  //       .ref()
  //       .child('uploads/${Path.basename(_image.path)}');
  //   StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
  //   StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
  //   taskSnapshot.ref.getDownloadURL().then(
  //         (value) => print("Done: $value"),
  //       );
  // }
}
