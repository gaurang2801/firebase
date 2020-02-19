





import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:firebase_database/firebase_database.dart';

import 'Post.dart';


import 'package:marquee/marquee.dart';
void main()=>runApp(MyApp());



class MyApp extends StatefulWidget {










  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Email(String email) async {
    // Android and iOS
    var uri = '$email';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
  Call(String number) async {
    // Android
    var uri = 'tel:$number';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {

      throw 'Could not launch $uri';

    }
  }
  String  current;

  List<Posts> postList=[];
  @override
  void initState(){
    super.initState();
    DatabaseReference postsRef=FirebaseDatabase.instance.reference().child("Team");
    postsRef.once().then((DataSnapshot snap){

      var DATA=snap.value;
      var KEYS=snap.value.keys;
      print(KEYS);
      print(DATA);
      postList.clear();

      for(var individualKey in KEYS){
        Posts posts=new Posts(
          DATA[individualKey]['email'],
          DATA[individualKey]['image'],
          DATA[individualKey]['name'],
          DATA[individualKey]['number'],);
        postList.add(posts);
      }
      setState(() {
        print("LENGTH ${postList.length}");
      });
    });

  }
  Widget Open(String a){
    return Container(child:Stack(
      children: <Widget>[
        Card(child:
       Image.network(a),),
      ],

    ),);
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Hello",
      home:  Scaffold(
        appBar: new AppBar(
          title: new Text("hello world"),
        ),
        body:new Container(
            child:postList.length==0? Center(child:CircularProgressIndicator(),)/*:Column(
              mainAxisAlignment:MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[

    Expanded(child:
new ListView.builder(
  scrollDirection: Axis.horizontal,
  itemCount: postList.length,
shrinkWrap: true,
              itemBuilder: (_,index){
                return PostsUI(postList[index].email,
                  postList[index].image,
                  postList[index].name,
                  postList[index].number,);
              },

            ),*/
             :
    new ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(2.0),
              //scrollDirection: Axis.vertical,
              //shrinkWrap: true,
             // padding: new EdgeInsets.fromLTRB(0, 5, 5, 0),
                itemCount: postList.length,
                itemBuilder: (_,index){
                  return PostsUI(postList[index].email,
                    postList[index].image,
                    postList[index].name,
                    postList[index].number,);
                },
             // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:1,childAspectRatio:(0.7),mainAxisSpacing: 10,
              //crossAxisSpacing: 6,),
            ),
        ),
      ),
      );

  }


  Widget PostsUI(String email,String image,String name,String number,){
    return  Card(
      margin: EdgeInsets.all(5.0),
      color: Colors.orange,
      child:ListTile(
      title:Text(name,style: TextStyle(fontFamily: 'COMIC' ),),
      subtitle: Text(email),

      onTap:()=> Email(email),),
    );/*new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    SizedBox(height: 35,),
    InkWell(child:
    Text(
      name,style: TextStyle(fontFamily: 'COMIC',fontSize: 25.0),),
    onTap: (){print(email);},),
    Text(number),

      ],

    );*/
    /*return new Card(
      elevation: 15.0,
      color:Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
child: Column(
  children: <Widget>[
    new Text(name),
    new Text(number),
  ],
),*/


/*
      child:Column(
        //mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //Padding(padding: EdgeInsets.all(15.0),),
          Expanded(child:InkWell(
              child: Image.network(image,fit: BoxFit.fitWidth,),
            onTap:(){
          //current=image;
          Open(image);
          }
            
          ),),
          SizedBox(height: 5.0,),
          new Text(name,style: TextStyle(fontFamily: 'COMIC'),textAlign: TextAlign.left,),
          Row(children:<Widget> [
            IconButton(icon: Icon(Icons.call,color: Colors.blueAccent,),onPressed:()=>Call(number),),
           Expanded(child: Text(number,style: TextStyle(fontFamily: 'COMIC',),)),
          ],),
          IconButton(icon: Icon(Icons.email,color: Colors.blueAccent,),onPressed:() => Email(email),),
        ],
      ),*/











/*
Card(
      elevation: 10.0,
      margin: EdgeInsets.all(15.0),
      child: Container(
        padding: new EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(name),
            Text(email),
            Text(number),
            Image.network(image,fit: BoxFit.cover,) ,
          ],
        ),
      ),
    );
*/

  }




}

