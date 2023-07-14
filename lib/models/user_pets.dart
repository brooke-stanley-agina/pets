import 'dart:convert';

UserPets userPetsFromJson(String str) => UserPets.fromJson(json.decode(str));

String userOetsToJson(UserPets data) => json.encode(data.toJson());

class UserPets {
    List<Datum> data;

    UserPets({
        required this.data,
    });

    factory UserPets.fromJson(Map<String, dynamic> json) => UserPets(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int? id;
    String? userName;
    String? petName;
    String? petImage;
    bool isFriendly;

    Datum({
        required this.id,
        required this.userName,
        required this.petName,
        required this.petImage,
        required this.isFriendly,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userName: json["userName"],
        petName: json["petName"],
        petImage: json["petImage"],
        isFriendly: json["isFriendly"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "petName": petName,
        "petImage": petImage,
        "isFriendly": isFriendly,
    };
}