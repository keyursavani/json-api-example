import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:json_api_example/usermainpage.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:flutter/material.dart';


void main() => runApp(example());

// class example extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Flutter Image Slider Demo"),),
//       body: Container(
//           padding: EdgeInsets.all(10),
//           margin: EdgeInsets.all(5),
//           alignment: Alignment.center,
//           constraints: BoxConstraints.expand(
//               height: 225
//           ),
//           child: imageSlider(context)),
//     );
//   }
// }
//
// Swiper imageSlider(context){
//   return new Swiper(
//     autoplay: true,
//     itemBuilder: (BuildContext context, int index) {
//       return new Image.network(
//         "https://lh3.googleusercontent.com/wIcl3tehFmOUpq-Jl3hlVbZVFrLHePRtIDWV5lZwBVDr7kEAgLTChyvXUclMVQDRHDEcDhY=w640-h400-e365-rj-sc0x00ffffff",
//         fit: BoxFit.fitHeight,
//       );
//     },
//     itemCount: 10,
//     viewportFraction: 0.7,
//     scale: 0.8,
//     axisDirection: AxisDirection.down,
//   );
// }

class example extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<example> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 30 , bottom: 30),
          child: Swiper(
            itemBuilder: (BuildContext context,int index){
              return Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTloDyV2JdZAUApVPkwRAHwoX0M5AOKipOiTw&usqp=CAU",fit: BoxFit.fill,);
            },
            // autoplay: true,
            // autoplayDelay: Duration.secondsPerMinute,
            itemCount: 10,
             viewportFraction: 0.7,
            scale: 0.8,
            axisDirection: AxisDirection.up,
            scrollDirection: Axis.vertical,

            pagination: SwiperPagination(),
            control: SwiperControl(),
          ),
        ),
      ),
    );
  }
}




