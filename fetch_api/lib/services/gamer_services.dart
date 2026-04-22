import 'package:fetch_api/models/game_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class GamerServices {
  Future<List<GamerPowerModels>> readApi() async {
    try {
      http.Response response = await http.get(
        Uri.parse('https://www.gamerpower.com/api/giveaways'),
      );
      if (response.statusCode == 200) {
        return compute(gamerPowerModelsFromJson, response.body);
      } else {
        throw Exception("ERROR: APU STATUS: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Exception: ${e.toString()}");
    }
  }
}
