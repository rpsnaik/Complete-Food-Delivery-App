import 'package:flutter/material.dart';
import './second_page.dart';



Widget foodItemsCards(BuildContext context,String title, String subtitle, int price, String time, String url, String uid){
  return InkWell(
     onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondScreen(Todo(title,subtitle, url, price, uid)),
                ),
              );
            },
      child: Card(
        elevation: 10.0,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Material(
                elevation: 0.0,
                borderRadius: BorderRadius.circular(3.0),
                child: Container(
                height: 130.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                     Image.asset("./images/foodtrail.gif", height: 150.0,),
                                Container(
                                  padding: EdgeInsets.fromLTRB(15.0, 5.0, 0.0, 15.0),
                                  child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(padding: EdgeInsets.all(4.0),),
                                    
                                    Text(title, style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 17.0,
                                    color: Colors.black),),
                                    
                                    Text(subtitle,
                                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 11.0, color: Colors.black54),
                                    ),

                                    
                                    
                                    new Container(
                                      margin: new EdgeInsets.symmetric(vertical: 8.0),
                                      height: 2.0,
                                      width: 18.0,
                                      color: new Color(0xff00c6ff)
                                    ),

                                    Row(
                                      children: <Widget>[
                                        Text(price.toString() + " INR",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueGrey
                                         ),
                                        ),
                                       

                                        Container(
                                          padding: EdgeInsets.only(left: 30.0),
                                          child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          
                                          children: <Widget>[
                                            
                                          ],
                                        ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                     Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                             Icon(Icons.info, size: 12.0,color: Colors.grey),
                                             Text(" Service Charges Apply...", style: TextStyle(
                                               fontSize: 12.0,
                                               color: Colors.grey,
                                             ),)
                                          ],
                                        ),
                                        


                                  ],
                                ),
                                )
                  ],
                ),
              ),
             ),

        /*
                            elevation: 10.0,
                            child: Row(
                              children: <Widget>[
                                Image.asset(url, height: 150.0,),
                                Container(
                                  padding: EdgeInsets.fromLTRB(15.0, 5.0, 0.0, 15.0),
                                  child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    
                                    Text(title, style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 17.0,
                                    color: Colors.black54),),
                                    
                                    Text(subtitle,
                                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 11.0, color: Colors.black54),
                                    ),

                                    
                                    
                                    new Container(
                                      margin: new EdgeInsets.symmetric(vertical: 8.0),
                                      height: 2.0,
                                      width: 18.0,
                                      color: new Color(0xff00c6ff)
                                    ),

                                    Row(
                                      children: <Widget>[
                                        Text(price.toString() + " INR",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueGrey
                                         ),
                                        ),
                                       

                                        Container(
                                          padding: EdgeInsets.only(left: 30.0),
                                          child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          
                                          children: <Widget>[
                                            
                                          ],
                                        ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                     Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                             Icon(Icons.info, size: 12.0,),
                                             Text(" Includes Taxes and Delivery charges.", style: TextStyle(
                                               fontSize: 12.0,
                                               color: Colors.grey,
                                             ),)
                                          ],
                                        ),


                                  ],
                                ),
                                )
                              ],
                            ),
                            */
                          ),
                        
                          
  );
}





BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(
      width: 2.0, 
      color: Colors.white54,
    ),
    borderRadius: BorderRadius.all(
        Radius.circular(60.0) //                 <--- border radius here
    ),
  );
}
Widget smallTextItems(String itemName){
  return 
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5.0),
                      child:  Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: myBoxDecoration(),
                      child: InkWell(
                        onTap: null,
                        child: Text(
                        itemName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ),
                    ),
                    );
}







Widget messageData(String data, String hstdata){
  return Container(
    padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
    child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: <Widget>[
          Text(data, 
            style: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
            ),
          ),
          SizedBox(height: 7.0,),
          Text("Location : "+hstdata, 
            style: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.w500,
              fontSize: 13.0,
            ),
          )
       ],
    ),
  );
}





//Various data items and info ... adding food items gona happen here







//Branded Items
class dataT {
  final String uid;
  dataT(this.uid);
}

class BrandedItems extends StatefulWidget {
  dataT datat;
  BrandedItems(this.datat);
  @override
  _BrandedItemsState createState() => _BrandedItemsState();
}

class _BrandedItemsState extends State<BrandedItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        
        title: Text("Branded Food Items", style: TextStyle(
         
        ),),
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(0.0),
            elevation: 0.0,
            child: Container(
              height: 100.0,
              color: Colors.white10,
              child: Center(
                child: Text("Official brandings...",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
                      foodItemsCards(context,"Dominos Pizza - Large", "Lunch & Dinner", 400, "30-45min", "./images/dominospizza.jpg", widget.datat.uid),
                      foodItemsCards(context,"Dominos Pizza - Medium", "Lunch & Dinner", 200, "30-45min", "./images/dominospizza.jpg", widget.datat.uid),
                      foodItemsCards(context,"Dominos Pizza - Regular", "Lunch & Dinner", 120, "30-45min", "./images/dominospizza.jpg", widget.datat.uid),
        ],
      ),
    );
  }
}


