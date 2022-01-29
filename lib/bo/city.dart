class City {
  String id;
  String name;
  String image;

  City(this.id, this.name, this.image);

  City.fromJson(Map<String, dynamic> json)
      : id = json["id"].toString(),
        name = json["name"],
        image = json["pic"]["url"];

  Map<String, dynamic> toJson() => {"id": id, "name": name, "image": image};
}
