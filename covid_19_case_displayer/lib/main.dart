import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid_19_case_displayer/pages/location.dart';
import 'package:covid_19_case_displayer/pages/search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  List<Tab> _tabs;
  TabController _tabController;
  Location locationPage;
  var stream;
  var strSub;

  @override
  void initState() {
    super.initState();
    _tabs = [Tab(icon: Icon(Icons.location_on),), Tab(icon: Icon(Icons.search),),];
    _tabController = TabController(vsync: this, length: _tabs.length);
    locationPage = Location(true);
    stream = locationPage.stream;
    strSub = stream.listen((data) {setState(() {});});
  }

  @override
  void dispose(){
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Texas COVID-19'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.location_on),),
            Tab(icon: Icon(Icons.search),),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          locationPage.getDisplay(),
          Search(),
        ],
      ),
    );
  }
}
