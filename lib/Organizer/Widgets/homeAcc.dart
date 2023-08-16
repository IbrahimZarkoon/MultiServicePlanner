import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeAcc extends StatefulWidget {
  final String title;
  final Widget content;

  const HomeAcc(
      {Key? key,
        required this.title,
        required this.content,
        })
      : super(key: key);

  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<HomeAcc> {
  bool _showContent = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showContent = !_showContent;
        });
      },
      child: Container(
        //margin: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
        padding: const EdgeInsets.only(left: 15,right: 15),
        decoration: const BoxDecoration(
          //color: Colors.white,
          border: Border(top: BorderSide(color: Colors.white,width: 0.75))
        ),
        child: Column(children: [
          Container(
            //color: Colors.white,
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),

              title: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.title,style: const TextStyle(color: Color(
                      0xffffffff),fontFamily: "Helvetica_Bold",fontSize: 16),),
                ],
              ),

              trailing: Icon(_showContent? Icons.keyboard_arrow_up_sharp :  Icons.keyboard_arrow_down_sharp,color: Colors.white,size: 25,),

              contentPadding: const EdgeInsets.all(0),

              style: ListTileStyle.list,

              // trailing: IconButton(
              //   icon: Container(
              //     padding: EdgeInsets.all(0),
              //     alignment: Alignment.center,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(100),
              //       color: Color(0xff7416a6),
              //     ),
              //     child: Icon(
              //       _showContent
              //           ? Icons.keyboard_arrow_up_outlined
              //           : Icons.keyboard_arrow_down_outlined,
              //       size: 20,
              //       color: Color(0xffffffff),
              //     ),
              //   ),
              //   onPressed: () {
              //     setState(() {
              //       _showContent = !_showContent;
              //     });
              //   },
              // ),
            ),
          ),
          _showContent
              ? AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
              width: MediaQuery.of(context).size.width,
            child: widget.content,
          )
              : Container()
        ]),
      ),
    );
  }
}
