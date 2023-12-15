import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:model_scample/appUtils/appUtils.dart';
import 'package:model_scample/model/details_model.dart';

class HomeScreenController with ChangeNotifier {
  DetailsModel detailsModel = DetailsModel();
  Map<String, dynamic> decodeData = {};

  Future getData() async {
    final url = Uri.parse("${AppUtils.baseURL}/api/addemployee/");
    final response = await http.get(url);

    print(response.statusCode);

    if (response.statusCode == 200) {
      decodeData = jsonDecode(response.body);
      print(decodeData);
      detailsModel = DetailsModel.fromJson(decodeData);
    } else {
      print("api failed");
    }
    notifyListeners();
  }

  Future postData({required String empName, required String des}) async {
    final url = Uri.parse("${AppUtils.baseURL}/api/addemployee/");
    final response = await http.post(url, body: {
      "employee_name": empName,
      "designation": des,
    });

    print(response.statusCode);

    if (response.statusCode == 200) {
      await getData();
    } else {
      print("api failed");
    }
    notifyListeners();
  }

  Future deleteData({required String? id}) async {
    final url = Uri.parse("${AppUtils.baseURL}/api/addemployee/$id/");
    final response = await http.delete(url);

    print(response.statusCode);

    if (response.statusCode == 200) {
      decodeData = jsonDecode(response.body);
      print(decodeData);
      detailsModel = DetailsModel.fromJson(decodeData);
      await getData();
    } else {
      print("api failed");
    }
    notifyListeners();
  }

  Future updateData(
      {required String empName,
      required String des,
      required String id}) async {
    final url = Uri.parse("${AppUtils.baseURL}/api/addemployee/$id/");
    final response = await http.put(url, body: {
      "employee_name": empName,
      "designation": des,
    });
    if (response.statusCode == 200) {
      await getData();
    } else {
      print("api failed");
    }
    notifyListeners();
  }
}
