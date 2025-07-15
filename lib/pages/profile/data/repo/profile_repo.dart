import 'package:guruh3/core/constants/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

class ProfileRepo {
  Future<String> updateProfile({
    String? image,
    double? lat,
    double? long,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    try {
      final request = http.MultipartRequest('PUT', Uri.parse(Api.profile));
      request.headers.addAll(
        {
          'accept': 'application/json',
          // 'Content-Type': 'multipart/form-data',
          'Authorization': 'Bearer $token',
        },
      );
      if (image != null) {
        final String imageType = image.split('.').last.toLowerCase();
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            image,
            filename: 'profile_image.$imageType',
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }
      if (lat != null) {
        request.fields['latitude'] = lat.toString();
      }
      if (long != null) {
        request.fields['longitude'] = long.toString();
      }

      final response = await request.send();
      response.stream.bytesToString().then((value) {
        print(value);
      });
      if (response.statusCode == 200) {
        return 'Profile updated successfully';
      }

      throw Exception('Failed to update');
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
