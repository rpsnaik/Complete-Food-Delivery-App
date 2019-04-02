import 'package:flutter/material.dart';
import './items-card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './main.dart';
import './second_page.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart';



class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}


placeholderHome(BuildContext context, String uid) {  
  return SafeArea(
        child: ListView(
          children: <Widget>[
                Material(
                elevation: 10.0,
                color: HexColor('#880E4F'),
                child: Container(
                height: 50.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                      smallTextItems('Break Fast Items'),
                      smallTextItems('Lunch'),
                      smallTextItems('Dinner'),
                      smallTextItems('Hyderabadi Biryani'),
                      smallTextItems('Dominos Pizza'),
                      smallTextItems('Butter Roti'),
                      smallTextItems('Thali'),
                      smallTextItems('South indian Thali'),
                      smallTextItems('Amul Products'),
                  ],
                ),
              ),
             ),
              

            // Text("$uid", style: TextStyle(
            //   fontSize: 20.0,
            //   fontWeight: FontWeight.bold,
            // ),),

             Container(
               padding: EdgeInsets.all(10.0),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   Text("Busy with work",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                    ),
                    ),
                    Text("Order food online with recipers.",
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                    ),
                    Image.asset('./images/people.jpg'),
                 ],
               ),
             ),

            

              Container(
                
                height: 100.0,
                child: ListView(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BrandedItems(dataT(uid))),
                        );
                      },
                      child: Card(
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Container(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.fastfood, color: Colors.white, size: 30.0,),
                                SizedBox(height: 10.0,),
                                Text("Branded items", style: TextStyle(
                                  color: HexColor('#F1F1F1'),
                                ),),
                              ],
                            ),
                          ),
                          width: 160.0,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Offers(dataT1(uid))),
                        );
                      },
                      child: Card(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Container(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.local_offer, color: Colors.white, size: 30.0,),
                                SizedBox(height: 10.0,),
                                Text("Offers", style: TextStyle(
                                  color: HexColor('#F1F1F1'),
                                ),),
                              ],
                            ),
                          ),
                          width: 160.0,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Trending(dataT2(uid))),
                        );
                      },
                      child: Card(
                        color: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Container(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.trending_up, color: Colors.white, size: 30.0,),
                                SizedBox(height: 10.0,),
                                Text("Trending", style: TextStyle(
                                  color: HexColor('#F1F1F1'),
                                ),),
                              ],
                            ),
                          ),
                          width: 160.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: <Widget>[   
                      SizedBox(
                        height: 10.0,
                      ),
                      Card(
                        color: Colors.blue,
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          child: Row(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.info,color: Colors.white,),
                          SizedBox(width: 20.0,),
                          Text("You can tell your additional preferences \n when the delivery boy calls \n you after your order was placed.", style: TextStyle(
                            color: Colors.white,
                          ),),
                        ],
                      ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      foodItemsCards(context,"Munchuria", "Lunch & Dinner", 60, "30-45min", "./images/gobi-manchurian.jpg", uid),
                      foodItemsCards(context,"Spring Roll", "Lunch & Dinner", 60, "30-45min", "./images/Mexican-Spring-Rolls-1-1-500x375.jpg", uid),
                      foodItemsCards(context,"Honey Chilli", "Lunch & Dinner", 30, "30-45min", "./images/honeychilli.jpg", uid),
                      foodItemsCards(context,"Gobi Fried rice", "Lunch & Dinner", 60, "30-45min", "./images/gobifriedrice.jpg", uid),
                      foodItemsCards(context,"Munchurian Fried rice", "Lunch & Dinner", 60, "30-45min", "./images/munchrianfriedrice.jpg", uid),
                      foodItemsCards(context,"Chana Samosa", "Breakfast & Dinner", 30, "30-45min", "./images/chanasamosa.png", uid),
                      foodItemsCards(context,"Chana Kachori", "Breakfast & Dinner", 30, "30-45min", "./images/chanakachori.jpg", uid),
                      foodItemsCards(context,"Kiwi Juice", "Breakfast & Dinner", 40, "30-45min", "./images/kiwijuice.jpg", uid),
                      foodItemsCards(context,"Orange Juice", "Breakfast & Dinner", 40, "30-45min", "./images/orange.png", uid),  
                      foodItemsCards(context,"Pineapple Juice", "Breakfast & Dinner", 40, "30-45min", "./images/pineapple.jpg", uid),
                      foodItemsCards(context,"ButterScotch Shake", "Breakfast & Dinner", 40, "30-45min", "./images/juice.jpg", uid),
                      foodItemsCards(context,"Vanila Milk Shake", "Breakfast & Dinner", 40, "30-45min", "./images/juice.jpg", uid),
                      foodItemsCards(context,"Choclate Milkshake", "Lunch & Dinner", 40, "30-45min", "./images/juice.jpg", uid),
                      foodItemsCards(context,"Banana Juice", "Lunch & Dinner", 40, "30-45min", "./images/juice.jpg", uid),
                      foodItemsCards(context,"Dominos Pizza - Large", "Lunch & Dinner", 400, "30-45min", "./images/dominospizza.jpg", uid),
                      foodItemsCards(context,"Dominos Pizza - Medium", "Lunch & Dinner", 200, "30-45min", "./images/dominospizza.jpg", uid),
                      foodItemsCards(context,"Dominos Pizza - Regular", "Lunch & Dinner", 120, "30-45min", "./images/dominospizza.jpg", uid),
                      foodItemsCards(context,"Kitkat", "Lunch & Dinner", 60, "30-45min", "./images/choclatejuices.jpg", uid),
                      foodItemsCards(context,"Mojito", "Lunch & Dinner", 60, "30-45min", "./images/choclatejuices.jpg", uid),
                      foodItemsCards(context,"Oreo", "Lunch & Dinner", 60, "30-45min", "./images/choclatejuices.jpg", uid),
                      foodItemsCards(context,"Chinna Punugulu", "Breakfast & Dinner", 40, "30-45min", "./images/punugulu.jpg", uid),
                      foodItemsCards(context,"Uthappam", "Breakfast & Dinner", 50, "30-45min", "./images/Uthappam.jpg", uid),
                      foodItemsCards(context,"Upma", "Breakfast & Dinner", 40, "30-45min", "./images/upma.png", uid),
                      foodItemsCards(context,"Parantha", "Breakfast & Dinner", 30, "30-45min", "./images/parantha.jpg", uid),
                      foodItemsCards(context,"Noodels", "Lunch & Dinner", 40, "30-45min", "./images/noodels.jpg", uid),
                      foodItemsCards(context,"Fried rice", "Lunch & Dinner", 30, "30-45min", "./images/gobifriedrice.jpg", uid),
                      foodItemsCards(context,"Honey Chilli", "Lunch & Dinner", 60, "30-45min", "./images/honeychilli.jpg", uid),
                      foodItemsCards(context,"Poha", "Breakfast & Dinner", 30, "30-45min", "./images/poha.jpg", uid),
                      foodItemsCards(context,"Chilli Bajji", "Break Fast & Dinner", 40, "30-45min", "./images/bajji.jpg", uid),
                      foodItemsCards(context,"Mysore Bonda/Bajji", "Break Fsst& Dinner", 40, "30-45min", "./images/Mysore-Bonda-Recipe.jpg", uid),
                      foodItemsCards(context,"Puri", "Break fast, Breakfast & Dinner", 40, "30-45min", "./images/puri.jpg", uid),
                      foodItemsCards(context,"Biryani", "Lunch & Dinner", 60, "30-45min", "./images/Hyderabadi-biryani-7.jpg", uid),
                      foodItemsCards(context,"Thali", "Lunch & Dinner", 60, "30-45min", "./images/thali.jpg", uid),
                      foodItemsCards(context,"South Indian Dosa", "Break Fast & Dinner", 40, "30-45min", "./images/dosa.jpg", uid),
                      foodItemsCards(context,"Rice Bowl", "Fast Lunch & Dinner", 50, "30-45min", "./images/ricebowl-item.jpg", uid),
                      foodItemsCards(context,"South Indian Thali", "Lunch & Dinner", 60, "30-45min", "./images/southindianthali.jpg", uid),
                      foodItemsCards(context,"Idli", "Breakfast & Dinner", 40, "30-45min", "./images/idlis.jpg", uid),
                      foodItemsCards(context,"Punugulu", "Breakfast & Dinner", 40, "30-45min", "./images/punugulu.jpg", uid),
                      foodItemsCards(context,"Tomato Rice", "Lunch & Dinner", 30, "30-45min", "./images/tomatorice.jpg", uid),
                      foodItemsCards(context,"Curd rice", "Lunch & Dinner", 50, "30-45min", "./images/Curd_Rice.jpg", uid),
                      foodItemsCards(context,"Vada", "Breakfast & Dinner", 40, "30-45min", "./images/vada.jpg", uid),
                      foodItemsCards(context,"Parota", "Breakfast & Dinner", 40, "30-45min", "./images/parota.jpg", uid),
                      foodItemsCards(context,"Paneer Tikka", "Lunch & Dinner", 60, "30-45min", "./images/paneertikka.jpg", uid),
                      foodItemsCards(context,"Burger", "Lunch & Dinner", 60, "30-45min", "./images/burger.jpg", uid),
                      foodItemsCards(context,"French Fries", "Lunch & Dinner", 40, "30-45min", "./images/frenchfrice.jpg", uid),
                      foodItemsCards(context,"Sandwich", "Lunch & Dinner", 60, "30-45min", "./images/sandwich.jpg", uid),
                      foodItemsCards(context,"Garlic Rice", "Lunch & Dinner", 60, "30-45min", "./images/garlicrice.jpg", uid),
                      foodItemsCards(context,"Mushroom Chilly", "Lunch & Dinner", 60, "30-45min", "./images/mushroom.png", uid),
                      
              ]
             ),
            ) 
          ],
        )
      );
}














