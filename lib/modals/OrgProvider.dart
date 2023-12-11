import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as https;

import '../Response/SingleVendorPackagesResponse.dart';

class OrgProvider extends ChangeNotifier{
  String _orgID = '';
  String _serviceID = '';

  List<SingleVendorPackagesResponse> _packagesList = [];

  // Getter
  List<SingleVendorPackagesResponse> get packagesList {
    return _packagesList;
  }

  // Setter
  set packagesList(List<SingleVendorPackagesResponse> newList) {
    _packagesList = newList;
  }
  Future<void> getPackagesData(String id)
  async {
    print("$id");
    var bodyJson = {"id":id};

    var request =
    https.post(Uri.parse("https://everythingforpageants.com/msp/api/getServiceDetailsById.php"),body: jsonEncode(bodyJson));

    // Add the id to the request as form data

    var response = await request;

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Got packages successfully!");
      // print("Response: ${response}");
      // Decode the response data
      var decodedData = json.decode(response.body);

      // Assuming that the decoded data is a list of SingleVendorPackagesResponse
      packagesList = List<SingleVendorPackagesResponse>.from(
        decodedData.map((item) => SingleVendorPackagesResponse.fromJson(item)),
      );

      //await ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(milliseconds: 1500),content: Text("Got packages successfully.")));

      //Navigator.push(context, CupertinoPageRoute(builder: (_) => const OrganizerLogin()));

    } else {
      print("Get packages request failed with status: ${response.statusCode}");
      print("Response: $response");
    }

    notifyListeners();
  }

 String get orgID => _orgID;

 set orgID(String value)
 {
   _orgID = value;
   notifyListeners();
 }

  String get serviceID => _serviceID;

  set serviceID(String value)
  {
    _serviceID = value;
    notifyListeners();
  }
}