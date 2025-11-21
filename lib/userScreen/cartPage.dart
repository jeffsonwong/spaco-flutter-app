import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loginregister/models/orders.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../widgets/cart_item.dart';
import 'package:intl/intl.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:time_picker_widget/time_picker_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartPage extends StatefulWidget {
  static const routeName = '/cart';
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String _hour, _minute;
  String formattedTime = DateFormat('HH:mm').format(DateTime.now());
  String formattedDate = DateFormat('dd/MM/yy').format(DateTime.now());
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  String profileComplete;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _dateController.text = DateFormat('dd/MM/yy').format(DateTime.now());
    _timeController.text = DateFormat('HH:mm').format(DateTime.now());
    super.initState();
    checkProfileComplete();
  }

  Future _selectDate(context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2021),
        lastDate: DateTime(2022));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yy').format(selectedDate);
        formattedDate = DateFormat('dd/MM/yy').format(selectedDate);
      });
  }

  Future _selectTime(context) async {
    final TimeOfDay picked = await showCustomTimePicker(
      onFailValidation: (context) => print('Unavailable selection'),
      context: context,
      initialTime: selectedTime,
      selectableTimePredicate: (time) => time.hour >= 9 && time.hour < 20,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        if (selectedTime.hour < 10) {
          _hour = "0" + _hour;
        }
        if (selectedTime.minute < 10) {
          _minute = "0" + _minute;
        }
        formattedTime = _hour + ':' + _minute;
        _timeController.text = formattedTime;
      });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      backgroundColor: Color(0xff49c9f6),
      appBar: AppBar(
        backgroundColor: Color(0xff1c87ab),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        title: Text(
          'My Cart',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, i) => CartSvcs(
                    cart.items.values.toList()[i].id,
                    cart.items.keys.toList()[i],
                    cart.items.values.toList()[i].name,
                    cart.items.values.toList()[i].price,
                    cart.items.values.toList()[i].quantity,
                    cart.items.values.toList()[i].spID,
                    cart.items.values.toList()[i].spName,
                    cart.items.values.toList()[i].spPhoneNum,
                    cart.items.values.toList()[i].spAddress)),
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: Colors.black),
              ),
              color: Color(0xff1c87ab),
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 15,
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Pick Date:",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: TextFormField(
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                              enabled: false,
                              controller: _dateController,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      _selectTime(context);
                    },
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Pick Time:",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: TextFormField(
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                              enabled: false,
                              controller: _timeController,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xff1c87ab),
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Text(
                  "Total Price: RM" + cart.totalAmount.toStringAsFixed(2),
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.white),
                )),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 110,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: MaterialButton(
                      onPressed: () {
                        if (cart.totalAmount <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "Cart is Empty!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 2),
                          ));
                        } else if (profileComplete == "false") {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "Profile is Not Complete!\nComplete your profile in My Profile!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 3),
                          ));
                        } else {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (builder) => Container(
                                  height:
                                      MediaQuery.of(context).size.height / 1.2,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: const Radius.circular(20.0),
                                          topRight:
                                              const Radius.circular(20.0))),
                                  child: SingleChildScrollView(
                                    child: Wrap(
                                      children: <Widget>[
                                        CreditCardWidget(
                                          cardNumber: cardNumber,
                                          expiryDate: expiryDate,
                                          cardHolderName: cardHolderName,
                                          cvvCode: cvvCode,
                                          showBackView: isCvvFocused,
                                          obscureCardNumber: true,
                                          obscureCardCvv: true,
                                        ),
                                        CreditCardForm(
                                          formKey: formKey,
                                          obscureCvv: true,
                                          obscureNumber: false,
                                          cardNumberDecoration:
                                              const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Number',
                                            hintText: 'XXXX XXXX XXXX XXXX',
                                          ),
                                          expiryDateDecoration:
                                              const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Expired Date',
                                            hintText: 'XX/XX',
                                          ),
                                          cvvCodeDecoration:
                                              const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'CVV',
                                            hintText: 'XXX',
                                          ),
                                          cardHolderDecoration:
                                              const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Card Holder',
                                          ),
                                          onCreditCardModelChange:
                                              (CreditCardModel data) {
                                            setState(() {
                                              cardNumber = data.cardNumber;
                                              expiryDate = data.expiryDate;
                                              cardHolderName =
                                                  data.cardHolderName;
                                              cvvCode = data.cvvCode;
                                              isCvvFocused = data.isCvvFocused;
                                            });
                                          },
                                        ),
                                        Center(
                                          child: MaterialButton(
                                            height: 40,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            onPressed: () {
                                              if (formKey.currentState
                                                  .validate()) {
                                                print("Paid");
                                                Provider.of<Orders>(context,
                                                        listen: false)
                                                    .addOrder(
                                                        cart.items.values
                                                            .toList(),
                                                        cart.totalAmount,
                                                        formattedDate,
                                                        formattedTime);
                                                cart.clear();
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                    "Payment Successful!",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                        color: Colors.black),
                                                  ),
                                                  backgroundColor: Colors.white,
                                                  duration: const Duration(
                                                      seconds: 5),
                                                ));
                                              } else {
                                                print("Payment error");
                                              }
                                            },
                                            child: Text(
                                              'Pay',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )));
                        }
                      },
                      child: Text(
                        "BOOK",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  checkProfileComplete() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var firebaseUser = auth.currentUser;
    String address, age, phoneNum;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser.uid)
        .get()
        .then((DocumentSnapshot document) {
      address = document["address"];
      age = document["age"];
      phoneNum = document["phoneNum"];
    });

    if (address.isEmpty || age.isEmpty || phoneNum.isEmpty) {
      profileComplete = "false";
    } else {
      profileComplete = "true";
    }
  }
}

// class BookButton extends StatefulWidget {
//   final Cart cart;

//   const BookButton({@required this.cart});
//   @override
//   _BookButtonState createState() => _BookButtonState();
// }

// class _BookButtonState extends State<BookButton> {
//   @override
//   Widget build(BuildContext context) {
//     return FlatButton(
//       child: Text(
//         'Pay',
//       ),
//       onPressed: widget.cart.totalAmount <= 0
//           ? null
//           : () async {
//               print("paid");
//               await Provider.of<Orders>(context, listen: false).addOrder(
//                   widget.cart.items.values.toList(), widget.cart.totalAmount);
//               widget.cart.clear();
//             },
//       splashColor: Colors.white,
//     );
//   }
// }
