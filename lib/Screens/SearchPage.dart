import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key, required this.tag}) : super(key: key);

  final String tag;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController _searchCon = TextEditingController();
  final FocusNode _focusNode = FocusNode();



  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      // Focus the text field and show the keyboard
      _focusNode.requestFocus();
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.15),
          child: Container(
            color: const Color(0xff09426d),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                GestureDetector(
                  onTap: ()=> Navigator.pop(context),
                  child: Row(
                    children: const [

                      BackButton(color: Colors.white,),

                      Text("Search",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),)
                    ],
                  ),
                ),

                Container(
                  height: 40,
                  //width: MediaQuery.of(context).size.width*0.8,
                  margin: const EdgeInsets.only(left: 20,right: 20,bottom: 0,top: 10),
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

                      Hero(
                        tag: widget.tag,

                        child: Container(
                            padding: const EdgeInsets.only(left: 5,right: 0,top: 0,bottom: 0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color(0xffffffff)
                            ),
                            child: const Icon(Icons.search,color: Color(0xff09426d), size: 22,)),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 0),
                            child: TextField(
                              controller: _searchCon,
                              //controller: _searchCon,
                              focusNode: _focusNode,
                              //onChanged: (query) => setState(() {}),
                              style: const TextStyle(color: Colors.black, height: 1, fontSize: 14),
                              decoration: const InputDecoration(
                                //prefixIcon: Icon(Icons.search, color: Color(0xFF5D5D67), size: 23),
                                  hintText: "What are you looking for?",
                                  hintStyle: TextStyle(color: Color(0xFF8F8F9E), fontSize: 13),
                                  border: InputBorder.none),
                            ),
                          )),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [

              recentSearchCon("Top Service Provers"),

              recentSearchCon("Venues Nearby"),

              recentSearchCon("Party venues")

            ],
          ),
        ),
      ),
    );
  }

  Widget recentSearchCon(String title)
  {
    return Container(
      padding: const EdgeInsets.only(top: 0,bottom: 10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.1),width: 0.5))
      ),
      margin: const EdgeInsets.only(left: 20,right: 20,bottom: 0,top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [

          Row(
            children: [
              Icon(Icons.youtube_searched_for_outlined,size: 20,color: Colors.black.withOpacity(0.8),),

              const SizedBox(width: 20,),

              Text(title,style: const TextStyle(fontSize: 16),),
            ],
          ),

          Transform.rotate(
              angle: -45 * 0.0174533,
              child: Icon(Icons.arrow_upward,size: 22,color: Colors.black.withOpacity(0.8),))


        ],
      ),
    );
  }
}