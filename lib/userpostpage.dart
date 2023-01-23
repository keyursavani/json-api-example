import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_api_example/post.dart';
import 'package:http/http.dart' as http;

import 'commentspage.dart';



class userpostpage extends StatefulWidget {
  int userid;
  userpostpage({required this.userid});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    // print(userid);
    // debugPrint('${userid}');
    return userpostpagestate();
  }
}

// var user;
class userpostpagestate extends State<userpostpage> {
  Future<List<Post>> postsFuture = getPosts();

  static Future<List<Post>> getPosts() async {
    const url = 'https://jsonplaceholder.typicode.com/posts?userId=1';
    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body);
    return body.map<Post>(Post.fromJson).toList();
  }
  @override
  Widget build(BuildContext context) {
    // final todo =  ModalRoute.of(context)?.settings.arguments;
    //  print('todo userid: ${todo}');
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("User Post"),
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
                  final posts = snapshot.data!;
                  // final List<Item> post1 = snapshot.hasData! as List<Item>;
                  // print("posts: ${posts}");
                  // final userid = snapshot.data;
                  // user= widget.userid;
                  return buildPost(posts ,widget.userid );
                  // return buildPost2(posts:posts , post1:post1);
                }
                else if(snapshot.hasError){
                  print(snapshot.error);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('${snapshot.hasError}'),
                      Text('${snapshot.error}'),
                    ],
                  );
                }
                else {
                  return Text("No User Data!");
                }
              }
              ),
      ),
    );
  }

  Widget buildPost(List<Post>  posts , userid )  => ListView.builder(
      itemCount: posts.length,
      itemBuilder: (BuildContext context, index) {
        // print(userid);
        // debugPrint('${userid}');
        final post = posts[index];
        final id = post.id;
        final title = post.title;
        // print("post: $post");
         if (userid == post.userId) {
           // print('Post Length: ${posts.length}');
         }
          return Card(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  // child: Text('${post.id}'),
                ),
                Container(
                  // padding: const EdgeInsets.only(left: 4 , right: 3),
                  child: ListTile(
                    title: Text(post.title , style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),),
                    onTap: (){
                      Navigator.push(
                          context,
                        MaterialPageRoute(builder: (context){
                          return postdetailspage(post:post);
                        }),
                          );
                    },
                  ),
                ),SizedBox(height: 10,),
                Container(
                child: ListTile(
                  subtitle: Text(post.body, style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 17,
                  ),),
                ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      child: Text("Viewcomments",style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=>
                              commentspage(id: id),
                            settings: RouteSettings(
                              arguments: title,
                            ),
                          ),
                        );
                      },
                    ),
                    Text('id :- ${post.id}' , style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic
                    ),),
                  ],
                )
              ],
            ),
          );
        }
  );
}
class postdetailspage extends StatelessWidget{
  final Post post;
  postdetailspage({required this.post});
  @override
  Widget build(BuildContext context) {
    final id = post.id;
    final title = post.title;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
      ),
      body:  Center(
        child: Container(
          padding: const EdgeInsets.only(left: 10 ,right: 8,top: 50,bottom: 20),
          child:   Column(
              children: [
                        Text(' ${post.title}',style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic
                        ),),
                        SizedBox(height:35),
                        Align(alignment: Alignment.centerLeft,
                        child: Text('Description :- ', style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                        ),
                        SizedBox(height: 35),
                        Text(' ${post.body}',style: TextStyle(
                            fontSize: 17,
                            fontStyle: FontStyle.italic),),
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                             TextButton(
                                child: Text("Viewcomments",style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                                ),),
                                onPressed: (){
                                  Navigator.push(
                                      context,
                                    MaterialPageRoute(builder: (context)=>
                                        commentspage(id: id),
                                      settings: RouteSettings(
                                        arguments: title,
                                      ),
                                    ),
                                  );
                                },
                              ),
                             Text('id :- ${post.id}' , style: TextStyle(
                                 fontSize: 18,
                                 fontStyle: FontStyle.italic
                             ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}

class buildPost2 extends StatefulWidget{
   final posts;
   final post1;
   buildPost2({required this.posts , required this.post1});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return buildPost2state();
  }
}
class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}
class buildPost2state extends State<buildPost2>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     body: SingleChildScrollView(
       child: Container(
         child: _buildPanle(widget.posts , widget.post1),
       ),
     ),
   );
  }
  Widget _buildPanle(posts , post1) {
   final List<Item> post2 = post1;
    final post = posts;
    return ExpansionPanelList(
      animationDuration: Duration(seconds: 3),
      dividerColor: Colors.blueGrey,
      elevation: 2,
      expandedHeaderPadding: EdgeInsets.all(10),
      expansionCallback: (int index , bool isExpanded){
        final post = posts[index];
        setState(() {
          post2[index].isExpanded = !isExpanded;
        });
      },
      children: post2.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
            canTapOnHeader: true,
        headerBuilder: (BuildContext context, bool isExpanded){
              return ListTile(
                title: Text('${item}'),
              );
        },
        body:ListTile(
            subtitle: Text('${item}'),
        ),
          isExpanded: item.isExpanded,
    );
    },).toList(),
    );
  }
}

