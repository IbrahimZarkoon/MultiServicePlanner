import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/CustomWidgets/Headings.dart';

class TicketingDialog extends StatefulWidget {
   TicketingDialog({Key? key,required this.tName, required this.tNumber, required this.tPrice}) : super(key: key);

  String tName;
  String tNumber;
  String tPrice;

  @override
  State<TicketingDialog> createState() => _TicketingDialogState();
}

class _TicketingDialogState extends State<TicketingDialog> {

  TextEditingController tName = TextEditingController();
  TextEditingController tNumber = TextEditingController();
  TextEditingController tPrice = TextEditingController();
  TextEditingController tCurrency = TextEditingController();
  TextEditingController tInfo = TextEditingController();






  @override
  void initState() {
    // TODO: implement initState

    tName.text = widget.tName;
    tNumber.text = widget.tNumber;
    tPrice.text = widget.tPrice;
    tCurrency.text = "USD (\$)";
    tInfo.text = "This Instruction note will be sent to attendees in the ticket confirmation email after they have registered.";

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tInfo.dispose();
    tPrice.dispose();
    tNumber.dispose();
    tName.dispose();
    tCurrency.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      backgroundColor: Colors.black.withOpacity(0.8),

      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3)
        ),
        //padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Column(
                children: [

                  //Heading
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       const Text("New Ticket Details",overflow: TextOverflow.ellipsis,
                          style:
                          TextStyle(color: Color(0xff000000),fontWeight: FontWeight.bold, fontSize: 18)),

                      InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Icon(CupertinoIcons.xmark,size: 20,color: Colors.black.withOpacity(0.5),))
                    ],
                  ),

                  const SizedBox(height: 15),

                  shadowLine(context),

                  const SizedBox(height: 15),

                  //Ticket Name Column
                  fieldCon(context, "Ticket Name", tName),

                  fieldCon(context, "Number of tickets on sale", tNumber),

                  fieldCon(context, "Ticket price", tPrice),

                  //Payment currency
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text("Payment currency:",
                          style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 14,fontFamily: "Helvetica_Bold"),),

                        Container(
                          margin: const EdgeInsets.only(top: 10,bottom: 15,),
                          padding: const EdgeInsets.only(left: 15,right: 15,top: 0,bottom: 0),
                          decoration: BoxDecoration(border: Border.all(color: Colors.black.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Column(
                            children: [


                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  Expanded(
                                      child: TextField(

                                        onTap: ()
                                        {

                                        },
                                        // focusNode: F1,
                                        controller: tCurrency,
                                        cursorColor: const Color(0xff009ed9),
                                        enabled: false,
                                        style: TextStyle(fontSize: 13,color: Colors.black.withOpacity(0.8)),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "",
                                          hintStyle: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 13),

                                        ),
                                      )
                                  ),

                                  // _tap?
                                  // InkWell(
                                  //     onTap: ()
                                  //     {
                                  //
                                  //     },
                                  //     child: Icon(CupertinoIcons.xmark_circle_fill,color: Colors.black.withOpacity(0.5),size: 20,))
                                  //     :
                                  // const SizedBox(),
                                ],
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),

                  fieldCon(context, "Additional Instruction (will be sent in the Ticket Email)", tInfo),
                ],
              ),

              const SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [

                  InkWell(
                    onTap: ()
                    {
                      setState(() {
                        tName.text = "Standard Ticket";
                        tNumber.text = "100";
                        tPrice.text = "Price of Ticket";
                        tCurrency.text = "USD (\$)";
                        tInfo.text = "This Instruction note will be sent to attendees in the ticket confirmation email after they have registered.";
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 5,bottom: 5,left: 15,right: 15),
                      decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(3),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 1.5,
                                offset: const Offset(0,0)
                            )
                          ]
                      ),
                      child: Text("Reset",
                        style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 12,fontWeight: FontWeight.bold),),
                    ),
                  ),

                  const SizedBox(width: 15,),

                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 5,bottom: 5,left: 15,right: 15),
                      decoration: BoxDecoration(
                          color: const Color(0xff009ed9),
                          borderRadius: BorderRadius.circular(3),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 1.5,
                                offset: const Offset(0,0)
                            )
                          ]
                      ),
                      child: const Text("Save",
                        style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),
                    ),
                  ),




                ],
              )



              //
            ],
          ),
        ),
      ),
    );
  }

  Widget fieldCon(BuildContext context,String heading,TextEditingController con)
  {
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text("$heading:",
            style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 14,fontFamily: "Helvetica_Bold"),),

          Container(
            margin: const EdgeInsets.only(top: 10,bottom: 15,),
            padding: const EdgeInsets.only(left: 15,right: 15,top: 0,bottom: 0),
            decoration: BoxDecoration(border: Border.all(color: Colors.black.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(8)
            ),
            child: Column(
              children: [


                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Expanded(
                        child: TextField(
                          onTap: ()
                          {

                          },
                          // focusNode: F1,
                          controller: con,
                          cursorColor: const Color(0xff009ed9),
                          maxLines: 3,
                          minLines: 1,
                          style: TextStyle(fontSize: 13,color: Colors.black.withOpacity(0.8)),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "",
                            hintStyle: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 13),

                          ),
                        )
                    ),

                    // _tap?
                    // InkWell(
                    //     onTap: ()
                    //     {
                    //
                    //     },
                    //     child: Icon(CupertinoIcons.xmark_circle_fill,color: Colors.black.withOpacity(0.5),size: 20,))
                    //     :
                    // const SizedBox(),
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
