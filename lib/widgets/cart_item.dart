import 'package:flutter/material.dart';
import 'package:flutter_loginregister/userScreen/servicedetails.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';

class CartSvcs extends StatelessWidget {
  final String id;
  final String serviceId;
  final double price;
  final int quantity;
  final String name;
  final String spID;
  final String spName;
  final String spPhoneNum;
  final String spAddress;
  CartSvcs(this.id, this.serviceId, this.name, this.price, this.quantity,
      this.spID, this.spName, this.spPhoneNum, this.spAddress);
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        MediaQuery(
          data: MediaQueryData(padding: EdgeInsets.zero),
          child: Padding(
            padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(ServiceDetailsPage.routeName,
                    arguments: serviceId);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: ListTile(
                  tileColor: Colors.white,
                  contentPadding: EdgeInsets.only(left: 6, right: 6),
                  title: Row(
                    children: <Widget>[
                      //Minus button
                      IconButton(
                        iconSize: 18,
                        padding: EdgeInsets.all(0),
                        constraints: BoxConstraints(),
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          Provider.of<Cart>(context, listen: false)
                              .removeSingleItem(serviceId);
                        },
                      ),

                      //Quantity
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                            padding: EdgeInsets.only(left: 5, right: 5, top: 2),
                            height: 21.0,
                            width: 35.0,
                            //Color(0xffa7adba)
                            color: Color(0xff1c87ab),
                            child: Text(
                              '$quantity' 'x',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            )),
                      ),

                      //Add button
                      IconButton(
                        iconSize: 18,
                        padding: EdgeInsets.only(right: 3),
                        constraints: BoxConstraints(),
                        icon: Icon(Icons.add),
                        onPressed: () {
                          Provider.of<Cart>(context, listen: false).addItem(
                              serviceId,
                              name,
                              price,
                              spID,
                              spName,
                              spPhoneNum,
                              spAddress);
                        },
                      ),

                      //Service Text
                      Text(
                        name,
                        style: TextStyle(fontSize: 18),
                      ),

                      Flexible(fit: FlexFit.tight, child: SizedBox()),

                      //subtitle: Text('Total: \$${(price * quantity)}'),
                      //Price Text
                      Text(
                        'RM${(price * quantity).toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.end,
                      ),
                      SizedBox(
                        width: 5,
                      ),

                      IconButton(
                        iconSize: 20,
                        padding: EdgeInsets.all(0),
                        constraints: BoxConstraints(),
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          Provider.of<Cart>(context, listen: false)
                              .removeItem(serviceId);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/*return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.redAccent,
      ),
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(serviceId);
      },
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          MediaQuery(
            data: MediaQueryData(padding: EdgeInsets.zero),
            child: ListTile(
              contentPadding: EdgeInsets.only(left: 6, right: 6),
              title: Row(
                children: <Widget>[
                  IconButton(
                    iconSize: 16,
                    padding: EdgeInsets.only(right: 3),
                    constraints: BoxConstraints(),
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      Provider.of<Cart>(context, listen: false)
                          .removeSingleItem(serviceId);
                    },
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                        padding: EdgeInsets.only(left: 5, right: 5, top: 2),
                        height: 21.0,
                        width: 35.0,
                        color: Color(0xffa7adba),
                        child: Text(
                          '$quantity' 'x',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        )),
                  ),
                  IconButton(
                    iconSize: 16,
                    padding: EdgeInsets.only(right: 3),
                    constraints: BoxConstraints(),
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Provider.of<Cart>(context, listen: false)
                          .addItem(serviceId, name, price);
                    },
                  ),
                  Text(
                    name,
                    style: TextStyle(fontSize: 16),
                  ),
                  Flexible(fit: FlexFit.tight, child: SizedBox()),
                  //subtitle: Text('Total: \$${(price * quantity)}'),//
                  Text(
                    'RM${(price * quantity).toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );*/
