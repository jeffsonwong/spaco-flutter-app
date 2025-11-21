import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Service with ChangeNotifier {
  final String serviceID;
  final String serviceType;
  final String serviceName;
  final String serviceDescription;
  final String imgUrl;
  final double servicePrice;

  Service(
      {@required this.serviceID,
      @required this.serviceName,
      @required this.serviceType,
      @required this.serviceDescription,
      this.imgUrl,
      @required this.servicePrice});
}

class Services with ChangeNotifier {
  List<Service> _items = [
    Service(
      serviceID: '1',
      serviceName: 'Aircond Services',
      imgUrl:
          'https://image.freepik.com/free-vector/air-conditioner-repair-repairman-with-tools_33099-272.jpg',
      servicePrice: 110,
      serviceType: 'Maintenance',
      serviceDescription: 'Description......',
    ),
    Service(
      serviceID: '2',
      serviceName: 'Plumbing Services',
      imgUrl:
          'https://www.pinclipart.com/picdir/big/63-632487_plumbing-pipe-vector-plumber-black-and-white-clipart.png',
      servicePrice: 50,
      serviceType: 'Maintenance',
      serviceDescription: 'Description......',
    ),
    Service(
      serviceID: '3',
      serviceName: 'Cleaning Services',
      imgUrl:
          'https://image.freepik.com/free-vector/cleaners-workers-with-cleaning-equipment_18591-56149.jpg',
      servicePrice: 100,
      serviceType: 'Cleaning',
      serviceDescription: 'Description.......',
    ),
    Service(
      serviceID: '4',
      serviceName: 'Disinfection Services',
      imgUrl:
          'https://image.freepik.com/free-vector/disinfection-concept-man-yellow-protective-hazmat-suit_153097-8.jpg',
      servicePrice: 200,
      serviceType: 'Cleaning',
      serviceDescription: 'Description......',
    ),
    Service(
      serviceID: '5',
      serviceName: 'Moving Services',
      imgUrl:
          'https://media.istockphoto.com/vectors/print-vector-id1045249074?b=1&k=6&m=1045249074&s=612x612&w=0&h=jdHWwFFKqVxUgUjWdQc9Z4WBwg2bimlRLzanIO540mY=',
      servicePrice: 160,
      serviceType: 'Moving',
      serviceDescription: 'Description......',
    ),
    Service(
      serviceID: '6',
      serviceName: 'Appliances Repair',
      imgUrl:
          'https://images.assetsdelivery.com/compings_v2/laolina/laolina2004/laolina200400098.jpg',
      servicePrice: 80,
      serviceType: 'Maintenance',
      serviceDescription: 'Description.......',
    ),
  ];

  List<Service> get items {
    return [..._items];
  }

  Service findById(String serviceID) {
    return _items.firstWhere((svcs) => svcs.serviceID == serviceID);
  }
}
