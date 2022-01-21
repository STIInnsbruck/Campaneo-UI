import 'package:campaneo_app/data/models.dart';

class User {

  String _name;
  int _points;
  int _completedCampaigns;
  List<Campaign> acceptedCampaigns = new List();
  List<Campaign> rejectedCampaigns = new List();
  List<dynamic> newCampaigns = new List();

  User(String name, int points, int completedCampaigns) {
    this._name = name;
    this._points = points;
    this._completedCampaigns = completedCampaigns;
    this.newCampaigns.add(setOldVersionCampaigns1());
    this.newCampaigns.add(setOldVersionCampaigns2());
    this.newCampaigns.add(setOldVersionCampaigns3());
  }

  String get getName => _name;
  int get getPoints => _points;
  int get getCompletedCampaigns => _completedCampaigns;

  void setCompletedCampaigns(int value) {
    _completedCampaigns = value;
  }

  Campaign setOldVersionCampaigns1() {
    Address tyrolAddr = Address(
        country: "Austria",
        city: "Innsbruck",
        number: "1",
        street: "Haupstraße 1"
    );

    Organization tyrolgov = Organization(
        name: "Tyrol Government",
        email: "tirolatgov.at",
        address: tyrolAddr,
        phone: "+43512 9079186"
    );

    Campaign driveSmart = new Campaign(
        id: "Drive Smart",
        name: "Drive Smart",
        description: "New investments in sidewalks, bike lanes, and other improvements are supporting more walking and bicycling in Tyrol. Officials are making safety a priority since pedestrians and bicyclists currently account for more than a quarter of the total traffic fatalities in the region.",
        gdprClassification: "classification",
        imageUrl: "imageUrl",
        organization: tyrolgov,
        validFrom: "10.02.2021",
        validTo: "10.02.2022"
    );

    return driveSmart;
  }

  Campaign setOldVersionCampaigns2() {
    Address addr = Address(
        country: "Germany",
        city: "Munich",
        number: "28",
        street: "Königstraße 28"
    );

    Organization org = Organization(
        name: "Allianz Insurance",
        email: "info@allianz.de",
        address: addr,
        phone: "+49 89 3800-0"
    );

    Campaign driveSmart = new Campaign(
        id: "Allianz Smart",
        name: "Street Smart",
        description: "As the amount of vehicles increase on the roads, so do the chances of accidents increase. Sharing your data can greatly help us collect a dataset to analyse when and why car accidents happen.",
        gdprClassification: "classification",
        imageUrl: "imageUrl",
        organization: org,
        validFrom: "10.02.2021",
        validTo: "10.02.2022"
    );

    return driveSmart;
  }

  Campaign setOldVersionCampaigns3() {
    Address tyrolAddr = Address(
        country: "Austria",
        city: "Innsbruck",
        number: "1",
        street: "Haupstraße 1"
    );

    Organization tyrolgov = Organization(
        name: "Tyrol Government",
        email: "tirolatgov.at",
        address: tyrolAddr,
        phone: "+43512 9079186"
    );

    Campaign driveSmart = new Campaign(
        id: "Green Future",
        name: "Green Future",
        description: "New investments in sidealks, bike lanes, and other improvements are supporting more walking and bicycling in Tyrol. Officials are making safety a priority since pedestrians and bicyclists currently account for more than a quarter of the total traffic fatalities in the region.",
        gdprClassification: "classification",
        imageUrl: "imageUrl",
        organization: tyrolgov,
        validFrom: "10.02.2021",
        validTo: "10.02.2022"
    );

    return driveSmart;
  }


  void setPoints(int value) {
    _points = value;
  }

  set setName(String value) {
    _name = value;
  }

  void setPointsVoid(int i) {
    _points = i;
  }
}