//Cart







Widget placeholderCart(BuildContext context, String uid){
  return ListView(
    children: <Widget>[
      Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "My Cart",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text("Orders will be deliverd by 30-45 Mins"),
          Image.asset('./images/delivery_boy.jpg',fit: BoxFit.cover,height: 250.0,), 
          SizedBox(
            height: 50.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: (){
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainFetchData(Todo12(uid)),
                  ),
                );
                },
                child: Card(
              elevation: 10.0,
              color: Colors.blue,
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                 Icon(Icons.shopping_cart, color: Colors.white,),
                 SizedBox(
                   width: 20.0,
                 ),
                 Text("My Orders", style: TextStyle(color: Colors.white, fontSize: 18.0),),
                 Icon(Icons.chevron_right, color: Colors.white),
                 
              ],
            ),
              )
            ),
              )
              
              

            ],
          ),
          SizedBox(
            height: 20.0,
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
  )
    ],
  );
}




//Profile

Widget placeholderProfile(BuildContext context, String uid, String email, String name, String mobile, String hostel, String block, String room){
  return ListView(
      children: <Widget>[
        Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 150.0,
            child: Image.asset('./images/profile.png'),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text("Hello, "+name, style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),),
          ],
        ),
      ),
      Container(
        height: 80.0,
        width:  MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
        child: Container(
         
          child: Card(
          color: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                children: <Widget>[
                  Icon(Icons.phone, color: Colors.white,),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(mobile, style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                  ),)
                ],
              ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                children: <Widget>[
                  Icon(Icons.mail, color: Colors.white,),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(email, style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                  ),)
                ],
              ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                children: <Widget>[
                  Icon(Icons.person, color: Colors.white,),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text("Customer", style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                  ),)
                ],
              ),
              ),
            ],
          ),
        ),
        )
      )
          ],
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: (){
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainFetchData(Todo12(uid)),
                  ),
                );
                },
                child: Card(
              elevation: 10.0,
              color: Colors.indigo,
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 Icon(Icons.fastfood, color: Colors.white,),
                 SizedBox(
                   width: 20.0,
                 ),
                 Text("My Orders", style: TextStyle(color: Colors.white, fontSize: 18.0),),
              ],
            ),
              )
            ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditDet(Todo123(uid)),
                  )
                );
              },
              child: Card(
              elevation: 10.0,
              color: Colors.teal,
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 Icon(Icons.local_offer, color: Colors.white,),
                 SizedBox(
                   width: 20.0,
                 ),
                 Text("Cashback Offers", style: TextStyle(color: Colors.white, fontSize: 18.0),),
              ],
            ),
              )
            ),
            ),
            InkWell(
              onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => EditDetonceagain(gettingDet(uid, email)) ));
              },
              child: Card(
                elevation: 10.0,
                color: Colors.orange,
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.edit, color: Colors.white,),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text("Edit Details", style: TextStyle(color: Colors.white, fontSize: 18.0),),
                ],
              ),
                )
              ),
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
              child: Card(
                elevation: 10.0,
                color: Colors.blueAccent,
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.location_city, color: Colors.white,),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text("Privacy Policy/Terms & Conditions", style: TextStyle(color: Colors.white, fontSize: 18.0),),
                ],
              ),
                )
              ),
            ),
            InkWell(
              onTap: () async {
               const url = 'http://rpsnaik.cf/recipers/about.html';
                                                              if(await canLaunch(url)){
                                                                await launch(url);
                                                              }
                                                              else{
                                                                throw 'Could not launch $url';
                                                              }
              },
              child: Card(
                elevation: 10.0,
                color: Colors.green,
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.info, color: Colors.white,),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text("About us", style: TextStyle(color: Colors.white, fontSize: 18.0),),
                ],
              ),
                )
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Feedback()));
              },
              child: Card(
              elevation: 10.0,
              color: Colors.pink,
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 Icon(Icons.feedback, color: Colors.white,),
                 SizedBox(
                   width: 20.0,
                 ),
                 Text("Feedback", style: TextStyle(color: Colors.white, fontSize: 18.0),),
              ],
            ),
              )
            ),
            ),
            InkWell(
              onTap: () async {
     

              showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    title: Text("Do you want to Logout"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("Close"),
                        onPressed: (){
                          Navigator.of(context).pop(context);
                        },
                      ),
                      RaisedButton(
                        onPressed: () async {
                             SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.remove("emailid");
                              prefs.remove("userid");
                              prefs.remove("passwordid");
                              prefs.commit();
                              Navigator.of(context).pop(context);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn()));
                        },
                        child: Text("Log out", style: TextStyle(
                          color: Colors.white,
                        ),),
                      )
                    ],
                  );
                }
              );
            },
              child: Card(
              elevation: 10.0,
              color: Colors.red,
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 Icon(Icons.assignment_return, color: Colors.white,),
                 SizedBox(
                   width: 20.0,
                 ),
                 Text("Logout", style: TextStyle(color: Colors.white, fontSize: 18.0),),
              ],
            ),
              )
            ),
            )
          ],
        ),
      ),
      Padding(padding: EdgeInsets.all(5.0),),
      Text("Powered by", textAlign: TextAlign.center,),
      Container(
        height: 40.0,
        child: Image.asset('./images/recipers-subtitle.png', fit: BoxFit.fitHeight,),
      ),
      Text("Inspired By Material Design.", textAlign: TextAlign.center,),
      Padding(padding: EdgeInsets.all(5.0),),
    

      ],
    
  );
}

