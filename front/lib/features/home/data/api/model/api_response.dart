class ApiResponse {
  final String response;

  ApiResponse.fromApi(Map<String, dynamic> map)
      : response = map['response'];
}