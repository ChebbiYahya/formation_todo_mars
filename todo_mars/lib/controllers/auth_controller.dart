import 'dart:convert';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../config.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  
  Future<Map<String, dynamic>> signinController(UserModel user) async {
    var reqBody = {"email": user.email, "password": user.password};

    var response = await http.post(
      Uri.parse(login),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status'] == true) {
      var myToken = jsonResponse['token'];
      return {
        "status": true,
        "success": "User Registered Successfully",
        "token": myToken,
      };
    } else {
      return {
        "status": false,
        "error": jsonResponse['message'] ?? "Registration Failed",
      };
    }
  }

  Future<Map<String, dynamic>> signupController(UserModel user) async {
    var response = await http.post(
      Uri.parse(register),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user.toJson()),
    );
    var jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      return {"status": true, "success": "User Registered Successfully"};
    } else {
      return {
        "status": false,
        "error": jsonResponse['message'] ?? "Registration Failed",
      };
    }
  }
}
