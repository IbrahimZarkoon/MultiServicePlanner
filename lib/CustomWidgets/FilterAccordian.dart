import 'package:flutter/material.dart';

class FilterAccordion extends StatefulWidget {
  final String title;
  final Widget content;

  const FilterAccordion(
      {Key? key,
        required this.title,
        required this.content,})
      : super(key: key);

  @override
  _FilterAccordionState createState() => _FilterAccordionState();
}



class _FilterAccordionState extends State<FilterAccordion> {
  bool _showContent = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.title == "PRODUCT REVIEWS")
    {
      _showContent = true;

    }
  }
  @override
  Widget build(BuildContext context) {



    return GestureDetector(
      onTap: () {
        setState(() {
          _showContent = !_showContent;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 0, left: 10, right: 10),
        padding: const EdgeInsets.only(top: 0, bottom: 0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: _showContent?const Border() : Border(bottom: BorderSide(color: Colors.black.withOpacity(0.1),width: 0.75))
          // boxShadow: [
          //   BoxShadow(
          //       offset: const Offset(0, 0),
          //
          //       blurRadius: 1.5,
          //       color: Colors.black.withOpacity(0.2))
          // ],
        ),
        child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  color: const Color(0xffffffff),

                ),
                child: ListTile(

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  contentPadding: const EdgeInsets.all(0),

                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 15,left: 0,right: 15),
                    child: Text(widget.title,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8),fontSize:16),),
                  ),

                  trailing: Padding(
                    padding: const EdgeInsets.only(bottom: 15,left: 15,right: 0),
                    child: _showContent? Icon(Icons.keyboard_arrow_up,color: Colors.black.withOpacity(0.8)) : Icon(Icons.keyboard_arrow_down,color: Colors.black.withOpacity(0.8)),
                  ),

                  //contentPadding: const EdgeInsets.all(10),

                  style: ListTileStyle.drawer,

                ),
              ),

              _showContent
                  ?
              AnimatedContainer(
                duration: const Duration(milliseconds: 5000),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.only(top: 0),
                decoration: BoxDecoration(
                  border:  Border(bottom: BorderSide(color: Colors.black.withOpacity(0.1),width: 0.75)),
                  color: Colors.white,

                ),
                // height: _showContent? MediaQuery.of(context).size.height*0.8 : 100,
                padding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                child: widget.content,
              )
                  :
              Container()
            ]),
      ),
    );
  }
}