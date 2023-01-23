// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:json_api_example/post.dart';
// import 'package:http/http.dart' as http;
//
//
//
// Future<List<Post>> postsFuture = getPosts();
//
//  Future<List<Post>> getPosts() async {
// const url = 'https://jsonplaceholder.typicode.com/posts';
// final response = await http.get(Uri.parse(url));
// final body = json.decode(response.body);
// return body.map<Post>(Post.fromJson).toList();
// }
//
// Widget userpost2page(id) => FutureBuilder<List<Post>>(
//   future: postsFuture,
//     builder: (contaxt , snapshot){
//     print(id);
//     debugPrint('${id}');
//     if(snapshot.connectionState == ConnectionState.waiting)
//     {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircularProgressIndicator(
//             color: Colors.black45,
//           ),
//           SizedBox(height: 30),
//           Text("Loding...." , style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold
//           ),)
//         ],
//       );
//     }
//     else if(snapshot.hasData){
//       final posts = snapshot.data!;
//       return buildPost(id,posts);
//     }
//     else if(snapshot.hasError){
//       return Column(
//         children: [
//           Text('${snapshot.hasError}'),
//           Text('${snapshot.error}'),
//         ],
//       );
//     }
//     else{
//       return Text("No User Data!");
//     }
//     }
// );
//
// Widget buildPost( id,posts)  => ListView.builder(
//     itemCount: id.length,
//     itemBuilder: (BuildContext context, id){
//       // print(userid);
//       // debugPrint('${userid}');
//       final post = posts[id];
//        final userId = id;
//       return Card(
//         child: Column(
//           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             // Text('${post.userId}'),
//             Padding(
//               padding: const EdgeInsets.only(left: 8),
//               child: Text('${post.userId}'),
//             ),
//             Container(
//               // padding: const EdgeInsets.only(left: 4 , right: 3),
//               child: ListTile(
//                 title: Text('${post.title}'),
//               ),
//             ),
//             Container(
//               // padding: const EdgeInsets.only(left: 5 , right: 3),
//               child: ListTile(
//                 subtitle: Text('${post.body}'),
//               ),
//             ),
//             // Text('${post.userId}'),
//             //  Text('${post.id}'),
//             //  SizedBox(height: 30),
//             //  Text('${post.title}'),
//             //  SizedBox(height: 30),
//             //  Text('${post.body}'),
//             //  SizedBox(height: 30),
//           ],
//         ),
//       );
//     }
// );
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_api_example/post.dart';
import 'package:http/http.dart' as http;
import 'package:json_api_example/userpostpage.dart';

var url;

class userpost2page extends StatelessWidget{
   int userid;
  userpost2page({required this.userid});

   Future<List<Post>> postsFuture = getPosts();
  static Future<List<Post>> getPosts() async {
     // String url ='https://jsonplaceholder.typicode.com/posts?userId=${userid1}';
     // print('userid1: ${userid1}');
     final response = await http.get(Uri.parse(url!));
     final body = json.decode(response.body);
     return body.map<Post>(Post.fromJson).toList();
   }
  @override
  Widget build(BuildContext context) {
    print('user ${userid}');
    url ='https://jsonplaceholder.typicode.com/posts?userId=${userid}';
    print("url: $url");
    print('userid: ${userid}');
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("USerPost"),
      ),
      body: Center(
          child: FutureBuilder<List<Post>>(
              future: postsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.black45,
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Loding....",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  );
                } else if (snapshot.hasData) {
                  final posts = snapshot.data;
                  print("posts: ${posts}");
                  // final userid = snapshot.data;
                  return buildPost(posts!);
                }
                else if(snapshot.hasError){
                  print(snapshot.error);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('${snapshot.hasError}'),
                      Text('${snapshot.error}'),
                      Text('${snapshot.runtimeType}'),
                    ],
                  );
                }
                else {
                  return Text("No User Data!");
                }
              })),
    );
  }
}
Widget buildPost(List<Post>  posts )  => ListView.builder(
    itemCount: posts.length,
    itemBuilder: (BuildContext context, index) {
      print('index: ${index}');
      final post = posts[index];
      print('post: ${posts}');
      // final userId = userid;
      return Card(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Text('${post.userId}'),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text('${post.id}'),
            ),
            Container(
              // padding: const EdgeInsets.only(left: 4 , right: 3),
              child: ListTile(
                title: Text(post.title),
              ),
            ),
          ],
        ),
      );
    }
);