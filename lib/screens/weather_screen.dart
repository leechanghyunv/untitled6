import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';
import 'package:untitled6/model/model.dart';

class WeatherScreen extends StatefulWidget {     //from loading
 WeatherScreen({this.parseWeatherData, this.psrseAirPollution});
  final dynamic parseWeatherData;  // parseWeatherData라는 속성을 추가 //네임드 아규먼트
  final dynamic psrseAirPollution;

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
 Model model =Model();  // weathericon 메서드를 불러오기위함
  String? cityName;
  int? temp;
  Widget? icon;  // svg 파일을 담기위해 생성된 변수 /위젯타입이란?
  String? des;

 Widget? airIcon;
 Widget? airState;
 double? dust1;
 double? dust2;

 var date = DateTime.now();

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    updateData(widget.parseWeatherData, widget.psrseAirPollution); //로딩스크린에서 데이터가 전달되고 - 위젯 속성을 활용해서 데이터를 출력
  }
// WeatherData는 인스턴스를 생성할때마다 loading widget으로부터 데이터를 전달받을 수 있다
  void updateData(dynamic weatherData, dynamic airData){
        double temp2 = weatherData['main']['temp'];
        int condition = weatherData['weather'][0]['id'];
        int index = airData['list'][0]['main']['aqi'];
        des = weatherData['weather'][0]['description'];
        dust1 = airData['list'][0]['components']['pm10'];
        dust2 = airData['list'][0]['components']['pm2_5'];
        temp = temp2.toInt();
        cityName = weatherData['name'];
        icon = model.getWeatherIcon(condition)!;
        airIcon = model.getAirIcon(index)!;
        airState = model.getAirCondition(index)!;

        print(temp);
        print(cityName);
  }

  String getSystemTime(){
    var now = DateTime.now();  // 특정시간을 보여줄때  //intl 패키지 안에 포함
    return DateFormat("h:mm a").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, //body가 appbar 위치까지 확장
     appBar: AppBar(
       // title: Text(''),
       backgroundColor: Colors. transparent,
       elevation: 0.0,
       leading: IconButton(
         icon: const Icon(Icons.near_me),
         onPressed: (){},
         iconSize: 25.0,
       ),
       actions: [
         IconButton(
           icon: const Icon(Icons.location_searching),
           onPressed: (){},
           iconSize: 25.0,
         ),
       ],
     ),
      body: Container(
        child: Stack(
          children: [
            Image.asset('image/background.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            ),
            Container(
             padding: const EdgeInsets.all(20),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Expanded(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           const SizedBox(
                             height: 150,
                           ),
                           Text('$cityName',
                             style: GoogleFonts. lato(
                               fontSize: 35.0,
                               fontWeight: FontWeight.bold,
                               color: Colors.white),
                           ),
                           Row(
                             children: [
                               TimerBuilder.periodic((Duration(minutes: 1)),
                                 builder: (context) {
                                 print('${getSystemTime()}');  //line 39
                                 return Text(  // builder 위잿은 반드시 widget을 return
                                     '${getSystemTime()}',
                                 style: GoogleFonts.lato(
                                     fontSize: 16.0, color: Colors.white),
                                 );
                                 },
                               ),
                               Text( //요일
                                 DateFormat('-EEEE').format(date),
                                 style:  GoogleFonts.lato(
                                     fontSize: 16.0, color: Colors.white),
                               ),
                               Text(//날짜정보
                                 DateFormat('d MMM, yyy').format(date),
                                 style:  GoogleFonts.lato(
                                     fontSize: 16.0, color: Colors.white),
                               )
                             ],
                           )
                         ],
                       ),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children:[
                           Text('$temp\u2013',  // 유니코드가 무슨의미인지 모르겠음
                           style: GoogleFonts. lato(
                               fontSize: 35.0,
                               fontWeight: FontWeight.bold,
                               color: Colors.white),
                           ),
                           Row(
                             children: [
                               icon!,   // 수정
                               const SizedBox(
                                 width: 10.0,
                               ),
                               Text('$des',
                                 style: GoogleFonts. lato(
                                     fontSize: 16.0,
                                     color: Colors.white),
                               )
                             ],
                           )
                         ],
                       )
                     ],
                   ),
                 ),
                 Column(
                   children: [
                     const Divider(
                       height: 15.0, thickness: 2.0,
                       color: Colors.white30,
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Column(
                           children: [
                             Text('AQI(대기질지수)',
                               style: GoogleFonts. lato(
                                   fontSize: 16.0,
                                   color: Colors.white
                               ),
                             ),
                             SizedBox(
                               height: 10,
                             ),
                          airIcon!,
                             SizedBox(
                               height: 10,
                             ),
                         airState!,
                           ],
                         ),
                         Column(
                           children: [
                             Text('미세먼지',
                               style: GoogleFonts. lato(
                                   fontSize: 16.0,
                                   color: Colors.white
                               ),
                             ),
                             SizedBox(
                               height: 10,
                             ),
                             Text('$dust1',
                               style: GoogleFonts. lato(
                                   fontSize: 24.0,
                                   color: Colors.white
                             ),
                             ),
                             SizedBox(
                               height: 10,
                             ),
                             Text('㎍/m3',
                               style: GoogleFonts. lato(
                                   fontSize: 14.0,
                                   color: Colors.black87,
                                   fontWeight: FontWeight.bold
                               ),
                             ),
                           ],
                         ),
                         Column(
                           children: [
                             Text('초미세먼지',
                               style: GoogleFonts. lato(
                                   fontSize: 16.0,
                                   color: Colors.white
                               ),
                             ),
                             SizedBox(
                               height: 10,
                             ),
                             Text(
                               '$dust2',
                               style: GoogleFonts. lato(
                                   fontSize: 24.0,
                                   color: Colors.white
                             ),
                             ),
                             SizedBox(
                               height: 10,
                             ),
                             Text('㎍/m3',
                               style: GoogleFonts. lato(
                                   fontSize: 14.0,
                                   color: Colors.white,
                                   fontWeight: FontWeight.bold
                               ),
                             ),
                           ],
                         ),
                       ],
                     ),
                   ],
                 )
               ],
             ),
            )
          ],
        ),
      ),
    );
  }
}


