import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'FilterAccordian.dart';

class SortandFilter extends StatefulWidget {
  const SortandFilter({Key? key}) : super(key: key);

  @override
  State<SortandFilter> createState() => _SortandFilterState();
}

class _SortandFilterState extends State<SortandFilter> {
  bool BestSeller = false;
  bool BestMatch = false;
  bool LowToHigh = false;
  bool HighToLow = false;

  bool Stars4 = false;
  bool Stars3 = false;
  bool Stars2 = false;
  bool Star1 = false;

  bool under10 = false;
  bool under50 = false;
  bool under100 = false;
  bool under1000 = false;

  bool reduced = false;
  bool clearance = false;

  bool online = false;
  bool instore = false;
  bool scheduledorder = false;

  double _top = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        height: MediaQuery.of(context).size.height * 0.65,
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
                  GestureDetector(
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

              //Sort Accordion
              FilterAccordion(
                  title: "Sort",
                  content: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        //Best Seller Row
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              BestSeller = !BestSeller;
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
                                  BestSeller
                                      ? Icons.check_circle
                                      : Icons.circle_outlined,
                                  size: 22,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Best Seller",
                                  style: TextStyle(
                                      fontWeight: BestSeller
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: Colors.black.withOpacity(0.8)),
                                )
                              ],
                            ),
                          ),
                        ),

                        //Best Match Row
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              BestMatch = !BestMatch;
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
                                  BestMatch
                                      ? Icons.check_circle
                                      : Icons.circle_outlined,
                                  size: 22,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Best Match",
                                  style: TextStyle(
                                      fontWeight: BestMatch
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: Colors.black.withOpacity(0.8)),
                                )
                              ],
                            ),
                          ),
                        ),

                        //Price: low to high Row
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              LowToHigh = !LowToHigh;
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
                                  LowToHigh
                                      ? Icons.check_circle
                                      : Icons.circle_outlined,
                                  size: 22,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Price: low to high",
                                  style: TextStyle(
                                      fontWeight: LowToHigh
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: Colors.black.withOpacity(0.8)),
                                )
                              ],
                            ),
                          ),
                        ),

                        //Price: high to low Row
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              HighToLow = !HighToLow;
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
                                  HighToLow
                                      ? Icons.check_circle
                                      : Icons.circle_outlined,
                                  size: 22,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Price: high to low",
                                  style: TextStyle(
                                      fontWeight: HighToLow
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
                  title: "Category",
                  content: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        //All departments
                        GestureDetector(
                          onTap: () {
                            setState(() {});
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets.only(bottom: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 22,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "All departments",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.8)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),

              //Customer Rating Accordion
              FilterAccordion(
                  title: "Customer Rating",
                  content: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        //4 Stars Row
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Stars4 = !Stars4;
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
                                      Stars4
                                          ? Icons.check_circle
                                          : Icons.circle_outlined,
                                      size: 22,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    AbsorbPointer(
                                      absorbing: true,
                                      child: RatingBar(
                                        initialRating: double.parse("4.5"),
                                        allowHalfRating: true,
                                        itemSize: 16,
                                        ratingWidget: RatingWidget(
                                            full: const Icon(
                                              Icons.star,
                                              color: Color(0xffffc107),
                                            ),
                                            half: const Icon(
                                              Icons.star_half,
                                              color: Color(0xffffc107),
                                            ),
                                            empty: const Icon(
                                              Icons.star_border,
                                              color: Color(0xffffc107),
                                            )),
                                        onRatingUpdate: (ratings) =>
                                            print(ratings),
                                      ),
                                    ),
                                    Text(
                                      " & up",
                                      style: TextStyle(
                                          fontWeight: Stars4
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "1079",
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        ),

                        //3 Stars Row
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Stars3 = !Stars3;
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
                                      Stars3
                                          ? Icons.check_circle
                                          : Icons.circle_outlined,
                                      size: 22,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    AbsorbPointer(
                                      absorbing: true,
                                      child: RatingBar(
                                        initialRating: double.parse("3.5"),
                                        allowHalfRating: true,
                                        itemSize: 16,
                                        ratingWidget: RatingWidget(
                                            full: const Icon(
                                              Icons.star,
                                              color: Color(0xffffc107),
                                            ),
                                            half: const Icon(
                                              Icons.star_half,
                                              color: Color(0xffffc107),
                                            ),
                                            empty: const Icon(
                                              Icons.star_border,
                                              color: Color(0xffffc107),
                                            )),
                                        onRatingUpdate: (ratings) =>
                                            print(ratings),
                                      ),
                                    ),
                                    Text(
                                      " & up",
                                      style: TextStyle(
                                          fontWeight: Stars3
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "79",
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        ),

                        //2 Stars Row
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Stars2 = !Stars2;
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
                                      Stars2
                                          ? Icons.check_circle
                                          : Icons.circle_outlined,
                                      size: 22,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    AbsorbPointer(
                                      absorbing: true,
                                      child: RatingBar(
                                        initialRating: double.parse("2.5"),
                                        allowHalfRating: true,
                                        itemSize: 16,
                                        ratingWidget: RatingWidget(
                                            full: const Icon(
                                              Icons.star,
                                              color: Color(0xffffc107),
                                            ),
                                            half: const Icon(
                                              Icons.star_half,
                                              color: Color(0xffffc107),
                                            ),
                                            empty: const Icon(
                                              Icons.star_border,
                                              color: Color(0xffffc107),
                                            )),
                                        onRatingUpdate: (ratings) =>
                                            print(ratings),
                                      ),
                                    ),
                                    Text(
                                      " & up",
                                      style: TextStyle(
                                          fontWeight: Stars2
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "111",
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        ),

                        //1 Stars Row
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Star1 = !Star1;
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
                                      Star1
                                          ? Icons.check_circle
                                          : Icons.circle_outlined,
                                      size: 22,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    AbsorbPointer(
                                      absorbing: true,
                                      child: RatingBar(
                                        initialRating: double.parse("1.5"),
                                        allowHalfRating: true,
                                        itemSize: 16,
                                        ratingWidget: RatingWidget(
                                            full: const Icon(
                                              Icons.star,
                                              color: Color(0xffffc107),
                                            ),
                                            half: const Icon(
                                              Icons.star_half,
                                              color: Color(0xffffc107),
                                            ),
                                            empty: const Icon(
                                              Icons.star_border,
                                              color: Color(0xffffc107),
                                            )),
                                        onRatingUpdate: (ratings) =>
                                            print(ratings),
                                      ),
                                    ),
                                    Text(
                                      " & up",
                                      style: TextStyle(
                                          fontWeight: Star1
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "29",
                                  style: TextStyle(fontSize: 13),
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
                        //Under £10
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              under10 = !under10;
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
                                      under10
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
                                      "Under £10",
                                      style: TextStyle(
                                          fontWeight: under10
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "185",
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        ),

                        //£10 - £50
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              under50 = !under50;
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
                                      under50
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
                                      "£10 - £50",
                                      style: TextStyle(
                                          fontWeight: under50
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "1093",
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        ),

                        //£50 - £100
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              under100 = !under100;
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
                                      under100
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
                                      "£50 - £100",
                                      style: TextStyle(
                                          fontWeight: under100
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "1621",
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        ),

                        //£100 - £1000
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              under1000 = !under1000;
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
                                      under1000
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
                                      "£100 - £1000",
                                      style: TextStyle(
                                          fontWeight: under1000
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "414",
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),

              //Online Savings Accordion
              FilterAccordion(
                  title: "Online Savings",
                  content: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        //Reduced Price
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              reduced = !reduced;
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
                                      reduced
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
                                      "Reduced Price",
                                      style: TextStyle(
                                          fontWeight: reduced
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "185",
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        ),

                        //Clearance
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              clearance = !clearance;
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
                                      clearance
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
                                      "Clearance",
                                      style: TextStyle(
                                          fontWeight: clearance
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "49",
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),

              //Availability Accordion
              FilterAccordion(
                  title: "Availability",
                  content: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        //Online
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              online = !online;
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
                                      online
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
                                      "Online",
                                      style: TextStyle(
                                          fontWeight: online
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "30085",
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        ),

                        //In Store
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              instore = !instore;
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
                                      instore
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
                                      "In Store",
                                      style: TextStyle(
                                          fontWeight: instore
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "297",
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        ),

                        //Scheduled order
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              scheduledorder = !scheduledorder;
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
                                      scheduledorder
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
                                      "Scheduled order",
                                      style: TextStyle(
                                          fontWeight: scheduledorder
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "124",
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),

              //Sold by Accordion
              FilterAccordion(
                  title: "Sold & shipped by",
                  content: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        //Amazon
                        GestureDetector(
                          onTap: () {
                            setState(() {});
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
                                      Icons.check_box,
                                      size: 22,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Amazon",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "50902",
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
                    color: const Color(0xffff1f6f),
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