//Offers....
class dataT1 {
  final String uid;
  dataT1(this.uid);
}
class Offers extends StatefulWidget {
  dataT1 datat1;
  Offers(this.datat1);
  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text("Offers...", style: TextStyle(
          color: Colors.white,
        ),),
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(0.0),
            elevation: 0.0,
            child: Container(
              height: 100.0,
              color: Colors.white10,
              child: Center(
                child: Text("Todays Deals",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          foodItemsCards(context,"Thali", "Lunch & Dinner", 50, "30-45min", "./images/thali.jpg", widget.datat1.uid),
          foodItemsCards(context,"South Indian Dosa", "Break Fast & Dinner", 40, "30-45min", "./images/dosa.jpg", widget.datat1.uid),
          foodItemsCards(context,"Rice Bowl", "Fast Lunch & Dinner", 60, "30-45min", "./images/ricebowl-item.jpg",  widget.datat1.uid),
          foodItemsCards(context,"South Indian Thali", "Lunch & Dinner", 60, "30-45min", "./images/southindianthali.jpg",  widget.datat1.uid),
        ],
      ),
    );
  }
}





//Trending
class dataT2 {
  final String uid;
  dataT2(this.uid);
}
class Trending extends StatefulWidget {
  dataT2 datat2;
  Trending(this.datat2);
  @override
  _TrendingState createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        
        title: Text("Trending", style: TextStyle(
          color: Colors.white,
        ),),
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(0.0),
            elevation: 0.0,
            child: Container(
              height: 100.0,
              color: Colors.white10,
              child: Center(
                child: Text("Trending...",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
                      foodItemsCards(context,"ButterScotch Shake", "Breakfast & Dinner", 40, "30-45min", "./images/juice.jpg", widget.datat2.uid),
                      foodItemsCards(context,"Vanila Milk Shake", "Breakfast & Dinner", 40, "30-45min", "./images/juice.jpg", widget.datat2.uid),
                      foodItemsCards(context,"Choclate Milkshake", "Lunch & Dinner", 40, "30-45min", "./images/juice.jpg", widget.datat2.uid),
                      foodItemsCards(context,"Banana Juice", "Lunch & Dinner", 40, "30-45min", "./images/juice.jpg", widget.datat2.uid),
                      foodItemsCards(context,"Dominos Pizza - Large", "Lunch & Dinner", 400, "30-45min", "./images/dominospizza.jpg", widget.datat2.uid),
                      foodItemsCards(context,"Dominos Pizza - Medium", "Lunch & Dinner", 200, "30-45min", "./images/dominospizza.jpg", widget.datat2.uid),
                      foodItemsCards(context,"Dominos Pizza - Regular", "Lunch & Dinner", 120, "30-45min", "./images/dominospizza.jpg", widget.datat2.uid),
                      foodItemsCards(context,"Kitkat", "Lunch & Dinner", 60, "30-45min", "./images/choclatejuices.jpg", widget.datat2.uid),
                      foodItemsCards(context,"Mojito", "Lunch & Dinner", 60, "30-45min", "./images/choclatejuices.jpg", widget.datat2.uid),
                      foodItemsCards(context,"Oreo", "Lunch & Dinner", 60, "30-45min", "./images/choclatejuices.jpg", widget.datat2.uid),
                      foodItemsCards(context,"Biryai", "Lunch & Dinner", 60, "30-45min", "./images/Hyderabadi-biryani-7.jpg", widget.datat2.uid),
                      foodItemsCards(context,"Vada", "Breakfast & Dinner", 40, "30-45min", "./images/vada.jpg", widget.datat2.uid),
                      foodItemsCards(context,"Parota", "Breakfast & Dinner", 40, "30-45min", "./images/parota.jpg", widget.datat2.uid),
                      foodItemsCards(context,"Paneer Tikka", "Lunch & Dinner", 60, "30-45min", "./images/paneertikka.jpg", widget.datat2.uid),
                      foodItemsCards(context,"Burger", "Lunch & Dinner", 60, "30-45min", "./images/burger.jpg", widget.datat2.uid),
                      foodItemsCards(context,"French Fries", "Lunch & Dinner", 40, "30-45min", "./images/frenchfrice.jpg", widget.datat2.uid),
                      foodItemsCards(context,"Sandwich", "Lunch & Dinner", 60, "30-45min", "./images/sandwich.jpg", widget.datat2.uid),
                      foodItemsCards(context,"Garlic Rice", "Lunch & Dinner", 60, "30-45min", "./images/garlicrice.jpg", widget.datat2.uid),
                      foodItemsCards(context,"Mushroom Chilly", "Lunch & Dinner", 60, "30-45min", "./images/mushroom.png", widget.datat2.uid),
                      foodItemsCards(context,"Munchria", "Lunch & Dinner", 60, "30-45min", "./images/gobi-manchurian.jpg", widget.datat2.uid),
                      foodItemsCards(context,"Spring Roll", "Lunch & Dinner", 60, "30-45min", "./images/Mexican-Spring-Rolls-1-1-500x375.jpg", widget.datat2.uid),
        ],
      ),
    );
  }
}
