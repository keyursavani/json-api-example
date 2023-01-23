import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'comments.dart';

class commentspage extends StatefulWidget{
  final id;
  commentspage({required this.id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return commentspagestate();
  }
}
class commentspagestate extends State<commentspage>{
  Future<List<Comments>> commentsFuture = getComments();

  static Future<List<Comments>> getComments() async {
    const url = 'https://jsonplaceholder.typicode.com/comments?postId=1';
    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body);
    return body.map<Comments>(Comments.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final todo =  ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Comments"),
      ),
      body: Center(
        child: FutureBuilder<List<Comments>>(
          future: commentsFuture,
          builder: (context , snapshot){
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
              final comments = snapshot.data!;
              // print("posts: ${posts}");
              // final userid = snapshot.data;
              // user= widget.userid;
              final id = widget.id;
              return buildcomments(comments:comments , id:id , todo:todo);
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
          }),
        ),
    );
  }
}
class buildcomments extends StatelessWidget{
  final comments;
  final id;
  final todo;
  buildcomments({required this.comments , required this.id , required this.todo});
  Widget build(BuildContext context) {

    // TODO: implement build
   return Scaffold(
     body: Column(
       children: [
         SizedBox(height: 50),
         Expanded(
           child: Container(
             padding: const EdgeInsets.only(top: 10 ,right: 10 ,left: 8 ,bottom: 10),
               child: Text('${todo}' ,style: TextStyle(
                 fontWeight: FontWeight.normal,
                 fontSize: 23,
               ),
               ),
           ),
         ),
         SizedBox(height: 15),
         Expanded(
           flex: 2,
           child:  Swiper(
                       itemCount: comments.length,
                       viewportFraction: 0.9,
                       scale: 0.9,
                       axisDirection: AxisDirection.up,
                       scrollDirection: Axis.horizontal,
                       pagination: SwiperPagination(),
                       control: SwiperControl(),
                       itemBuilder: (BuildContext context,int index){
                         final comment = comments[index];
                         return Card(
                           child:  Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               // Text('id :- ${comment.id}'),
                               Container(
                                 padding: const EdgeInsets.only(top: 30 ,left: 10 ,right: 8 ,bottom: 20),
                                 child: Text(' ${comment.body}',style: TextStyle(
                                   fontStyle: FontStyle.italic,
                                   fontSize: 17,
                                 ),),
                               ),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.end,
                                 children: [
                                   Container(
                                       padding: const EdgeInsets.only(top: 20 ,right: 10 ,left: 10 ,bottom: 10),
                                       child: Text(' ${comment.email}', style: TextStyle(
                                         fontSize: 19,
                                         fontStyle: FontStyle.italic
                                       ),)
                                   ),
                                 ],
                               ),
                             ],
                           ),
                         );
                       }

                     ),
         ),
         SizedBox(height: 15,),
       ],
     ),
   );
  }
}
