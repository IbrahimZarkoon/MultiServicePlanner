import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClarifyTab extends StatefulWidget {
  const ClarifyTab({Key? key}) : super(key: key);

  @override
  State<ClarifyTab> createState() => _ClarifyTabState();
}

class _ClarifyTabState extends State<ClarifyTab> {
  bool i1 = false;
  bool i2 = false;
  bool i3 = false;
  bool i4 = false;
  bool i5 = false;
  bool i6 = false;
  bool i7 = false;
  bool i8 = false;
  bool i9 = false;
  bool i10 = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15,bottom: 0),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text("LET'S CLARIFY",
              style: TextStyle(fontFamily: "Helvetica_Bold",color: Colors.black.withOpacity(0.8),fontSize: 24),),

            const SizedBox(height: 15,),

            Text("Select events according to your interests.\Your recommendations\nmore interesting and accurate",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: "",color: Colors.black.withOpacity(0.6),fontSize: 14),),

            const SizedBox(height: 20,),

            Text("Music",
              style: TextStyle(fontFamily: "Helvetica_Bold",color: Colors.black.withOpacity(0.8),fontSize: 22),),

            Container(
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 15,top: 15),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 15, // spacing between the interest containers
                runSpacing: 15, // spacing between lines

                children: <Widget>[

                  interestCon(context, "Dance and Movement",true),

                  interestCon(context, "Painting",i2),

                  interestCon(context, "Line Dancing",true),

                  interestCon(context, "Belly Dance",i4),

                  interestCon(context, "Argentine Tango",i5),

                  interestCon(context, "Painting",i6),

                  interestCon(context, "Dance and Movement",i7),

                  interestCon(context, "Line Dancing",i8),

                  interestCon(context, "Belly Dance",i9),

                  interestCon(context, "Argentine Tango",i10),






                ],
              ),
            ),


            Text("Sport",
              style: TextStyle(fontFamily: "Helvetica_Bold",color: Colors.black.withOpacity(0.8),fontSize: 22),),

            Container(
              margin: const EdgeInsets.only(bottom: 15),

              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 15,top: 15),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 15, // spacing between the interest containers
                runSpacing: 15, // spacing between lines

                children: <Widget>[

                  interestCon(context, "Dance and Movement",true),

                  interestCon(context, "Painting",i2),

                  interestCon(context, "Line Dancing",true),

                  interestCon(context, "Belly Dance",i4),

                  interestCon(context, "Argentine Tango",i5),

                  interestCon(context, "Painting",i6),

                  interestCon(context, "Dance and Movement",i7),

                  interestCon(context, "Line Dancing",i8),

                  interestCon(context, "Belly Dance",i9),

                  interestCon(context, "Argentine Tango",i10),






                ],
              ),
            ),

            Text("Education",
              style: TextStyle(fontFamily: "Helvetica_Bold",color: Colors.black.withOpacity(0.8),fontSize: 22),),

            Container(
              margin: const EdgeInsets.only(bottom: 15),

              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 15,top: 15),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 15, // spacing between the interest containers
                runSpacing: 15, // spacing between lines

                children: <Widget>[

                  interestCon(context, "Dance and Movement",true),

                  interestCon(context, "Painting",i2),

                  interestCon(context, "Line Dancing",true),

                  interestCon(context, "Belly Dance",i4),

                  interestCon(context, "Argentine Tango",i5),

                  interestCon(context, "Painting",i6),

                  interestCon(context, "Dance and Movement",i7),

                  interestCon(context, "Line Dancing",i8),

                  interestCon(context, "Belly Dance",i9),

                  interestCon(context, "Argentine Tango",i10),






                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget interestCon(BuildContext context,String txt,bool T)
  {
    return InkWell(
      onTap: ()
      {

      },
      child: Container(

        //alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: T?  const Color(0xffff1f6f) : Colors.white,
          border: Border.all(color:const Color(0xffff1f6f),width: 0.5)
        ),
        padding: const EdgeInsets.only(top: 8,bottom: 8,left: 15,right: 15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(txt,style: TextStyle(
              color: T? Colors.white : const Color(0xffff1f6f),fontSize: 12
            ),),
          ],
        ),
      )
    );
  }
}
