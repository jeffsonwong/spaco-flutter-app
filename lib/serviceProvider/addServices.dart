import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_loginregister/serviceProvider/spLogin.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class AddServicesPage extends StatelessWidget {
  static const routeName = '/ServiceProvider-addServices';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff49c9f6),
      appBar: AppBar(
        backgroundColor: Color(0xff1c87ab),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        title: Text(
          "Add Services",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: AddServicesScreen(),
    );
  }
}

class AddServicesScreen extends StatefulWidget {
  @override
  _AddServicesScreenState createState() => _AddServicesScreenState();
}

class _AddServicesScreenState extends State<AddServicesScreen> {
  String spID = SPDetails.spID;
  String spName;
  String spPhoneNum;
  String spAddress;
  final _formKey = GlobalKey<FormState>();
  final firestoreInstance = FirebaseFirestore.instance;
  String serviceID = UniqueKey().toString();
  String serviceName;
  String servicePrice;
  String serviceType;
  String serviceDescription;
  PickedFile pickedFile;
  final picker = ImagePicker();
  File _image;
  final serviceNameTextfield = TextEditingController();
  final servicePriceTextfield = TextEditingController();
  final serviceDescTextfield = TextEditingController();

  void clearText() {
    serviceNameTextfield.clear();
    servicePriceTextfield.clear();
    serviceDescTextfield.clear();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection("ServiceProviders")
          .doc(spID)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return new Text("Loading");
        } else {
          Map<String, dynamic> documentFields = snapshot.data.data();
          spName = documentFields['serviceproviderName'];
          spPhoneNum = documentFields['serviceproviderPhoneNum'];
          spAddress = documentFields['serviceproviderAddress'];
          List _types = documentFields['serviceproviderType'];
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
                height: double.infinity,
                padding: EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        //Service Name
                        TextFormField(
                          onChanged: (value) {
                            serviceName = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Service Name is empty';
                            }
                            return null;
                          },
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(20),
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-z]+|\s')),
                          ],
                          decoration: InputDecoration(
                              labelText: 'Service Name',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          maxLength: 20,
                          controller: serviceNameTextfield,
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        //Service Price
                        TextFormField(
                          onChanged: (value) {
                            servicePrice = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Service Price is empty';
                            }
                            return null;
                          },
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(7),
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9\\.]'))
                          ],
                          decoration: InputDecoration(
                              labelText: 'Service Price (RM00.00)',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          controller: servicePriceTextfield,
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        //Service Type
                        DropdownButtonFormField(
                          isExpanded: true,
                          decoration: InputDecoration(
                              labelText: 'Service Type',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20)),
                          onChanged: (newValue) {
                            serviceType = newValue;
                          },
                          items: _types.map((location) {
                            return DropdownMenuItem(
                              child: new Text(
                                location,
                                style: TextStyle(fontSize: 20),
                              ),
                              value: location,
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        //Service Description
                        TextFormField(
                          onChanged: (value) {
                            serviceDescription = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Service Description is empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Service Description',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          maxLength: 150,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          controller: serviceDescTextfield,
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Upload Service Image',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 20),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Color(0xff1c87ab),
                                    borderRadius: BorderRadius.circular(5)),
                                child: MaterialButton(
                                  textColor: Colors.white,
                                  child: Text(
                                    'Upload',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (builder) => bottomSheet());
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

                        SizedBox(
                          height: MediaQuery.of(context).size.height / 8.6,
                        ),

                        //Add Button
                        Container(
                          width: 150,
                          decoration: BoxDecoration(
                              color: Color(0xff1c87ab),
                              borderRadius: BorderRadius.circular(5)),
                          child: MaterialButton(
                            onPressed: () {
                              if (pickedFile == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    'Please upload Service Image',
                                    style: (TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 15)),
                                    textAlign: TextAlign.center,
                                  ),
                                  backgroundColor: Colors.red,
                                  duration: const Duration(seconds: 1),
                                ));
                              } else if (serviceType == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    'Service Type is Empty',
                                    style: (TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 15)),
                                    textAlign: TextAlign.center,
                                  ),
                                  backgroundColor: Colors.red,
                                  duration: const Duration(seconds: 1),
                                ));
                              } else if (_formKey.currentState.validate()) {
                                addService();
                                clearText();
                                _showMyDialog();
                              }
                            },
                            child: Text(
                              "Add",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          );
        }
      },
    );
  }

  Widget bottomSheet() {
    return Container(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: <Widget>[
              Text(
                'Upload Service Image by',
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

  Future<String> uploadFile(File _image) async {
    //"ServiceProvider IC Photo/unverified/${Path.basename(_image.path)}"
    Reference storageReference = FirebaseStorage.instance.ref().child(
        "Services Images/${serviceType}/${serviceName + ',' + serviceID} img");
    UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask;
    print('File Uploaded');
    String returnURL;
    await storageReference.getDownloadURL().then((fileURL) {
      returnURL = fileURL;
    });
    return returnURL;
  }

  addService() async {
    String imageURL = await uploadFile(_image);
    await firestoreInstance.collection("Services").doc(serviceID).set({
      'serviceproviderID': spID,
      'serviceproviderAddress': spAddress,
      'serviceproviderName': spName,
      'serviceproviderPhoneNum': spPhoneNum,
      'serviceID': serviceID,
      'serviceName': serviceName,
      'servicePrice': double.parse(servicePrice),
      'serviceType': serviceType,
      'serviceDescription': serviceDescription,
      'serviceImgURL': imageURL,
    }).then((value) => null);
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Service succesfully added!'),
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
}
