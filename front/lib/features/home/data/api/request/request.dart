import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';


Future<void> getOutput() async {
  var url = 'http://localhost:8080/output';
  await http.get(Uri.parse(url), headers: {
    "Content-Type": "application/json",
    "uuid": const Uuid().v4(),
  }).then((http.Response response) {
    debugPrint("Response status: ${response.statusCode}");
    debugPrint("Response body: ${response.contentLength}");
    debugPrint(response.body);
    var output = json.decode(response.body);
  });
}