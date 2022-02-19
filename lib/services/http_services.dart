import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpServices {
  Future<http.Response> sendWelcomeMailToStaff(String subject, String name,
      String username, String password, String email) async {
    print("api Called");
    final serviceId = "service_q9ragl4";
    final templateId = "template_9sw5f5i";
    final userId = "user_DsDXWUCzHAMWigHrnwBeI";

    var url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    var encodedBody = jsonEncode({
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': userId,
      'template_params': {
        'subject': subject,
        'name': name,
        'username': username,
        'password': password,
        'to_email': email
      }
    });
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: encodedBody);
    /*print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');*/
    return response;
  }
}
