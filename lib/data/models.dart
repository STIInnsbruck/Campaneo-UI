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
  String organizationId;
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
    this.organizationId,
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
        this.organizationId = map['organization'],
        this.organization = map['organization'];

  String _getFormattedDate(String date) =>
      DateFormat("dd.MM.yyyy").format(DateTime.parse(date));

  String getDateRange() =>
      'From ${_getFormattedDate(validFrom)} To ${_getFormattedDate(validTo)}';
}

class Organization {
  final String id;
  final String name;
  final String email;
  final String phone;
  final Address address;

  Organization({this.id, this.name, this.email, this.phone, this.address});

  Organization.fromLazyCacheMap(LazyCacheMap map)
      : this.id = map['id'],
        this.name = map['name'],
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
  final String postCode;
  final String street;
  final String number;

  Address({this.street, this.number, this.city, this.country, this.postCode});

  String getPrintableAddress() {
    return '${this.street} ${this.number}, ${this.city}, ${this.postCode}. ${this.country}';
  }
}
