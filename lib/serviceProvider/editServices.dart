import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class EditServicesPage extends StatelessWidget {
  static const routeName = '/ServiceProvider-editServices';
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
          "Edit Service",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: EditServicesScreen(),
    );
  }
}

class EditServicesScreen extends StatefulWidget {
  @override
  _EditServicesScreenState createState() => _EditServicesScreenState();
}

class _EditServicesScreenState extends State<EditServicesScreen> {
  String serviceName;
  String servicePrice;
  String serviceType;
  String serviceDescription;
  String serviceID;
  String imageURL;
  PickedFile pickedFile;
  final picker = ImagePicker();
  File _image;

  @override
  Widget build(BuildContext context) {
    serviceID = ModalRoute.of(context).settings.arguments;
    final _formKey = GlobalKey<FormState>();
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Services")
          .doc(serviceID)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return new Text("Loading");
        } else {
          Map<String, dynamic> document = snapshot.data.data();
          imageURL = document['serviceImgURL'];
          serviceType = document['serviceType'];
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(6)),
              child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Center(
                          child: Column(children: <Widget>[
                            Container(
                              width: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: displayServiceImage(),
                                //Image.network(imageURL),
                              ),
                            ),
                            Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Color(0xff1c87ab),
                                  borderRadius: BorderRadius.circular(5)),
                              child: MaterialButton(
                                textColor: Colors.white,
                                child: Text(
                                  'Change Image',
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
                          ]),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        //Service Name
                        TextFormField(
                          onChanged: (value) {
                            serviceName = value;
                          },
                          initialValue: serviceName = document["serviceName"],
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
                          maxLength: 20,
                          decoration: InputDecoration(
                              labelText: 'Service Name',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        //Service Price
                        TextFormField(
                          onChanged: (value) {
                            servicePrice = value;
                          },
                          initialValue: servicePrice =
                              document["servicePrice"].toStringAsFixed(2),
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
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        //Service Description
                        TextFormField(
                          onChanged: (value) {
                            serviceDescription = value;
                          },
                          initialValue: serviceDescription =
                              document["serviceDescription"],
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
                        ),

                        //Save Button
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Color(0xff1c87ab),
                                  borderRadius: BorderRadius.circular(5)),
                              child: MaterialButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    updateService();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        "Saved",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      backgroundColor: Color(0xff1c87ab),
                                      duration:
                                          const Duration(milliseconds: 600),
                                    ));
                                  }
                                },
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          );
        }
      },
    );
  }

  displayServiceImage() {
    if (pickedFile == null) {
      return Image.network(imageURL);
    } else {
      return Image.file(
        _image,
        height: 150,
        width: 200,
      );
    }
  }

  updateService() async {
    print(serviceID);
    final firestoreInstance = FirebaseFirestore.instance;
    if (pickedFile != null) {
      imageURL = await uploadFile(_image);
    }
    await firestoreInstance.collection("Services").doc(serviceID).update({
      'serviceName': serviceName,
      'servicePrice': double.parse(servicePrice),
      'serviceDescription': serviceDescription,
      'serviceImgURL': imageURL,
    }).then((value) => null);
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
}
