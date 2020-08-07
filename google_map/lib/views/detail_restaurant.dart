import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_map/custom_widget/base.dart';
import 'package:google_map/model/restaurant.dart';

class DetailResTauRant extends StatefulWidget {
  final Restaurant restaurant;
  DetailResTauRant(this.restaurant);
  @override
  _DetailResTauRantState createState() => _DetailResTauRantState();
}

class _DetailResTauRantState extends State<DetailResTauRant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.restaurant.name),centerTitle: true,),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20,),
            Image.network(widget.restaurant.image),
            SizedBox(height: 10,),
            Text(widget.restaurant.name,style: textTextBlueLarge(),),
            SizedBox(height: 10,),
            RatingBar(
              initialRating: widget.restaurant.rating,
              minRating: 1,
              itemSize: 32,
              direction: Axis.horizontal,
              allowHalfRating: true,
              // tapOnlyMode: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
//                                onRatingUpdate: (rating) {// todo: disable update
//                                  //print(rating);
//                                },
            ),
            Text('info .....................',style: textTextBlueLarge(),),
          ],
        ),
      ),
    );
  }
}
