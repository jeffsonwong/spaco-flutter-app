import 'package:flutter/cupertino.dart';

class CartItem {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String spID;
  final String spName;
  final String spPhoneNum;
  final String spAddress;
  CartItem(
      {@required this.id,
      @required this.name,
      @required this.price,
      @required this.quantity,
      @required this.spID,
      @required this.spName,
      @required this.spPhoneNum,
      @required this.spAddress});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String svcsid, String name, double price, String spID,
      String spName, String spPhoneNum, String spAddress) {
    if (_items.containsKey(svcsid)) {
      _items.update(
          svcsid,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              name: existingCartItem.name,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity + 1,
              spID: existingCartItem.spID,
              spName: existingCartItem.spName,
              spPhoneNum: existingCartItem.spPhoneNum,
              spAddress: existingCartItem.spAddress));
    } else {
      _items.putIfAbsent(
          svcsid,
          () => CartItem(
                id: svcsid,
                name: name,
                price: price,
                quantity: 1,
                spID: spID,
                spName: spName,
                spPhoneNum: spPhoneNum,
                spAddress: spAddress,
              ));
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) {
      return;
    }
    if (_items[id].quantity > 1) {
      _items.update(
          id,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              name: existingCartItem.name,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity - 1,
              spID: existingCartItem.spID,
              spName: existingCartItem.spName,
              spPhoneNum: existingCartItem.spPhoneNum,
              spAddress: existingCartItem.spAddress));
    }
    notifyListeners();
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
