import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'OrgSingleChat.dart';

class OrgChats extends StatefulWidget {
  const OrgChats({super.key});

  @override
  State<OrgChats> createState() => _OrgChatsState();
}

class _OrgChatsState extends State<OrgChats> {

  TextEditingController _searchCon = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      // Focus the text field and show the keyboard
      //_focusNode.requestFocus();
      _searchCon.selection = TextSelection.fromPosition(
          TextPosition(offset: _searchCon.text.length));
      //TextInput.showKeyboard();
    });
  }

  @override
  void dispose()
  {
    _searchCon.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      //hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: ()
      {
        _focusNode.unfocus();
      },
      child: Container(
        //height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          primary: false,
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.only(left: 15,top: 10),
                child: Text("Chats",
                style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 30,fontWeight: FontWeight.bold),),
              ),

              Container(
                height: 40,
                //width: MediaQuery.of(context).size.width*0.8,
                margin: const EdgeInsets.only(left: 15,right: 15,bottom: 0,top: 10),
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5,top: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 3,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Container(
                        padding: const EdgeInsets.only(left: 5,right: 0,top: 0,bottom: 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xffffffff)
                        ),
                        child:  Icon(Icons.search,color: Colors.black.withOpacity(0.5), size: 22,)),

                    const SizedBox(width: 10),

                    Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: TextField(
                            controller: _searchCon,
                            //controller: _searchCon,
                            focusNode: _focusNode,
                            //onChanged: (query) => setState(() {}),
                            style: const TextStyle(color: Colors.black, height: 1, fontSize: 14),
                            decoration: const InputDecoration(
                              //prefixIcon: Icon(Icons.search, color: Color(0xFF5D5D67), size: 23),
                                hintText: "Search",
                                hintStyle: TextStyle(color: Color(0xFF8F8F9E), fontSize: 13),
                                border: InputBorder.none),
                          ),
                        )),

                  ],
                ),
              ),

              ListView.builder(
                itemCount: 1,
                  shrinkWrap: true,
                  primary: true,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context,index)
                {
                  return InkWell(
                      onTap: ()
                      {
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => OrgSingleChat()));
                      },
                      child: chatCon(index));
                },


              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget chatCon(int index)
  {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.2),width: 0.5))
      ),
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(
            margin: EdgeInsets.only(right: 15),
            width: 50,height: 50,
            decoration: BoxDecoration(
              color: Color(0xffc7c7c7),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(Icons.person,color: Colors.white,size: 30,),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Ibrahim Khan Zarkoon",
                style: TextStyle(color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.bold,fontSize: 14),),

              Text("seen",
                style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 12),)
            ],
          ),

          const Spacer(),

          Text("${index == 0? "" : "$index"} ${index > 1? "hrs" : index == 0? "mins" : "hr"} ago",
            style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 12),)

        ],
      ),

    );
  }
}
