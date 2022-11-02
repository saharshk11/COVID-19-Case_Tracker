import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid_19_case_displayer/pages/location.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _textEditingController = TextEditingController();
  Location locationPage;
  var stream;
  var strSub;
  Text textPage;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {});
    textPage = Text('Search for a County', style: TextStyle(color: Colors.grey[600]),);
  }

  @override
  void dispose(){
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children: <Widget>[
                  Divider(color: Colors.grey[200],),
                  Expanded(
                    flex: 5,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextField(
                        autofocus: true,
                        autocorrect: true,
                        textCapitalization: TextCapitalization.words,
                        controller: _textEditingController,
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          focusColor: Colors.blue,
                          border: OutlineInputBorder(),
                          labelText: 'Enter a County',
                        ),
                        onSubmitted: (text) {
                          setState(() {
                            locationPage = Location(false, county: text);
                            stream = locationPage.stream;
                            strSub = stream.listen((data) {setState(() {
                              if(data[0] == null || data[1] == null){
                                locationPage = null;
                                textPage = Text('${_textEditingController.text} County wasn\'t found', style: TextStyle(color: Colors.red),);
                              }
                            });});
                          });
                        },
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey[200],),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              child: locationPage == null ? Center(child: textPage,) : locationPage.getDisplay(),
            ),
          ),
        ],
      ),
    );
  }
}

