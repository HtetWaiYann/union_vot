import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:theunion/models/user.dart';
import 'package:theunion/resources/app_config.dart';
import 'dart:convert';

import 'package:theunion/services/functions_provider.dart';

import '../models/votstatus.dart';

class API {
  final String _baseURL = "https://theunion.eastasia.cloudapp.azure.com/api";
  final _header = {"Content-Type": "application/json"};
  final _functionsProvider = FunctionsProvider();

  Future<UserResponse> signin(String username, String password) async {
    final body = {"username": username, "password": password};

    final resBody = jsonEncode(body);
    var response;
    try {
      response = await http.post(Uri.parse("$_baseURL/auth/signin"),
          body: resBody, headers: _header);
    } catch (e) {
      throw Exception(CONNECTION_ERROR);
    }

    if (response.statusCode == 200) {
      UserResponse user = UserResponse.fromRawJson(response.body);
      if (user.returncode == '200') {
        if (user.data?.votData == null) {
          throw Exception('User not authorized to use this app.');
        }
        return user;
      } else {
        throw Exception(user.message);
      }
    } else {
      throw Exception("Invalid Username or Password.");
    }
  }

  Future<VotStatus> updateVOTStatus(String status) async {
    String token = await _functionsProvider.getToken();
    String votPatientID = await _functionsProvider.getVOTPatientID();
    var tokenHeader = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    final body = {"votpatientid": votPatientID, "votstatus": status};
    debugPrint('${body.toString()}');
    final resBody = jsonEncode(body);
    var response;
    try {
      response = await http.post(Uri.parse("$_baseURL/votpatients/update"),
          body: resBody, headers: tokenHeader);
    } catch (e) {
      throw Exception(CONNECTION_ERROR);
    }

    debugPrint('${response.statusCode}');

    if (response.statusCode == 200) {
      VotStatus votStatus = VotStatus.fromRawJson(response.body);
      if (votStatus.returncode == '200') {
        return votStatus;
      } else {
        throw Exception(votStatus.message);
      }
    } else {
      throw Exception("Invalid Username or Password.");
    }
  }
}
