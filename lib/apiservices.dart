import 'package:http/http.dart' as http;
import 'trivialLocation.dart';
import 'dart:convert';

class Apiservices {
  // Add your API service methods here
  
  Future<TrivialLocation> requestTrivialLocation(String number) async {
    String apiUrl = 'http://numbersapi.com/$number/trivia?json';

    try {
      return await http
        .get(Uri.parse(apiUrl))
        .then((value) {
          if (value.statusCode == 200) {
            // If the server returns an OK response, parse the JSON
            return processResponse(value.body);
          } else {
            // If the server did not return a 200 OK response, throw an exception
            throw Exception('โหลดข้อมูล Number Trivia ไม่สำเร็จ');
          } 
        });
    } catch (e) {
      // Handle any exceptions that occur during the request
      throw Exception('เกิดข้อผิดพลาดขณะเรียก : $e');
    }    
  }

  TrivialLocation processResponse(String responseBody) {
    return TrivialLocation.fromJson(jsonDecode(responseBody));    
  }
}
