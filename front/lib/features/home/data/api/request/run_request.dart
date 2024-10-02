import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';


Future<String> sendRequest(
    String code) async {
  var url = 'http://localhost:8080';
  await http
      .post(Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "uuid": const Uuid().v4()
      },
      body: json.encode({
        "code": {"code": code, "language": "Java"},
        "input": {"words": ""}
      }))
      .then((http.Response response) {
    var output = json.decode(response.body);
    return output["output"];
  });
  return "";
}