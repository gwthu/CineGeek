import 'package:cinegeek/helper/theme.dart';
import 'package:cinegeek/widgets/customAppBar.dart';
import 'package:flutter/material.dart';

import '../../../widgets/customWidgets.dart';
import '../../feed/feedPage.dart';
import '../../feed/feedPostDetail.dart';
import '../../homePage.dart';
import '../sidebar.dart';

class TopRatedPage extends StatefulWidget {
  const TopRatedPage({Key? key}) : super(key: key);

  @override
  _TopRatedPageState createState() => _TopRatedPageState();
}

class _TopRatedPageState extends State<TopRatedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TwitterColor.mystic,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: customTitleText(
          'Top Rated',
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 30, right: 16, top: 20),
                height: 50,
                width: MediaQuery.of(context).size.width / 3,
                child: Text(
                  "Malayalam",
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 16, right: 16, top: 20),
                height: 50,
                width: MediaQuery.of(context).size.width / 3,
                child: Text(
                  "English",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 30, right: 16, top: 20),
                height: 50,
                width: MediaQuery.of(context).size.width / 3,
                child: Text(
                  "Hindi",
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 16, right: 16, top: 20),
                height: 50,
                width: MediaQuery.of(context).size.width / 3,
                child: Text(
                  "Tamil",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 30, right: 16, top: 20),
                height: 50,
                width: MediaQuery.of(context).size.width / 3,
                child: Text(
                  "Kannada",
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 16, right: 16, top: 20),
                height: 50,
                width: MediaQuery.of(context).size.width / 3,
                child: Text(
                  "Telugu",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 30, right: 16, top: 20),
                height: 50,
                width: MediaQuery.of(context).size.width / 3,
                child: Text(
                  "Spanish",
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 16, right: 16, top: 20),
                height: 50,
                width: MediaQuery.of(context).size.width / 3,
                child: Text(
                  "Korean",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 30, right: 16, top: 20),
                height: 50,
                width: MediaQuery.of(context).size.width / 3,
                child: Text(
                  "Chinese",
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 16, right: 16, top: 20),
                height: 50,
                width: MediaQuery.of(context).size.width / 3,
                child: Text(
                  "Japanese",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 30, right: 16, top: 20),
                height: 50,
                width: MediaQuery.of(context).size.width / 3,
                child: Text(
                  "French",
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 16, right: 16, top: 20),
                height: 50,
                width: MediaQuery.of(context).size.width / 3,
                child: Text(
                  "German",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 30, right: 16, top: 20),
                height: 50,
                width: MediaQuery.of(context).size.width / 3,
                child: Text(
                  "Animation",
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 16, right: 16, top: 20),
                height: 50,
                width: MediaQuery.of(context).size.width / 3,
                child: Text(
                  "Anime",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 30, right: 16, top: 20),
                height: 50,
                width: MediaQuery.of(context).size.width / 3,
                child: Text(
                  "Series",
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 16, right: 16, top: 20),
                height: 50,
                width: MediaQuery.of(context).size.width / 3,
                child: Text(
                  "Retro",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
