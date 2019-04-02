import 'package:flutter/material.dart';
import './placeholder_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import "package:url_launcher/url_launcher.dart";
import './second_page.dart';

void main() async {
  List _data = await getJson("https://recipers-2019.firebaseio.com/.json");
  runApp(
    new MaterialApp(
      title: 'Recipers',
      home: new SignIn(),
      theme: ThemeData(
        fontFamily: 'Nunitno',
      ),
    )
  );
}
//Color Convertor
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


  Future<bool> saveNamePreference(String emailSave, String passwordSave, String userid) async{
    List _data = await getJson("https://recipers-2019.firebaseio.com/.json");
    var localdata = _data[0]['users'][userid];
    print(localdata);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("emailid", emailSave);
    prefs.setString("userid", userid);
    prefs.setString("passwordid", passwordSave);
    prefs.setString("nameid", localdata['name']);
    prefs.setString("hostelid", localdata['hostel']);
    prefs.setString("hostelblock", localdata['block']);
    prefs.setString("roomid", localdata['room']);
    prefs.setString("mobile", localdata['mobile']);
    return prefs.commit();
  }
  Future<String> getNamePreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String emailis = prefs.getString("emailid");
    return emailis;
  }

  Future<String> getpassPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pass = prefs.getString("passwordid");
    return pass;
  }


Future<List> getJson(String apiUrl) async {
  http.Response response = await http.get(apiUrl);
  return json.decode(response.body);
}








//signin




class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final key = new GlobalKey<ScaffoldState>();
  String emailfrom = "";
  String passwordfrom = "";
  int _starterindex = 0;
  bool signinbtnloader = false;
   
  @override
  void initState() {
    preSigninCheck();
    super.initState();
  }
  

   Widget placeholderLogin(){
  return ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('./images/recipers-subtitle.png'),
                SizedBox(
                  height: 30.0,
                ),
                Text("Sign in..."+emailfrom, style: TextStyle(color: Colors.green, fontSize: 30.0, fontWeight: FontWeight.w400),),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  validator: (input){
                    if(input.isEmpty){
                      return 'Please type an E-Mail';
                    }
                  },
                  controller: _emailController,
                  decoration: InputDecoration(
                      labelText: 'E-Mail'
                  ),
                ),
                TextFormField(
                  validator: (input){
                    if(input.length < 6){
                      return 'Your Password must be of 6 charecters';
                    }
                  },
                  controller: _passwordController,
                  decoration: InputDecoration(
                      labelText: 'Password'
                  ),
                  obscureText: true,
                ),
                SizedBox(
                  height: 30.0,
                ),
                RaisedButton(onPressed: signIn,
                  color: Colors.brown,
                  padding: EdgeInsets.all(10.0),
                  child: _signinbtn(),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("New user ? "),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUp()));
                      },
                      child: Text("Sign up here", style: TextStyle(color: Colors.blue),),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Forgot Password ?"),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => forgotPass(),
                          )
                        );
                      },
                      child: Text(" Click me", style: TextStyle(color: Colors.blue),),
                    )
                  ],
                ),

              ],
            ),
          ),
        ],
      );
}

