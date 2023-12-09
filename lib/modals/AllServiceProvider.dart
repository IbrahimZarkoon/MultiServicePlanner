import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import '../Response/ServiceResponse.dart';

class AllServiceProvider extends ChangeNotifier{

  List<ServiceResponse>? photographers;
  List<ServiceResponse>? decors;
  List<ServiceResponse>? caterers;
  List<ServiceResponse>? venues;

  List<String> items = ["1", "2", "3", "7"];


  Future<void> fetchData(String id) async {
    var url = Uri.parse(
        'https://everythingforpageants.com/msp/api/getServiceDetailsByServiceId.php');
    var response = await http.post(url, body: json.encode({"service_id": id}));
    var decodedJson = jsonDecode(response.body);
    List<dynamic> dataArray = decodedJson;
    print("KHHHHH===================== $dataArray");

    if (id == "1") {
      photographers =
          dataArray.map((item) => ServiceResponse.fromJson(item)).toList();
      notifyListeners();
    }
    if (id == "2") {
      decors =
          dataArray.map((item) => ServiceResponse.fromJson(item)).toList();
      notifyListeners();

    }
    if (id == "3") {
      venues =
          dataArray.map((item) => ServiceResponse.fromJson(item)).toList();
      notifyListeners();

    }
    if (id == "7") {
      caterers =
          dataArray.map((item) => ServiceResponse.fromJson(item)).toList();
      notifyListeners();

    }
  }

  Future<void> fetchDataForAllItems() async {
    for (var item in items) {
      await fetchData(item);
    }
  }
}