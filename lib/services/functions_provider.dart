import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class FunctionsProvider {
  // encryption key
  final encryptKey = "samplekey";

  // encrypt the data
  setEncrypt(data) {
    final key = encrypt.Key.fromUtf8(encryptKey);
    final iv = encrypt.IV.fromLength(16);

    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(data, iv: iv);

    return encrypted.base64;
  }

  // Decrypt the data
  getDecrypt(data) {
    try {
      final key = encrypt.Key.fromUtf8(encryptKey);
      final iv = encrypt.IV.fromLength(16);
      final encrypter = encrypt.Encrypter(encrypt.AES(key));
      final encrypted = encrypt.Encrypted.fromBase64(data);
      final decrypted = encrypter.decrypt(encrypted, iv: iv);

      return decrypted;
    } catch (e) {
      return data;
    }
  }

  // Get the token from local database
  getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var encrypted_token = prefs.getString('token');
      var token = '';
      if (encrypted_token != null && encrypted_token != '') {
        token = getDecrypt(encrypted_token);
      }
      return token;
    } catch (err) {
      return '';
    }
  }

  getPatientInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var encrypted_info = prefs.getString('info');
      var info = '';
      if (encrypted_info != null && encrypted_info != '') {
        info = getDecrypt(encrypted_info);
      }
      return info;
    } catch (err) {
      return '';
    }
  }

  getVOTStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var encrypted_info = prefs.getString('info');
      var info = '';
      if (encrypted_info != null && encrypted_info != '') {
        info = getDecrypt(encrypted_info);
      }
      var json_info = jsonDecode(info);
      return json_info['votstatus'];
    } catch (err) {
      return '';
    }
  }

    getVOTPatientID() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var encrypted_info = prefs.getString('info');
      var info = '';
      if (encrypted_info != null && encrypted_info != '') {
        info = getDecrypt(encrypted_info);
      }
      var json_info = jsonDecode(info);
      return json_info['votpatientid'];
    } catch (err) {
      return '';
    }
  }

}
