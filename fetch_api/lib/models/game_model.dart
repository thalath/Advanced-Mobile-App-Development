// To parse this JSON data, do
//
//     final gamerPowerModels = gamerPowerModelsFromJson(jsonString);

import 'dart:convert';

List<GamerPowerModels> gamerPowerModelsFromJson(String str) => List<GamerPowerModels>.from(json.decode(str).map((x) => GamerPowerModels.fromJson(x)));

String gamerPowerModelsToJson(List<GamerPowerModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GamerPowerModels {
    int id;
    String title;
    String worth;
    String thumbnail;
    String image;
    String description;
    String instructions;
    String openGiveawayUrl;
    String publishedDate;
    String type;
    String platforms;
    String endDate;
    int users;
    String status;
    String gamerpowerUrl;
    String openGiveaway;

    GamerPowerModels({
        required this.id,
        required this.title,
        required this.worth,
        required this.thumbnail,
        required this.image,
        required this.description,
        required this.instructions,
        required this.openGiveawayUrl,
        required this.publishedDate,
        required this.type,
        required this.platforms,
        required this.endDate,
        required this.users,
        required this.status,
        required this.gamerpowerUrl,
        required this.openGiveaway,
    });

    factory GamerPowerModels.fromJson(Map<String, dynamic> json) => GamerPowerModels(
        id: json["id"],
        title: json["title"],
        worth: json["worth"],
        thumbnail: json["thumbnail"],
        image: json["image"],
        description: json["description"],
        instructions: json["instructions"],
        openGiveawayUrl: json["open_giveaway_url"],
        publishedDate: json["published_date"],
        type: json["type"],
        platforms: json["platforms"],
        endDate: json["end_date"],
        users: json["users"],
        status: json["status"],
        gamerpowerUrl: json["gamerpower_url"],
        openGiveaway: json["open_giveaway"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "worth": worth,
        "thumbnail": thumbnail,
        "image": image,
        "description": description,
        "instructions": instructions,
        "open_giveaway_url": openGiveawayUrl,
        "published_date": publishedDate,
        "type": type,
        "platforms": platforms,
        "end_date": endDate,
        "users": users,
        "status": status,
        "gamerpower_url": gamerpowerUrl,
        "open_giveaway": openGiveaway,
    };
}