Widget _signinbtn(){
  if(signinbtnloader == true){
    return CircularProgressIndicator();
  }
  else{
    return Text("Sign in", style: TextStyle(
                    color: Colors.white,
                  ),);
  }
}
  Widget placeholderLoginLogin(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('./images/recipers-subtitle.png'),
          SizedBox(height:10.0),
          CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget loading(){
    if(_starterindex  == 0){
       return placeholderLoginLogin();
    }
    else{
      return placeholderLogin();
    }
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: loading(),
    );
  }


  
       String email, pass;
        void getemail(String emailid){
          setState(() {
            email = emailid;
          });
          
        }
        void getpassword(String password){
          setState(() {
            pass = password; 
          });
        }

        
    

  Future<void> preSigninCheck() async {
        await getNamePreference().then(getemail);
        await getpassPreference().then(getpassword);
        print("EMAIL "+ email.toString());
        print(pass);
        Future<void>preloader() async{
          try{
          FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);
          saveNamePreference(email, pass, user.uid);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage(SendingUid(user.uid))));
        }catch(e){
          print(e.message.toString());
         
          print(email);
          print(pass);
          setState(() {
            _starterindex = 1; 
          });
        }
        }
        Future.delayed(Duration(seconds: 1), preloader);
  }

  Future<void> signIn() async {
      Future<void> checkuser() async{
        try{
         FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
         saveNamePreference(_emailController.text, _passwordController.text, user.uid);
         Future.delayed(Duration(seconds: 2), preSigninCheck);
         Future.delayed(Duration(seconds: 2), preSigninCheck);
       }catch(e){
         setState(() {
          signinbtnloader = false; 
          });
          key.currentState.showSnackBar(new SnackBar(
                content: new Text("Please Check your Network Connection... and Enter valid Email and Password"),
              ));
         print(e.message.toString());
         print("Unsuccessfull");
         setState(() {
          _starterindex = 1; 
         });
       }
      }

      setState(() {
       signinbtnloader = true; 
       Future.delayed(Duration(seconds: 1), checkuser);
      });

  }
}




class Url{
  final String url;
  final String uid;
  Url(this.url, this.uid);
}


class SignupDet extends StatefulWidget {
  final Url url;
  final Url uid;
  SignupDet(BuildContext context,this.url,this.uid);
  @override
  _SignupDetState createState() => _SignupDetState();
}

class _SignupDetState extends State<SignupDet> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text("Account Registration"),
      ),
      url: widget.url.url,
    );
  }
}



class forgotPass extends StatefulWidget {
  @override
  _forgotPassState createState() => _forgotPassState();
}

class _forgotPassState extends State<forgotPass> {
  final key = new GlobalKey<ScaffoldState>();
  final emailReset = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment:  MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Forgot Password...",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("Find your account... Enter your E-Mail", style: TextStyle(fontSize: 15.0),),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                  validator: emailCheck,
                  controller: emailReset,
                  decoration: InputDecoration(
                      labelText: 'E-Mail'
                  ),
                  
                ),

                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  onPressed: forGotpass,
                  child: Text("Send Password Reset"),
                )
            ],
          ),
        )
      ],
    ),
    );
  }
  String emailCheck(String value){
                    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regExp = new RegExp(pattern);
                    if (value.length == 0) {
                      return "Email is Required";
                    } else if(!regExp.hasMatch(value)){
                      return "Invalid Email";
                    }else {
                      return null;
                    }
                  
  }
  Future<void>forGotpass() async {
      String email;

      if(emailCheck(emailReset.text) == null){
        email = emailReset.text;
        try {
          await FirebaseAuth.instance.sendPasswordResetEmail(email:email);
          key.currentState.showSnackBar(new SnackBar(
                content: new Text("We sent an Email to Reset your Password, Check your Inbox"),
          ));
        } catch (e) {
          print(e);
          key.currentState.showSnackBar(new SnackBar(
                content: new Text(e.toString()),
          ));
        }
      }
      else{
        print("In valid Email");
        key.currentState.showSnackBar(new SnackBar(
                content: new Text("Invalid Email ID"),
        ));
        
      }
}
}




//signup
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}



