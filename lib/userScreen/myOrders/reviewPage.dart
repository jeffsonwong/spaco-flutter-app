import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewPage extends StatefulWidget {
  static const routeName = '/review';

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  var rating = 0.0;
  String spID, jobID;

  // @override
  // void initState() async {
  //   super.initState();

  //   //await FirebaseFirestore.instance.collection(collectionPath)
  // }

  @override
  Widget build(BuildContext context) {
    List<dynamic> args = ModalRoute.of(context).settings.arguments;
    spID = args[0];
    jobID = args[1];
    return Scaffold(
      appBar: AppBar(
        title: Text("Review"),
      ),
      body: Container(
        color: Color(0xff1c87ab),
        child: Column(children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: Text(
                  "Rate our service on a scale of 1 to 5",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(height: 50.0),
          Container(
              child: Align(
            child: Material(
              color: Colors.white,
              elevation: 12.0,
              borderRadius: BorderRadius.circular(20.0),
              shadowColor: Color(0x802196F3),
              child: Container(
                width: 300.0,
                height: 375.0,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        child: Text(
                          'Set Review',
                          style: TextStyle(color: Colors.black, fontSize: 22.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: SmoothStarRating(
                          allowHalfRating: false,
                          starCount: 5,
                          rating: rating,
                          size: 40.0,
                          isReadOnly: false,
                          filledIconData: Icons.star,
                          halfFilledIconData: Icons.star_half,
                          color: Colors.yellow,
                          borderColor: Colors.yellow,
                          spacing: 2.0,
                          onRated: (value) {
                            setState(() {
                              rating = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        child: Text("Your Rating: $rating",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                              child: Text(
                                'Submit Review',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                if (rating < 1) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      "Star Rating cannot be less than 1!",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontSize: 16),
                                    ),
                                    backgroundColor: Colors.red,
                                    duration: const Duration(seconds: 2),
                                  ));
                                } else {
                                  checkReviewed(spID, jobID, rating);
                                }

                                // await FirebaseFirestore.instance
                                //     .collection("ServiceProviders")
                                //     .doc(spID)
                                //     .collection("Reviews")
                                //     .doc(jobID)
                                //     .set({
                                //   "rating": rating,
                                //   "jobID": jobID,
                                // });
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ))
        ]),
      ),
    );
  }

  checkReviewed(String spID, String jobID, double ratingDouble) async {
    String rating = ratingDouble.toString();
    try {
      await FirebaseFirestore.instance
          .collection("ServiceProviders")
          .doc(spID)
          .collection("Reviews")
          .doc(jobID)
          .get()
          .then((DocumentSnapshot document) => {rating = document["rating"]});
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
            content: Text(
              "You have reviewed this Service Provider\nfor this job in the past!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 16),
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ))
          .closed
          .then((value) => Navigator.pop(context));
    } catch (e) {
      print(e.toString());
      await FirebaseFirestore.instance
          .collection("ServiceProviders")
          .doc(spID)
          .collection("Reviews")
          .doc(jobID)
          .set({
        "rating": rating,
        "jobID": jobID,
      });
      Navigator.pop(context);
    }
  }
}
/*addReview()async{
    Future<String> review(String serviceID,String uid,int rating)
    async{
      String retVal = "error";
      try{
        await firestoreInstance
            .collection("service")
            .doc(serviceID)
            .collection("reviews")
            .doc(uid)
            .set({'rating': rating});
      }catch(e){
        print(e);
      }
      return retVal;
    }*/
//}
/*Slider(
min: 0.0,
max: 5.0,
divisions: 5,
value:ratingValue,
activeColor: Color(0xff1c87ab),
inactiveColor: Colors.grey,
onChanged: (newValue){
// ignore: unused_element
setState((){
ratingValue=newValue;
if(ratingValue ==0)
{
ratingIcon = FontAwesomeIcons.angry;
ratingColor = Colors.redAccent;
rating = "Terrible";
}
if(ratingValue >=0.1 && ratingValue <=1.0)
{
ratingIcon = FontAwesomeIcons.sadTear;
ratingColor = Colors.orange;
rating = "Underwhelming";
}
if(ratingValue >=1.1 && ratingValue <=2.0)
{
ratingIcon = FontAwesomeIcons.frown;
ratingColor = Colors.amber;
rating = "Can do better";
}
if(ratingValue >=2.1 && ratingValue <=3.0)
{
ratingIcon = FontAwesomeIcons.meh;
ratingColor = Colors.yellow;
rating = "Pretty good";
}
if(ratingValue >=3.1 && ratingValue <=4.0)
{
ratingIcon = FontAwesomeIcons.smile;
ratingColor = Colors.green;
rating = "Great service";
}
if(ratingValue >=4.1 && ratingValue <=5.0)
{
ratingIcon = FontAwesomeIcons.laugh;
ratingColor = Colors.lightBlue;
rating = "Amazing";
}
}
);
},


),*/
