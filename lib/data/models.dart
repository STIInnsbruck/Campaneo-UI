import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:campaneo_app/widgets/status_widget.dart';
import 'package:campaneo_app/data/sensor.dart';
import 'package:campaneo_app/faker/fake_sensors.dart';

class Campaign {
  String id;
  String name;
  String description;
  String imageUrl;
  String validFrom;
  String validTo;
  String gdprClassification;
  Organization organization;
  Status status = Status.New;
  List<Sensor> sensorList = new FakeSensors().sensorList;

  Campaign({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.validFrom,
    this.validTo,
    this.gdprClassification,
    this.organization,
  });

  Campaign.fromLazyCacheMap(LazyCacheMap map)
      : this.id = map['id'],
        this.name = map['name'],
        this.description = map['description'],
        this.imageUrl = map['image_url'],
        this.validFrom = map['valid_from'],
        this.validTo = map['valid_to'],
        this.gdprClassification = map['gdpr_classification'],
        this.organization = (map['organization'] != null)
            ? Organization.fromLazyCacheMap(map['organization'])
            : null;

  String _getFormattedDate(String date) =>
      DateFormat("dd-MM-yyyy").format(DateTime.parse(date));

  String getDateRange() =>
      '${_getFormattedDate(validFrom)} to ${_getFormattedDate(validTo)}';
}

class Organization {
  final String name;
  final String email;
  final String phone;
  final Address address;

  Organization({this.name, this.email, this.phone, this.address});

  Organization.fromLazyCacheMap(LazyCacheMap map)
      : this.name = map['name'],
        this.email = map['contact_email'],
        this.phone = map['phone_number'],
        this.address = Address(
            country: map['country'],
            city: map['city'],
            street: map['street'],
            number: map['street_number']);
}

class Address {
  final String country;
  final String city;
  final String street;
  final String number;

  Address({this.street, this.number, this.city, this.country});

  String getPrintableAddress() {
    return '${this.street} ${this.number}, ${this.city}. ${this.country}';
  }
}
