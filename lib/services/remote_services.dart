// class responsible for fetching data from internet

import 'package:rest_api_flutter/models/post.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  Future<List<Post>?> getPosts() async {
    var client = http.Client();
    var url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    var response = await client.get(url);
    if (response.statusCode == 200) {
      // get the body part of response which is json string
      var json = response.body;
      return postFromJson(json);
    }
  }
}