class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String name, email, mobile, password, hostel, block, room;
  bool signupbtnloader = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
      
        body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(50.0),
            child: Column(
              children: <Widget>[
                Image.asset('images/recipers-subtitle.png'),
                Form(
                  key: _key,
                  autovalidate: _validate,
                  child: formUI(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget formUI() {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 30.0,
        ),
        Text("Sign up...", style: TextStyle(color: Colors.green, fontSize: 30.0, fontWeight: FontWeight.w400, fontFamily: 'Nunitno',),),
        SizedBox(
          height: 10.0,
        ),
        Text("Please, Sign up over a highspeed internet Network, else your app may not work properly", textAlign: TextAlign.center,style: TextStyle(
          fontFamily: 'Nunitno',
        ),),
        SizedBox(
          height: 30.0,
        ),
        new TextFormField(
          decoration: InputDecoration(
                      labelText: 'username'
                  ),
          maxLength: 32,
          validator: validateName,
          onSaved: (String val) {
            name = val;
          },
        ),
        new TextFormField(
            decoration: InputDecoration(
                      labelText: 'Mobile Number'
                  ),
            keyboardType: TextInputType.phone,
            maxLength: 10,
            validator: validateMobile,
            onSaved: (String val) {
              mobile = val;
            }),
        new TextFormField(
            decoration: InputDecoration(
                      labelText: 'Email ID',
                  ),
            keyboardType: TextInputType.emailAddress,
            maxLength: 100,
            validator: validateEmail,
            onSaved: (String val) {
              email = val;
            }),
            new TextFormField(
            decoration: InputDecoration(
                      labelText: 'Hostel Name'
                  ),
            keyboardType: TextInputType.emailAddress,
            maxLength: 32,
            validator: validateNoEmpty,
            onSaved: (String val) {
              hostel = val;
            }),
            new TextFormField(
            decoration: InputDecoration(
                      labelText: 'Block'
                  ),
            keyboardType: TextInputType.emailAddress,
            maxLength: 32,
            validator: validateNoEmpty,
            onSaved: (String val) {
              block = val;
            }),
            new TextFormField(
            decoration: InputDecoration(
                      labelText: 'Room Number'
                  ),
            keyboardType: TextInputType.emailAddress,
            maxLength: 32,
            validator: validateNoEmpty,
            onSaved: (String val) {
              room = val;
            }),
            new TextFormField(
            decoration: InputDecoration(
                      labelText: 'Set a new password'
                  ),
            validator: validatePass,
            obscureText: true,
            maxLength: 32,
            onSaved: (String val) {
              password = val;
            }),
            SizedBox(
                  height: 10.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("By clicking Sign up, you agree to our Terms and Conditions and our Data Use Policy, You can read them here", style: TextStyle(
                      fontFamily: 'Nunitno',
                    ),textAlign: TextAlign.center,),
                
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
                      child: Text(" Terms and Conditions", style: TextStyle(color: Colors.blue, fontFamily: 'Nunitno',),),
                    )
                  ],
                ),
        new SizedBox(height: 15.0),
        new RaisedButton(
          padding: EdgeInsets.all(10.0),
          color: Colors.brown,
          onPressed: signUpBtn,
          child: _signupbtn(),
        ),
        SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Already have an account ? ", style: TextStyle(
                      fontFamily: 'Nunitno',
                    ),),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context) ;
                      },
                      child: Text("Sign in here", style: TextStyle(color: Colors.blue, fontFamily: 'Nunitno',),),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Forgot Password ?", style: TextStyle(
                      fontFamily: 'Nunitno',
                    ),),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => forgotPass(),
                          )
                        );
                      },
                      child: Text(" Click me", style: TextStyle(color: Colors.blue, fontFamily: 'Nunitno',),),
                    )
                  ],
                ),

                
      ],
    );
  }



  String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  String validatePass(String value) {
    if (value.length < 6) {
      return "Password must be of 6 charecters";
    }
    return null;
  }

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if(value.length != 10){
      return "Mobile number must 10 digits";
    }else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }

    String validateNoEmpty(String value) {
    if (value.length == 0) {
      return "This field is required";
    }
    return null;
  }


  String validateEmail(String value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if(!regExp.hasMatch(value)){
      return "Invalid Email";
    }else {
      return null;
    }
  }

  Widget _signupbtn(){
  if(signupbtnloader == true){
    return CircularProgressIndicator();
  }
  else{
    return Text("Sign up", style: TextStyle(
        color: Colors.white,
        fontFamily: 'Nunitno',
    ),);
  }
}


  Future<void> signUpBtn() async {
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();
      print("Name $name");
      print("Mobile $mobile");
      print("Email $email");
      print("Password $password");
       Future<void>signupuser() async{
         try{
          FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
          var url = "https://recipers-2019.firebaseapp.com/create__user.html?&uid="+user.uid+"&name="+name+"&email="+email+"&mobile="+mobile+"&hostel="+hostel+"&block="+block+"&room="+room+"&submitted=true";
          print(url);
          Navigator.pushReplacement(context,
               MaterialPageRoute(builder: (context) => SignupDet(context, Url(url, user.uid) , Url(url, user.uid))),
          );
        }catch(e){
                setState(() {
                  signupbtnloader = false; 
                });
          print(e.message);
        }
       }

      setState(() {
       signupbtnloader = true; 
       Future.delayed(Duration(seconds: 2), signupuser);
      });

    } else {
      setState(() {
        _validate = true;
      });
    }
  }
}














