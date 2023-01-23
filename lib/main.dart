import 'package:flutter/material.dart';
import 'package:json_api_example/usermainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'example.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     theme: ThemeData(
       primarySwatch: Colors.blueGrey,
     ),
     home: MyLoginPage(),
   );
  }
}
// class MyHomePage extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return MyHomePageState();
//   }
// }
//
// class MyHomePageState extends State<MyHomePage>{
//   Future<List<User>> usersFuture = getUsers();
//
//   static Future<List<User>> getUsers() async {
//     const url='https://jsonplaceholder.typicode.com/users';
//     final response = await http.get(Uri.parse(url));
//     final body = json.decode(response.body);
//     return body.map<User>(User.fromJson).toList();
//   }
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Json Api Example"),
//       ),
//       body: Center(
//         child: FutureBuilder<List<User>>(
//           future: usersFuture,
//           builder: (context , snapshot){
//             if(snapshot.connectionState == ConnectionState.waiting)
//               {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CircularProgressIndicator(
//                       color: Colors.black45,
//                     ),
//                     SizedBox(height: 30),
//                     Text("Loding...." , style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold
//                     ),)
//                   ],
//                 );
//               }
//             else if(snapshot.hasData){
//               final   users = snapshot.data!;
//               // print('user: ${users}');
//               return buildUsers(users);
//             }
//             else if(snapshot.hasError){
//               return Column(
//                 children: [
//                   Text('${snapshot.hasError}'),
//                   Text('${snapshot.error}'),
//                 ],
//               );
//             }
//             else{
//               return Text("No User Data!");
//             }
//           }
//         ),
//       ),
//     );
//   }
// }
//
// Widget buildUsers(List<User> users) => ListView.builder(
//     itemCount: users.length,
//     itemBuilder:(context ,index){
//       final user = users[index];
//       final uri = Uri(userInfo: user.website);
//       int id = user.id;
//       return Card(
//         child:  Row(
//           children: <Widget> [
//             Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       SizedBox(height: 20),
//                       Text('${user.id}'),
//                       SizedBox(height: 20),
//                       Text(user.username),
//                       SizedBox(height: 20),
//                       Text(user.address.city),
//                       SizedBox(height: 20),
//                     ],
//                   ),
//                 ),
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: <Widget>[
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       IconButton(
//                           onPressed: (){
//                             Navigator.push(
//                               context,
//                             MaterialPageRoute(builder: (context){
//                               return usserinfopage(user: user , url: uri);
//                             }),
//                             );
//                             // Fluttertoast.showToast(
//                             //     msg: '${id}',
//                             //     toastLength: Toast.LENGTH_SHORT,
//                             //     gravity: ToastGravity.BOTTOM,
//                             //     backgroundColor: Colors.black,
//                             //     textColor: Colors.white);
//                           },
//                           icon:Icon(Icons.circle_outlined)
//                       ),
//                       IconButton(
//                           onPressed: (){
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context)=>
//                                userpostpage(userid: id),
//                               settings: RouteSettings(
//                                 arguments: id,
//                               ),
//                               ),
//                             );
//                             Fluttertoast.showToast(
//                                 msg: '${id}',
//                                 toastLength: Toast.LENGTH_SHORT,
//                                 gravity: ToastGravity.BOTTOM,
//                                 backgroundColor: Colors.black,
//                                 textColor: Colors.white);
//                           },
//                           icon:Icon(Icons.circle_outlined)
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Text("User Info"),
//                       Text("User Post")
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         )
//       );
//     }
// );
//
// class usserinfopage extends StatelessWidget{
//   final User user;
//   late  Uri url;
//      usserinfopage({
//     required this.user,
//     required this.url,
//   });
//   @override
//   Widget build(BuildContext context) {
//        url = Uri.parse('https://${user.website}');
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("User Information"),
//       ),
//       body:  Center(
//         child: Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               Text('Name :- ${user.name}'),
//               Text('Email :- ${user.email}'),
//               Text('Address :- ${user.address.street}'),
//               Text(user.address.suite),
//               Text(user.address.city),
//               Text(user.address.zipcode),
//               Text('Phone :- ${user.phone}'),
//               Text('Company Name :- ${user.company.name}'),
//               TextButton(
//                   onPressed: _launchUrl,
//                   child: Text(user.website),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   Future<void> _launchUrl() async {
//     if (!await launchUrl(url)) {
//       throw 'Could not launch $url';
//     }
//   }
// }

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}
class _MyLoginPageState extends State<MyLoginPage> {
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();
  late SharedPreferences logindata;
  late bool newuser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_if_already_login();
  }
  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => usermainpage()));
    }
  }
  @override
  void dispose() {
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Loging Screen"),
      // ),
      body: Center(
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10 , top: 10 , bottom: 10),
            height: 400,
              child: Card(
                color: Colors.white38,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Login",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextField(
                        controller: username_controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'username',
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextField(
                        controller: password_controller,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      // textColor: Colors.white,
                      // color: Colors.blue,
                      onPressed: () {
                        String username = username_controller.text;
                        String password = password_controller.text;
                        if (username == 'keyur' && password == '1234') {
                          print('Successfull');
                          logindata.setBool('login', false);
                          logindata.setString('username', username);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => usermainpage()));
                        }
                      },
                      child: Text("LogIn"),
                    )
                  ],
                ),
              ),
            ),
          ),

    );
  }
}





