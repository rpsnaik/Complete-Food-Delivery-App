import 'package:flutter/material.dart';
import './main.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceOrder{
  final String url;
  PlaceOrder(this.url);
}
class PlacingOrder extends StatefulWidget {
  final PlaceOrder placeorder;
  PlacingOrder(this.placeorder);
  @override
  _PlacingOrderState createState() => _PlacingOrderState();
}

class _PlacingOrderState extends State<PlacingOrder> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        elevation: 10.0,
        title: Text("Order info"),
      ),
      url: widget.placeorder.url,
    );
  }
}


class cnfrmOrd{
  final String title;
  final String description;
  final String imgurl;
  final int price;
  final String uid;
  final int count;
  final String p1;
  final String p2;
  final String p3;
  final String url;
  cnfrmOrd(this.title, this.description, this.price, this.uid, this.imgurl, this.count, this.p1, this.p2 , this.p3, this.url);
}

class confirmOrder extends StatefulWidget {
  final cnfrmOrd cnfrmord;
  confirmOrder(this.cnfrmord);
  @override
  _confirmOrderState createState() => _confirmOrderState();
}

class _confirmOrderState extends State<confirmOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Confirmation'),
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.all(0.0),
          child: RaisedButton(
            padding: EdgeInsets.all(12.0),
            color: Colors.blue,
            child: new Text("Place my Order "+((widget.cnfrmord.price)*(widget.cnfrmord.count) + ((widget.cnfrmord.count)*10)).toString()+" INR", style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
            ),),
            onPressed: (){
              showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    title: Text("Agree with terms and place your Order"),
                    content: ListView(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10.0),
                          color: Colors.tealAccent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Important info"),
                              Text("1.Price of the food item may vary from food court to food court, sub-catogeory etc"),
                              Text("2.Final price is not the exact price of the product"),
                              Text("3.You can get to know the final price of the food item once you place the order and got the call from our Agent"),
                              Text("4.Each product charges an extra of 5 INR as Service charge and 5 INR for Delivery charge."),
                              Text("5.Valid cashback offer is applied automatically, if the order meets the offer terms"),
                            ],
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("Close"),
                        onPressed: (){
                          Navigator.of(context).pop(context);
                        },
                      ),
                      RaisedButton(
                        color: Colors.red,
                        onPressed: () async {
                             var finalurl = widget.cnfrmord.url +"&priceadd="+((widget.cnfrmord.count)*10).toString();
                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => (PlacingOrder((PlaceOrder(finalurl))))));
                        },
                        child: Text("Agree, and Place Order", style: TextStyle(
                          color: Colors.white,
                        ),),
                      )
                    ],
                  );
                }
              );
              /*
              var finalurl = widget.cnfrmord.url +"&priceadd="+((widget.cnfrmord.count)*10).toString();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => (PlacingOrder((PlaceOrder(finalurl))))));
              */
            },
          ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
        padding: EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(18.0),
                height: 150.0,
                 child: Row(
                   children: <Widget>[
                     Image.asset(widget.cnfrmord.imgurl, fit: BoxFit.cover,width: 150.0,),
                     Container(
                       padding: EdgeInsets.all(10.0),
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Text(widget.cnfrmord.title, style: TextStyle(
                           fontSize: 25.0,
                         ),),
                         Text("Quantity : "+widget.cnfrmord.count.toString()),
                         Text(((widget.cnfrmord.price)*(widget.cnfrmord.count)).toString()+" INR", style: TextStyle(
                           fontSize: 20.0,
                         ),),
                        
                       ],
                     ),
                     )
                   ],
                 ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Detailed info :", style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  )),
                  SizedBox(height: 10.0,),
                  Text("Item name - - - - - - - - " + widget.cnfrmord.title, style: TextStyle(fontSize: 15.0),),
                  Text("Cost of each  - - - - - - " + widget.cnfrmord.price.toString()+" INR", style: TextStyle(fontSize: 15.0),),
                  Text("No.of Items - - - - - - - " + widget.cnfrmord.count.toString()+" item/items", style: TextStyle(fontSize: 15.0),),
                  Text("Complete Price - - - - - " + ((widget.cnfrmord.count)*(widget.cnfrmord.price)).toString()+" INR", style: TextStyle(fontSize: 15.0),),
                  Text("Delivery Address - - - - Default address from Profile.", style: TextStyle(
                    fontSize: 15.0,
                  ),),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Food Court Preferences : ", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),),
                  SizedBox(height: 10.0,),
                  Text("Preference 01 : "+widget.cnfrmord.p1, style: TextStyle(fontSize: 15.0),),
                  Text("Preference 02 : "+widget.cnfrmord.p2, style: TextStyle(fontSize: 15.0),),
                  Text("Preference 03 : "+widget.cnfrmord.p3, style: TextStyle(fontSize: 15.0),),
                  SizedBox(height: 10.0,),
                  Text("Addation Charges : ", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),),
                  SizedBox(height: 10.0,),
                  Text("Service Charges - - -  "+((widget.cnfrmord.count)*5).toString()+" INR", style: TextStyle(
                    fontSize: 15.0,
                  ),),
                  Text("Delivery Charges - - - "+((widget.cnfrmord.count)*5).toString()+" INR", style: TextStyle(
                    fontSize: 15.0,
                  ),),
                  SizedBox(height: 10.0,),
                  Text("- - - - - - - - - - - - - - - - - - - - - - - - - - "),
                  Text("Complete Payable Amount : "+((widget.cnfrmord.price)*(widget.cnfrmord.count) + ((widget.cnfrmord.count)*10)).toString()+" INR", style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),),
                  Text("- - - - - - - - - - - - - - - - - - - - - - - - - - "),
                  Text("Payment Mode : Pay after Delivery(Default)"),
                  Text("*Online Payments are going to impliment sooner."),
                ],
              ),
            )
          ],
        ),
      )
        ],
      )
    );
  }
}