class gettingDet{
  final String uid;
  final String email;
  gettingDet(this.uid, this.email);
}


class EditDetonceagain extends StatefulWidget {
  final gettingDet getdetfinal;
  EditDetonceagain(this.getdetfinal);
  @override
  _EditDetonceagainState createState() => _EditDetonceagainState();
}

class _EditDetonceagainState extends State<EditDetonceagain> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text("Edit Details"),
      ),
      url: "https://recipers-2019.firebaseapp.com/change_address.html?uid="+widget.getdetfinal.uid+"&email="+widget.getdetfinal.email,
    );
  }
}

class Feedback extends StatefulWidget {
  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback"),
      ),
      body: Center(
            child: Container(
              padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                 Text("Send your Valuable Feedback at : ", style: TextStyle(
                   fontSize: 20.0,
                 ),),
                 SizedBox(height: 10.0,),
                 Text("naik.rpsn@gmail.com"),
                 Text("OR"),
                 Text("rps_naik@outlook.com"),
              ],
            ),
          ),),
    );
  }
}

/*


RaisedButton(
            color: Colors.green,
            child: new Text("Profile Details", style: TextStyle(
              color: Colors.white,
            ),),
            onPressed: null,
          ),
           RaisedButton(
            child: Text("Log Out",style: TextStyle(color: Colors.white),),
            color: Colors.blue,
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove("emailid");
              prefs.remove("userid");
              prefs.remove("passwordid");
              prefs.commit();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn()));
            },
          ),



Text("Email ID : "+email, style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),),
          Text("Name : "+name, style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),),
          Text("Mobile : "+mobile, style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),),
          Text("Hostel : "+hostel, style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),),
          Text("Block : "+block, style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),),
          Text("Room : "+room, style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(height: 20.0,),
          Text("UID : "+ uid.toString(), style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),),

*/