import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_service_planner/Screens/HomePage.dart';

import '../Enums/Colors.dart';
import '../constants.dart';
import 'Headings.dart';
import 'package:http/http.dart' as http;

class NotifBottomModal extends StatefulWidget {
  String image;
  String? id;
  String content;

  NotifBottomModal(
    this.image,
    this.content,
    this.id,
  );

  @override
  State<NotifBottomModal> createState() => _NotifBottomModalState();
}

class _NotifBottomModalState extends State<NotifBottomModal> {
  final ImagePicker _BannerPicker = ImagePicker();
  File? paymentSS;

  void PaymentSubmit() async {
    Uri url = Uri.parse(
        'https://everythingforpageants.com/msp/api/paymentScreenshot.php');

    var formData = http.MultipartRequest('POST', url);
    formData.fields.addAll({
      "id": '${widget.id}',
    });

    if (paymentSS != null) {
      formData.files.add(
        await http.MultipartFile.fromPath('screenshot', paymentSS!.path),
      );
    }

    var response = await formData.send();

    var responseBody = await response.stream.bytesToString();
    print(responseBody);

    var decodedJson = jsonDecode(responseBody) as Map<String, dynamic>;
    if (decodedJson["Status"] == "200") {
      Navigator.push(context,
          CupertinoPageRoute(builder: (BuildContext context) => HomePage()));
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        height: MediaQuery.of(context).size.height * 0.55,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Image Container
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(right: 0, top: 20, bottom: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                      image: DecorationImage(
                          image:
                              AssetImage("assets/images/logos/ICON ; MSP.png"),
                          fit: BoxFit.scaleDown)),
                ),
              ],
            ),

            Text(
              "${widget.content}",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 14),
            ),

            const SizedBox(
              height: 15,
            ),

            RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'Meezan Bank Limited',
                    style: TextStyle(
                        //fontWeight: FontWeight.normal,
                        fontSize: MediaQuery.sizeOf(context).height * 0.024,
                        fontFamily: "OpenSans_Bold",
                        color: Colors.black.withOpacity(0.8)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),

            //Acc Title
            RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'Title : ',
                    style: TextStyle(
                        fontSize: MediaQuery.sizeOf(context).height * 0.02,
                        fontFamily: "OpenSans_SemiBold",
                        color: Colors.black.withOpacity(0.8)),
                  ),
                  TextSpan(
                    style: TextStyle(
                      color: appPrimary,
                      //fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.sizeOf(context).height * 0.02,
                    ),
                    text: 'Mohammad Ibrahim Khan Zarkoon',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),

            //Acc #
            RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'Account # : ',
                    style: TextStyle(
                        fontSize: MediaQuery.sizeOf(context).height * 0.02,
                        fontFamily: "OpenSans_SemiBold",
                        color: Colors.black.withOpacity(0.8)),
                  ),
                  TextSpan(
                    style: TextStyle(
                      color: appPrimary,
                      //fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.sizeOf(context).height * 0.02,
                    ),
                    text: '01160104089591',
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 5,
            ),

            //IBAN #
            RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'IBAN # : ',
                    style: TextStyle(
                        fontSize: MediaQuery.sizeOf(context).height * 0.02,
                        fontFamily: "OpenSans_SemiBold",
                        color: Colors.black.withOpacity(0.8)),
                  ),
                  TextSpan(
                    style: TextStyle(
                      color: appPrimary,
                      //fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.sizeOf(context).height * 0.02,
                    ),
                    text: 'PK06MEZN0001160104089591',
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            shadowLine(context),

            const SizedBox(
              height: 15,
            ),

            //Upload Ss Row
            InkWell(
              onTap: () {
                showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoActionSheet(
                        title: const Text("Edit Photo"),
                        cancelButton: CupertinoActionSheetAction(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        actions: [
                          CupertinoActionSheetAction(
                              onPressed: () async {
                                final XFile? image =
                                    await _BannerPicker.pickImage(
                                        source: ImageSource.gallery);
                                if (image == null) return;

                                // Convert XFile to File
                                final imageTemp = File(image.path);

                                setState(() {
                                  paymentSS =
                                      imageTemp; // Assign to the File variable
                                  //regOrgProv.selfie = imageTemp;
                                });
                                Navigator.pop(context);
                              },
                              child: const Text("Choose Photo")),
                          CupertinoActionSheetAction(
                              onPressed: () async {
                                final XFile? image =
                                    await _BannerPicker.pickImage(
                                        source: ImageSource.camera);
                                if (image == null) return;

                                // Convert XFile to File
                                final imageTemp = File(image.path);

                                setState(() {
                                  paymentSS =
                                      imageTemp; // Assign to the File variable
                                  //regOrgProv.selfie = imageTemp;
                                });
                                Navigator.pop(context);
                              },
                              child: const Text("Take Photo")),
                        ],
                      );
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Icon Con
                  Container(
                    margin: const EdgeInsets.only(right: 15, top: 0),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(100)),
                    child: Icon(
                      Icons.screenshot_monitor,
                      color: Colors.white,
                      size: MediaQuery.sizeOf(context).height * 0.03,
                    ),
                  ),

                  Text(
                    "Upload Payment Proof",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontSize: MediaQuery.sizeOf(context).height * 0.02),
                  ),

                  Spacer(),

                  paymentSS?.path != null ? Icon(Icons.check) : SizedBox(),
                ],
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            //Paid / Confirm Row
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Icon Con
                Container(
                  margin: const EdgeInsets.only(right: 15, top: 0),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: MediaQuery.sizeOf(context).height * 0.03,
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    PaymentSubmit();
                  },
                  child: Text(
                    "Confirm / Paid",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontSize: MediaQuery.sizeOf(context).height * 0.02),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ]);
  }
}