class Todo {
  final String title;
  final String description;
  final String imgurl;
  final int price;
  final String uid;
  Todo(this.title, this.description, this.imgurl, this.price, this.uid);
}

class SecondScreen extends StatefulWidget{
  final Todo todo;

  SecondScreen(this.todo);

  @override
  SecondScreenState createState() {
    return new SecondScreenState();
  }
}

class SecondScreenState extends State<SecondScreen> {
  final key = new GlobalKey<ScaffoldState>();


  int _valueCount = 1; //Complete count of the products
  int cmpPrice; //Complete price of the products

  String _stall1;
  bool _stall1key = false;

  String _stall2;
  bool _stall2key = false;

  String _stall3;
  bool _stall3key = false;

  bool loaderfun = false;

  Widget _priceDet(){
    if(cmpPrice == null){
      setState(() {
        cmpPrice = widget.todo.price;
      });
    }
    return Text(cmpPrice.toString() + " INR", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),);
  }

  void placeOrder() async {
    if( (_stall1key == false) || (_stall2key == false) || (_stall3key == false) ){
      key.currentState.showSnackBar(new SnackBar(
                content: new Text("Please Select all 3 stalls"),
              ));
      print("Slect stall preference...");
    }
    else{
      setState(() {
        loaderfun = true;
      });
      var urlTest = "https://recipers-2019.firebaseio.com/.json";
      List _trail = await getJson(urlTest);
      print(_trail);
      var response = await http.get(urlTest);
      print(response.statusCode);
      if(response.statusCode == 200){
         int position = 0;
         print(widget.todo.uid);
         var findingSpace = _trail[1]['orders'][widget.todo.uid];
         print("Yes : "+findingSpace.toString());
         position = findingSpace.length;
         print(position);
         var userpath = _trail[0]['users'][widget.todo.uid];
         print(userpath['block']);
         var finalUrlforDeliveryDetUp = "https://recipers-2019.firebaseapp.com/adding_orders.html?&uid="+widget.todo.uid+"&cus_name="+userpath['name']+"&item_name="+widget.todo.title+"&item_count="+_valueCount.toString()+"&price="+(cmpPrice+(_valueCount)*10).toString()+"&stall1="+_stall1+"&stall2="+_stall2+"&stall3="+_stall3+"&email="+userpath['email']+"&mobile="+userpath['mobile']+"&hostel="+userpath['hostel']+"&block="+userpath['block']+"&room="+userpath['room']+"&position="+position.toString()+"&submitted=true";
         print(finalUrlforDeliveryDetUp);  
         setState(() {
           loaderfun = false;
         });
         Navigator.push(context, MaterialPageRoute(builder: (context) => confirmOrder(cnfrmOrd(widget.todo.title, widget.todo.description, widget.todo.price, widget.todo.uid, widget.todo.imgurl, _valueCount, _stall1, _stall2, _stall3, finalUrlforDeliveryDetUp))));
         //Navigator.push(context, 
         //   MaterialPageRoute(builder: (context) => PlacingOrder(PlaceOrder(finalUrlforDeliveryDetUp))),
         //);      
      }
      else{
        print("Unable to connect to network");
      }
    }
  }
 

  @override
  Widget build(BuildContext context) {
    Widget selpre1(){
      if(_stall1key == false){
              return Text("Select stalls");
      }
      else{
        return Text("$_stall1");
      }
    }

    Widget selpre2(){
      if(_stall2key == false){
              return Text("Select stalls");
      }
      else{
        return Text("$_stall2");
      }
    }

    Widget selpre3(){
      if(_stall3key == false){
              return Text("Select stalls");
      }
      else{
        return Text("$_stall3");
      }
    }

    Widget itsaneed(){
      if(loaderfun == false){
        return Text("Place Order", style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ));
      }
      else{
        return Container(
          padding: EdgeInsets.all(10.0),
          child: CircularProgressIndicator(),
        );
      }
    }
    return Scaffold(
      key: key,
      bottomNavigationBar: Padding(
          padding: EdgeInsets.all(0.0),
          child: RaisedButton(
            padding: EdgeInsets.all(12.0),
            color: Colors.redAccent,
            child: itsaneed(),
            onPressed: placeOrder,
          ),
      ),
      body: SafeArea(
          child:CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(widget.todo.imgurl, fit: BoxFit.cover,),
                  title: Text(widget.todo.title),
                ),
              ),
              SliverFixedExtentList(
                itemExtent: 1000.0,
                delegate: SliverChildListDelegate(
                  [
                Container(
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Center(
                  child:Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Card(
                              elevation: 10.0,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              _priceDet(),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 6.0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Icon(Icons.info, color: Colors.black45,size: 10.0,),
                                              Text(" Select the quantity to get the Price", style: TextStyle(
                                                color: Colors.black45,
                                                fontSize: 10.0,
                                              ),),
                                            ],
                                          ),
                                          SizedBox(height: 2.0,),
                                          Text(widget.todo.title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(widget.todo.description, style: TextStyle(fontSize: 15.0, color: Colors.black45),),

                                          Row(
                                            children: <Widget>[
                                              Text("Quantity : ", style: TextStyle(fontSize: 18.0),),
                                              Text("$_valueCount", style: TextStyle(),),
                                              DropdownButton<int>(
                                                items: <int>[1, 2, 3, 4, 5, 6, 7].map((int value) {
                                                  return new DropdownMenuItem<int>(
                                                    value: value,
                                                    child: Text(value.toString()),
                                                  );
                                                }).toList(),
                                                elevation: 1,
                                                onChanged: (int value) {
                                                  setState(() {
                                                    _valueCount = value;
                                                    cmpPrice = _valueCount*(widget.todo.price);
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 4.0,
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                             children: <Widget>[
                                                
                                                Text("Stall Preference : ", style: TextStyle(
                                                  fontSize: 17.0,
                                                ),),
                                                Padding(padding: EdgeInsets.all(5.0),),
                                                Row(
                                                  children: <Widget>[
                                                    Icon(Icons.info, size: 10.0,),
                                                    Text(" Helps to choose best food courts", style: TextStyle(fontSize: 10.0),),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Text("Stall-1 have 75% of chances", style: TextStyle(fontSize: 12.0),),
                                                Text("Stall-2 have 20%% of chances", style: TextStyle(fontSize: 12.0),),
                                                Text("Stall-3 have 5% of chances", style: TextStyle(fontSize: 12.0),),
                                             ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                          Text("Stall-1 : ", style: TextStyle(fontSize: 18.0),),
                                          DropdownButton<String>(
                                                hint: selpre1(),
                                                items: <String>[
                                                  "Foodie",
                                                  "Chennai Express",
                                                  "SK",
                                                  "AB Juice Bar",
                                                  "Kikeez",
                                                  "Vascos",
                                                  "Fortune",
                                                  "Food hut",
                                                  "Classic",
                                                  "Parantha Corner",
                                                  "Telugu vantillu",
                                                  "Hangouts",
                                                  "Parantha Corner",
                                                  "South to Mouth",
                                                  "Fortune",
                                                  "Second Home",
                                                  "South indian cusine",
                                                  "Chennai Express",
                                                  "Andhra Food house",
                                                  "Campus fusion",
                                                  "Punjabi Junction",
                                                  "Based on region - BH-1 Stalls",
                                                  "Based on region - BH-5 Stalls",
                                                  "Based on region - Near 48 block",
                                                  "Bawarchi",
                                                  "Food hut",
                                                  "Gurudev",
                                                  "GCF",
                                                  "Snakers",
                                                  "Food Hunt"


                                                ].map((String stall1) {
                                                  return new DropdownMenuItem<String>(
                                                    value: stall1,
                                                    child: Text(stall1.toString(), style: TextStyle(
                                                      color: Colors.black
                                                    ),),
                                                  );
                                                }).toList(),
                                                elevation: 1,
                                                onChanged: (String stall1) {
                                                  setState(() {
                                                    _stall1 = stall1;
                                                    _stall1key = true;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                          Text("Stall-2 : ", style: TextStyle(fontSize: 18.0),),
                                          DropdownButton<String>(
                                                hint: selpre2(),
                                                items: <String>[
                                                  "Foodie",
                                                  "Chennai Express",
                                                  "SK",
                                                  "AB Juice Bar",
                                                  "Kikeez",
                                                  "Vascos",
                                                  "Fortune",
                                                  "Food hut",
                                                  "Classic",
                                                  "Parantha Corner",
                                                  "Telugu vantillu",
                                                  "Hangouts",
                                                  "Parantha Corner",
                                                  "South to Mouth",
                                                  "Fortune",
                                                  "Second Home",
                                                  "South indian cusine",
                                                  "Chennai Express",
                                                  "Andhra Food house",
                                                  "Campus fusion",
                                                  "Punjabi Junction",
                                                  "Based on region - BH-1 Stalls",
                                                  "Based on region - BH-5 Stalls",
                                                  "Based on region - Near 48 block",
                                                  "Bawarchi",
                                                  "Food hut",
                                                  "Gurudev",
                                                  "GCF",
                                                  "Snakers",
                                                  "Food Hunt"
                                                ].map((String stall2) {
                                                  return new DropdownMenuItem<String>(
                                                    value: stall2,
                                                    child: Text(stall2.toString(), style: TextStyle(
                                                      color: Colors.black
                                                    ),),
                                                  );
                                                }).toList(),
                                                elevation: 1,
                                                onChanged: (String stall2) {
                                                  setState(() {
                                                    _stall2 = stall2;
                                                    _stall2key = true;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                          Text("Stall-3 : ", style: TextStyle(fontSize: 18.0),),
                                          DropdownButton<String>(
                                                hint: selpre3(),
                                                items: <String>[
                                                  "Foodie",
                                                  "Chennai Express",
                                                  "SK",
                                                  "AB Juice Bar",
                                                  "Kikeez",
                                                  "Vascos",
                                                  "Fortune",
                                                  "Food hut",
                                                  "Classic",
                                                  "Parantha Corner",
                                                  "Telugu vantillu",
                                                  "Hangouts",
                                                  "Parantha Corner",
                                                  "South to Mouth",
                                                  "Fortune",
                                                  "Second Home",
                                                  "South indian cusine",
                                                  "Chennai Express",
                                                  "Andhra Food house",
                                                  "Campus fusion",
                                                  "Punjabi Junction",
                                                  "Based on region - BH-1 Stalls",
                                                  "Based on region - BH-5 Stalls",
                                                  "Based on region - Near 48 block",
                                                  "Bawarchi",
                                                  "Food hut",
                                                  "Gurudev",
                                                  "GCF",
                                                  "Snakers",
                                                  "Food Hunt"
                                                ].map((String stall3) {
                                                  return new DropdownMenuItem<String>(
                                                    value: stall3,
                                                    child: Text(stall3.toString(), style: TextStyle(
                                                      color: Colors.black
                                                    ),),
                                                  );
                                                }).toList(),
                                                elevation: 1,
                                                onChanged: (String stall3) {
                                                  setState(() {
                                                    _stall3 = stall3;
                                                    _stall3key = true;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          Container(
                                              padding: EdgeInsets.all(10.0),
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                     Text("Addational Info :", style: TextStyle(
                                                       fontSize: 20.0,
                                                     ),),
                                                     SizedBox(height: 7.0),
                                                     Text("Factors that effect the Price of food" , style: TextStyle(
                                                       fontSize: 14.0,
                                                     ),),
                                                     Text("- Based on the food courts offical price"),
                                                     Text("- Based on the Quantity"),
                                                     Text("- Based on the Sub Type of the food item"),
                                                     Text("- Based on Cashback offers"),

                                                     SizedBox(
                                                       height: 10.0,
                                                     ),
                                                      Text("Cashback offers : ", style: TextStyle(
                                                            fontSize: 18.0,
                                                            fontWeight: FontWeight.w600,
                                                          ), ),
                                                          SizedBox(height: 10.0,),
                                                          InkWell(
                                                            onTap: () async {
                                                              const url = 'http://rpsnaik.cf/recipers/terms-and-conditions.html';
                                                              if(await canLaunch(url)){
                                                                await launch(url);
                                                              }
                                                              else{
                                                                throw 'Could not launch $url';
                                                              }
                                                            },
                                                            child: Container(
                                                              child: Column(
                                                                children: <Widget>[
                                                                  Card(
                                                                  elevation: 10.0,
                                                                  color: Colors.pink,
                                                                  child: Container(
                                                                    padding: EdgeInsets.all(20.0),
                                                                    child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: <Widget>[
                                                                    Icon(Icons.offline_bolt, color: Colors.white,),
                                                                    SizedBox(
                                                                      width: 20.0,
                                                                    ),
                                                                    Column(
                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: <Widget>[
                                                                        Text("10% Cashback", style: TextStyle(color: Colors.white, fontSize: 18.0),),
                                                                        Text("Shop for 200 INR to get 10% off", style: TextStyle(color: Colors.white, fontSize: 12.0),),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            ),

                                                            Card(
                                                              elevation: 10.0,
                                                              color: Colors.green,
                                                              child: Container(
                                                                padding: EdgeInsets.all(20.0),
                                                                child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                Icon(Icons.offline_bolt, color: Colors.white,),
                                                                SizedBox(
                                                                  width: 20.0,
                                                                ),
                                                                Column(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: <Widget>[
                                                                    Text("15% Cashback", style: TextStyle(color: Colors.white, fontSize: 18.0),),
                                                                    Text("Shop for 300 INR to get 15% off", style: TextStyle(color: Colors.white, fontSize: 12.0),),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                              )
                                                            ),
                                                            Card(
                                                              elevation: 10.0,
                                                              color: Colors.indigo,
                                                              child: Container(
                                                                padding: EdgeInsets.all(20.0),
                                                                child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                Icon(Icons.offline_bolt, color: Colors.white,),
                                                                SizedBox(
                                                                  width: 20.0,
                                                                ),
                                                                Column(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: <Widget>[
                                                                    Text("20% Cashback", style: TextStyle(color: Colors.white, fontSize: 18.0),),
                                                                    Text("Shop for 400 INR to get 20% off", style: TextStyle(color: Colors.white, fontSize: 12.0),),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                              )
                                                            ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                     
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 4.0),
                                            
                                            
                                         

                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                          ),
                          
                        ],
                      )
                    ),
                     ),
                     
                    ],
                  ),
                ),
                  ]
                ),
              )
            ],
          )
      )
    );
  }
}









class Todo12 {
  final String uid;
  Todo12(this.uid);
}


class MainFetchData extends StatefulWidget {
  final Todo12 todo;
  MainFetchData(this.todo);
  @override

  _MainFetchDataState createState() => _MainFetchDataState();

}


class _MainFetchDataState extends State<MainFetchData>{
  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop(){
      Navigator.of(context).pop(true);
      Future.value(true);
      print("Success");
    }
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
          title: Text("My Orders"),
        ),

          body:WebviewScaffold(
            url: "https://recipers-2019.firebaseapp.com/my_orders.html?uid="+widget.todo.uid,
          ),
         ), 
        );

    }

}


class Todo123 {
  final String uid;
  Todo123(this.uid);
}

class EditDet extends StatefulWidget {
  final Todo123 todo;
  EditDet(this.todo);
  @override
  _EditDetState createState() => _EditDetState();
}

class _EditDetState extends State<EditDet> {
  void getDet()async{
    List _data = await getJson("https://recipers-2019.firebaseio.com/.json");
    print(_data[0]['users'][widget.todo.uid]);
  }
  @override
  void initState() {
    getDet();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cash back offers"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Image.asset('./images/cashback.png', height: 150.0,),
                Text("Offers Period", style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                ),),
                SizedBox(
                  height: 20.0,
                ),
               InkWell(
                 onTap: () async {
                                                              const url = 'http://rpsnaik.cf/recipers/terms-and-conditions.html';
                                                              if(await canLaunch(url)){
                                                                await launch(url);
                                                              }
                                                              else{
                                                                throw 'Could not launch $url';
                                                              }
                                                            },
                 child: Container(
                    child: Column(
                      children: <Widget>[
                        Card(
                          elevation: 10.0,
                          color: Colors.indigo,
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.offline_bolt, color: Colors.white,),
                            SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("20% Cashback", style: TextStyle(color: Colors.white, fontSize: 18.0),),
                                Text("Shop for 400 INR to get 20% off", style: TextStyle(color: Colors.white, fontSize: 12.0),),
                              ],
                            ),
                          ],
                        ),
                          )
                        ),
                        Card(
                          elevation: 10.0,
                          color: Colors.pink,
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.offline_bolt, color: Colors.white,),
                            SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("10% Cashback", style: TextStyle(color: Colors.white, fontSize: 18.0),),
                                Text("Shop for 200 INR to get 10% off", style: TextStyle(color: Colors.white, fontSize: 12.0),),
                              ],
                            ),
                          ],
                        ),
                          )
                        ),

                        Card(
                          elevation: 10.0,
                          color: Colors.green,
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.offline_bolt, color: Colors.white,),
                            SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("15% Cashback", style: TextStyle(color: Colors.white, fontSize: 18.0),),
                                Text("Shop for 300 INR to get 15% off", style: TextStyle(color: Colors.white, fontSize: 12.0),),
                              ],
                            ),
                          ],
                        ),
                          )
                        ),
                      ],
                    ),
                  ),
               ),







          
                  Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0,),
                        Text("Valid on Payments with : "),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('./images/paytm.png', width: 60.0,),
                            Image.asset('./images/gpay.png', width: 60.0,),  
                            Image.asset('./images/phonepe.jpg', width: 60.0,),     
                          ],
                        )
                      ],
                    ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}








