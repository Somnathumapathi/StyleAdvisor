import 'package:dio/dio.dart';
import 'package:salonadvisor/data/haircut.dart';
import 'package:salonadvisor/globalvars.dart';

class RecommendationServices {
  static Future<List<Haircut>?> getRecommendations(
      {required Gender gen, required String shape}) async {
    final dio = Dio();
    try {
      final res = await dio.get('$uri/getRecommendations',
          queryParameters: {'gen': gen, 'shape': shape});
      print(res.data.toString());
      if (res.statusCode == 200) {
        final List<dynamic> recommendationData = (res.data);
        final recommendationList = recommendationData.map((e) {
          return Haircut.fromMap(e);
        }).toList();
        print(recommendationList);
        return recommendationList;
        // return Haircut.fromMap(res.data);
      }
    } catch (e) {
      print(e);
    }
  }
}
