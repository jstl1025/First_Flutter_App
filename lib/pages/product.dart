import 'dart:async';

import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String imgURL;

  ProductPage(this.title, this.imgURL);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: (){
      Navigator.pop(context);
      return Future.value(false);
    },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          children: <Widget>[
            Image.asset(imgURL),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(title),
            ),
            Container(
              child: RaisedButton(
                padding: EdgeInsets.all(10.0),
                color: Theme.of(context).accentColor,
                child: Text('Delete'),
                onPressed: () => Navigator.pop(context, true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
