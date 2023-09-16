class LocationModelClass {
  List<Locations>? locations;
  LocationModelClass({this.locations});
  LocationModelClass.fromJson(Map<String, dynamic> json) {
    if (json['location'] != null) {
      locations = <Locations>[];
      json['location'].forEach((v) {
        locations!.add(new Locations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.locations != null) {
      data['location'] = this.locations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Locations {
  int? id;
  String? storeName;
  String? storeUrl;
  String? consumerKey;
  String? consumerSecret;
  Locations(
      {this.id,
        this.storeName,
        this.storeUrl,
        this.consumerKey,
        this.consumerSecret});

  Locations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeName = json['StoreName'];
    storeUrl = json['StoreUrl'];
    consumerKey = json['consumer_key'];
    consumerSecret = json['consumer_secret'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['StoreName'] = this.storeName;
    data['StoreUrl'] = this.storeUrl;
    data['consumer_key'] = this.consumerKey;
    data['consumer_secret'] = this.consumerSecret;
    return data;
  }
}