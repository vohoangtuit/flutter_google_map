import 'package:flutter/material.dart';
import 'package:google_map/views/add_list_marker_custom_icon.dart';
import 'package:google_map/views/add_list_marker_default.dart';
import 'package:google_map/views/custom_icon_marker.dart';
import 'package:google_map/views/map_add_marker_default.dart';
import 'package:google_map/views/map_add_marker_location_onchange.dart';
import 'package:google_map/views/map_custom_info_window.dart';
import 'package:google_map/views/map_show_detail_poup.dart';
import 'package:google_map/views/show_restaurants_to_map.dart';

import 'custom_widget/normal_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Map Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Demo Google Map'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              NormalButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MapAddDefault()));
              },title:'Map Add Default'),
              SizedBox(height: 10,),
              NormalButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MapWithMarkerLocation()));
              },title:'Map Add Marker Location OnChange'),
              SizedBox(height: 10,),

              NormalButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomIconMarker()));
              },title:'Custom Icon Marker'),
              SizedBox(height: 10,),

              NormalButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddListMarkerDefault()));
              },title:'Add List Marker Default'),
              SizedBox(height: 10,),
              NormalButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddListMarkerCustomIcon()));
              },title:'Add List Marker Custom Icon'),
              SizedBox(height: 10,),
              NormalButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ListRestaurantsShowMap()));
              },title:'Show List Restaurant to Map'),
              //
              SizedBox(height: 10,),
              NormalButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MapCustomInfoWindown()));
              },title:'Map Custom InfoWindow'),
              SizedBox(height: 10,),
              NormalButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MapShowDetailPopup()));
              },title:'Map Show detail popup'),
            ],
          ),
        ),
      ),
    );
  }
}
