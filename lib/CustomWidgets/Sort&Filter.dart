import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'FilterAccordian.dart';

class SortandFilter extends StatefulWidget {
  const SortandFilter({Key? key}) : super(key: key);

  @override
  State<SortandFilter> createState() => _SortandFilterState();
}

class _SortandFilterState extends State<SortandFilter> {

  bool DHA = false;
  bool NorthNazimabad = false;
  bool gulshan = false;

  bool photographers = false;
  bool caterers = false;
  bool decorators = false;

  bool below100K = false;
  bool from100to150k = false;
  bool to250K = false;
  bool above250K = false;

  bool below50 = false;
  bool _50to100 = false;
  bool _100to200 = false;
  bool above250 = false;


  double _top = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              offset: const Offset(0, -10),
              blurRadius: 15,
              spreadRadius: 1,
            )
          ],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Close Row
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close_rounded,
                        size: 28,
                      ))
                ],
              ),

              //Heading Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 20, left: 15, right: 15),
                    child: Row(
                      children: const [
                        Text("Sort & Filter",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                      ],
                    ),
                  ),
                ],
              ),

              //Location Accordion
              FilterAccordion(
                  title: "Location",
                  content: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        //DHA Row
                        InkWell(
                          onTap: () {
                            setState(() {
                              DHA = !DHA;
                              NorthNazimabad = false;
                              gulshan = false;
                            });
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets.only(bottom: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  DHA
                                      ? Icons.check_circle
                                      : Icons.circle_outlined,
                                  size: 22,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "DHA",
                                  style: TextStyle(
                                      fontWeight: DHA
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: Colors.black.withOpacity(0.8)),
                                )
                              ],
                            ),
                          ),
                        ),

                        //North Nazimabad Row
                        InkWell(
                          onTap: () {
                            setState(() {
                              NorthNazimabad = !NorthNazimabad;
                              DHA = false;
                              gulshan = false;
                            });
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets.only(bottom: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  NorthNazimabad
                                      ? Icons.check_circle
                                      : Icons.circle_outlined,
                                  size: 22,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "North Nazimabad",
                                  style: TextStyle(
                                      fontWeight: NorthNazimabad
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: Colors.black.withOpacity(0.8)),
                                )
                              ],
                            ),
                          ),
                        ),

                        //Gulshan
                        InkWell(
                          onTap: () {
                            setState(() {
                              gulshan = !gulshan;
                              NorthNazimabad = false;
                              DHA = false;
                            });
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets.only(bottom: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  gulshan
                                      ? Icons.check_circle
                                      : Icons.circle_outlined,
                                  size: 22,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Gulshan",
                                  style: TextStyle(
                                      fontWeight: gulshan
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: Colors.black.withOpacity(0.8)),
                                )
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  )),

              //Price Accordion
              FilterAccordion(
                  title: "Price",
                  content: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        //Under 100,000 PKR
                        InkWell(
                          onTap: () {
                            setState(() {
                              below100K = !below100K;
                            });
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets.only(bottom: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      below100K
                                          ? Icons.check_box
                                          : Icons
                                          .check_box_outline_blank_outlined,
                                      size: 22,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Below 100,000 PKR",
                                      style: TextStyle(
                                          fontWeight: below100K
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "32",
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        ),

                        //100K to 150K
                        InkWell(
                          onTap: () {
                            setState(() {
                              from100to150k = !from100to150k;
                            });
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets.only(bottom: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      from100to150k
                                          ? Icons.check_box
                                          : Icons
                                          .check_box_outline_blank_outlined,
                                      size: 22,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "100,000 - 150,000 PKR",
                                      style: TextStyle(
                                          fontWeight: from100to150k
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "30",
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        ),

                        //below 250K
                        InkWell(
                          onTap: () {
                            setState(() {
                              to250K = !to250K;
                            });
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets.only(bottom: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      to250K
                                          ? Icons.check_box
                                          : Icons
                                          .check_box_outline_blank_outlined,
                                      size: 22,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "150,000 - 250,000 PKR",
                                      style: TextStyle(
                                          fontWeight: to250K
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "18",
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        ),

                        //250K +
                        InkWell(
                          onTap: () {
                            setState(() {
                              above250K = !above250K;
                            });
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets.only(bottom: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      above250K
                                          ? Icons.check_box
                                          : Icons
                                          .check_box_outline_blank_outlined,
                                      size: 22,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "250,000 PKR +",
                                      style: TextStyle(
                                          fontWeight: above250K
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "9",
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),

              //Services Accordion
              FilterAccordion(
                  title: "Services",
                  content: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        //Photography Row
                        InkWell(
                          onTap: () {
                            setState(() {
                              photographers = !photographers;
                              caterers = false;
                              decorators = false;
                            });
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets.only(bottom: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  photographers
                                      ? Icons.check_circle
                                      : Icons.circle_outlined,
                                  size: 22,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Photographers",
                                  style: TextStyle(
                                      fontWeight: photographers
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: Colors.black.withOpacity(0.8)),
                                )
                              ],
                            ),
                          ),
                        ),

                        //Catering Row
                        InkWell(
                          onTap: () {
                            setState(() {
                              caterers = !caterers;
                              photographers = false;
                              decorators = false;
                            });
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets.only(bottom: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  caterers
                                      ? Icons.check_circle
                                      : Icons.circle_outlined,
                                  size: 22,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Caterers",
                                  style: TextStyle(
                                      fontWeight: caterers
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: Colors.black.withOpacity(0.8)),
                                )
                              ],
                            ),
                          ),
                        ),

                        //Decorators
                        InkWell(
                          onTap: () {
                            setState(() {
                              decorators = !decorators;
                              photographers = false;
                              caterers = false;
                            });
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets.only(bottom: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  decorators
                                      ? Icons.check_circle
                                      : Icons.circle_outlined,
                                  size: 22,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Decorators",
                                  style: TextStyle(
                                      fontWeight: decorators
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: Colors.black.withOpacity(0.8)),
                                )
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  )),

              //Category Accordion
              FilterAccordion(
                  title: "Capacity",
                  content: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        //Under 50 Person
                        InkWell(
                          onTap: () {
                            setState(() {
                              below50 = !below50;
                            });
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets.only(bottom: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      below50
                                          ? Icons.check_box
                                          : Icons
                                          .check_box_outline_blank_outlined,
                                      size: 22,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Less than 50 persons",
                                      style: TextStyle(
                                          fontWeight: below50
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "32",
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        ),

                        //50 - 100
                        InkWell(
                          onTap: () {
                            setState(() {
                              _50to100 = !_50to100;
                            });
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets.only(bottom: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      _50to100
                                          ? Icons.check_box
                                          : Icons
                                          .check_box_outline_blank_outlined,
                                      size: 22,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "50 - 100 persons",
                                      style: TextStyle(
                                          fontWeight: _50to100
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "30",
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        ),

                        //100 - 200
                        InkWell(
                          onTap: () {
                            setState(() {
                              _100to200 = !_100to200;
                            });
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets.only(bottom: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      _100to200
                                          ? Icons.check_box
                                          : Icons
                                          .check_box_outline_blank_outlined,
                                      size: 22,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "100 to 200 persons",
                                      style: TextStyle(
                                          fontWeight: _100to200
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "18",
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        ),

                        //above 250
                        InkWell(
                          onTap: () {
                            setState(() {
                              above250 = !above250;
                            });
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets.only(bottom: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      above250
                                          ? Icons.check_box
                                          : Icons
                                          .check_box_outline_blank_outlined,
                                      size: 22,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "More than 250 persons",
                                      style: TextStyle(
                                          fontWeight: above250
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "9",
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),


              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              )
            ],
          ),
        ),
      ),
      Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: const Color(0xffffffff),
            height: MediaQuery.of(context).size.height * 0.1,
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: ()
              {
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                padding: const EdgeInsets.only(bottom: 0, top: 0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color(0xff09426d),
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  "View results",
                  style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          )),
      Positioned(
        top: 5,
        left: 20,
        right: 20,
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            setState(() {
              _top += details.delta.dy;
            });
          },
          onVerticalDragCancel: () => Navigator.pop(context),
          child: Transform.translate(
            offset: Offset(0, _top),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 5,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    ]);
  }
}
