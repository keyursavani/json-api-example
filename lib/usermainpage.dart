import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:json_api_example/user.dart';
import 'package:json_api_example/userpostpage.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'main.dart';

class usermainpage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return usermainpagestate();
  }
}
enum Menu { LogOut }
class usermainpagestate extends State<usermainpage>{
  late SharedPreferences logindata;
  var  username;
  Future<List<User>> usersFuture = getUsers();

  static Future<List<User>> getUsers() async {
    const url='https://jsonplaceholder.typicode.com/users';
    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body);
    return body.map<User>(User.fromJson).toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }
  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username')!;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("User List Page"),
        actions: <Widget>[
          // This button presents popup menu items.
          PopupMenuButton<Menu>(
            // Callback that sets the selected popup menu item.
              onSelected: (Menu item) {
                logindata.setBool('login', true);
                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) => MyLoginPage()));
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                const PopupMenuItem<Menu>(
                  value: Menu.LogOut,
                  child: Text('LogOut'),
                ),
              ]),
        ],
      ),
      body: Center(
        child: FutureBuilder<List<User>>(
            future: usersFuture,
            builder: (context , snapshot){
              if(snapshot.connectionState == ConnectionState.waiting)
              {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Welcome $username' ,style: TextStyle(
                      fontSize: 25,
                    ),
                    ),
                    SizedBox(height: 30),
                    CircularProgressIndicator(
                      color: Colors.black45,
                    ),
                    SizedBox(height: 30),
                    Text("Loding...." , style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),)
                  ],
                );
              }
              else if(snapshot.hasData){
                final   users = snapshot.data!;
                // print('user: ${users}');
                return buildUsers(users);
              }
              else if(snapshot.hasError){
                return Column(
                  children: [
                    Text('${snapshot.hasError}'),
                    Text('${snapshot.error}'),
                  ],
                );
              }
              else{
                return Text("No User Data!");
              }
            }
        ),
      ),
    );
  }
}

Widget buildUsers(List<User> users) => ListView.builder(
    itemCount: users.length,
    itemBuilder:(context ,index){
      final user = users[index];
      final uri = Uri(userInfo: user.website);
      final lat = user.address.geo.lat;
      final lng = user.address.geo.lng;
      int id = user.id;
      return Card(
          child:  Row(
            children: <Widget> [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 20),
                      // Text('${user.name}', style:
                      //   Theme.of(context).textTheme.headline6, // like <h1> in HTML
                      // ),
                      SizedBox(height: 20),
                      Text(user.username , style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'RobotoMono',
                          // fontSize: 18,
                          // height: 3, //line height 200%, 1= 100%, were 0.9 = 90% of actual line height
                          // color: Colors.redAccent, //font color
                          // backgroundColor: Colors.black12, //background color
                          // letterSpacing: 5, //letter spacing
                          // decoration: TextDecoration.underline, //make underline
                          // decorationStyle: TextDecorationStyle.double, //double underline
                          // decorationColor: Colors.brown, //text decoration 'underline' color
                          // decorationThickness: 1.5, //decoration 'underline' thickness
                          fontStyle: FontStyle.italic
                      ),),
                      SizedBox(height: 20),
                      Text(user.name , style: TextStyle(
                        fontSize: 15,
                          fontFamily: 'Montserrat',
                          fontStyle: FontStyle.normal,
                        // fontSize: 38,
                        // height: 0.9, //line height 90% of actual height
                        // color: Colors.orangeAccent,
                        // decoration: TextDecoration.lineThrough,
                      ),),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context){
                                  return usserinfopage(user: user , url: uri , lat:lat , lng:lng);
                                }),
                              );
                              // Fluttertoast.showToast(
                              //     msg: '${id}',
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     gravity: ToastGravity.BOTTOM,
                              //     backgroundColor: Colors.black,
                              //     textColor: Colors.white);
                            },
                            icon:Icon(Icons.info, color: Colors.black54,)
                        ),
                        IconButton(
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context)=>
                                    userpostpage(userid: id),
                                  settings: RouteSettings(
                                    arguments: id,
                                  ),
                                ),
                              );
                            //   Fluttertoast.showToast(
                            //       msg: '${id}',
                            //       toastLength: Toast.LENGTH_SHORT,
                            //       gravity: ToastGravity.BOTTOM,
                            //       backgroundColor: Colors.black,
                            //       textColor: Colors.white);
                            },
                            icon:Icon(Icons.portrait ,color: Colors.black54)

                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Info" , style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                          fontSize: 14
                        ),),
                        Text("Post",style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                            fontSize: 14
                        ),)
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
      );
    }
);

class usserinfopage extends StatelessWidget{
  final User user;
  late  Uri url;
  late final lat;
  late final lng;
  usserinfopage({
    required this.user,
    required this.url,
    required this.lat,
    required this.lng,
  });
  @override
  Widget build(BuildContext context) {
    url = Uri.parse('https://${user.website}');
     // lat = user.address.geo.lat;
     // lng = user.address.geo.lng;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("User Information"),
      ),
      body:  Center(
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10 , top: 10 , bottom: 10),
          height: 500,
          width: 400,
          child: Card(
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.only(top: 10 , left:  10 , right:  8 ,bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Name :- ${user.name}',style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 19,
                  ),),
                  Text('Email :- ${user.email}', style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 17,
                  ),),
                  Text('Address :- ${user.address.street} , ${user.address.suite} , ${user.address.city} , ${user.address.zipcode}',
                    style:TextStyle(fontStyle: FontStyle.italic,
                    fontSize: 17,),),
                  Text('Phone :- ${user.phone}', style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 17
                  ),),
                  Text('Company Name :- ${user.company.name}', style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 17
                  ),),
                  // Text('Location :-${user.address.geo.lat} , ${user.address.geo.lng}'),
                  // Text('Location :-${user.address.geo.lng}'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          TextButton(
                            onPressed: _launchUrl,
                            child: Text(user.website, style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontStyle: FontStyle.italic
                            ),),
                          ),
                          SizedBox(height: 20,),
                          TextButton(
                            onPressed: () => MapsLauncher.launchQuery(
                                '$lat,$lng'),
                            child: Icon(Icons.location_on_outlined , color: Colors.black,size: 35,),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _launchUrl() async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
  }

