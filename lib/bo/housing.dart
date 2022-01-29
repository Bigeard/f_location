import 'package:latlng/latlng.dart';

class Housing {
  String title;
  String price;
  String image;
  LatLng latLng;
  String owner;
  List<dynamic> listDateAvailable;

  Housing(this.title, this.price, this.image, this.latLng, this.owner,
      this.listDateAvailable);

  Housing.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        price = json["price"].toString(),
        image = json["illustrations"]["url"],
        latLng = LatLng(json["lat"], json["lng"]),
        owner = json["owner"],
        listDateAvailable = json["listDateAvailable"];

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "image": image,
        "latLng": latLng,
        "owner": owner,
        "listDateAvailable": listDateAvailable
      };
}