class SendingUid{
     final String uid;
     SendingUid(this.uid);
}




class HomePage extends StatefulWidget{
  final SendingUid suid;
  HomePage(this.suid);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  int _currentIndex = 0;
  void bottNavClicks(int index) {
  
   setState(() {
     _currentIndex = index;
   });
  }


Future<String> getName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("nameid");
    return name;
}
Future<String> getEmail() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("emailid");
    return email;
}
Future<String> getMobile() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String mobile = prefs.getString("mobile");
    return mobile;
}
Future<String> getHostel() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String hostel = prefs.getString("hostelid");
    return hostel;
}
Future<String> getBlock() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String block = prefs.getString("hostelblock");
    return block;
}
Future<String> getRoom() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String room = prefs.getString("roomid");
    return room;
}
  String emailid;
  String username;
  String mobilenum;
  String hostelname;
  String blockname;
  String roomname;

  void getemail(String email){
    setState(() {
      emailid = email; 
    });
  }
  void getname(String name){
    setState(() {
      username = name; 
    });
  }
  void getmobile(String mobile){
    setState(() {
     mobilenum = mobile; 
    });
  }
  void gethostel(String hostel){
    setState(() {
     hostelname = hostel; 
    });
  }
  void getblock(String block){
    setState(() {
     blockname = block; 
    });
  }
  void getroom(String room){
    setState(() {
     roomname = room; 
    });
  }


Future<void> starterFun()async{
   getEmail().then(getemail);
   getName().then(getname);
   getMobile().then(getmobile);
   getHostel().then(gethostel);
   getBlock().then(getblock);
   getRoom().then(getroom);
}


void initState(){
    starterFun();
    super.initState();
  }
  
  @override
Widget build(BuildContext context) {
  final List<Widget> _children = [
    placeholderHome(context, widget.suid.uid),
    placeholderCart(context, widget.suid.uid),
    placeholderProfile(context, widget.suid.uid, emailid, username, mobilenum, hostelname, blockname, roomname),
   ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#f5f5f5'),
        title: new Image.asset('images/reciper.png', fit: BoxFit.cover),
        actions: <Widget>[

          Container(
            child: Row(
              children: <Widget>[
                InkWell(
                
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainFetchData(Todo12(widget.suid.uid)),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.brown,
                    radius: 18.0,
                    child: Icon(Icons.shopping_cart, color: Colors.white,size: 22.0,),
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),),
                InkWell(
                  onTap: () async {
                    const url = 'http://rpsnaik.cf/recipers/help.html';
                                                              if(await canLaunch(url)){
                                                                await launch(url);
                                                              }
                                                              else{
                                                                throw 'Could not launch $url';
                                                              }
                  },
                  child: Icon(Icons.help, color: Colors.blue, size: 30.0,),
                ),
                Padding(padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),),
              ],
            ),
          )

          
        ],
      ),

      body:_children[_currentIndex],


      bottomNavigationBar: BottomNavigationBar(
        onTap: bottNavClicks,
       fixedColor: Colors.blue,
       currentIndex: _currentIndex, // this will be set when a new tab is tapped
       items: [
         BottomNavigationBarItem(
           icon: new Icon(Icons.home),
           title: new Text('Home'),
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.fastfood),
           title: new Text('Cart'),
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.person),
           title: Text('Profile')
         )
       ],
     ),
    );
  }
}