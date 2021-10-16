import 'package:flutter/material.dart';
import 'package:untitled6/data/my_location.dart';
import 'package:untitled6/data/network.dart';
import 'package:untitled6/screens/weather_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
const apiKey = 'eb762badee9bebfe89afb7810d425f27';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {


  double? latitude3;
  double? longitude3;


  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    getLocation();

  }

  void getLocation() async{    // getlocation도 메서드임 (설계도의 구체적기능)
    MyLocation myLocation = MyLocation(); // mylocation instance 생
    await myLocation.getMyCurrentLocation(); //인스턴스 변수를 사용해서 메서드를 불러오
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;
    print(latitude3);
    print(longitude3);

    Network network = Network('https://api.openweathermap.org/data/2.5/weather?'
        'lat=$latitude3&lon=$longitude3&appid=$apiKey&units=metric',

        'https://api.openweathermap.org/data/2.5/airpollution?'
            'lat=$latitude3&lon=$longitude3&appid=$apiKey');
     // 인스턴스는 network

    var weatherData = await network.getJasonData();
    print(weatherData);

    var airData = await network.getAirData();
    print(airData);

    Navigator.push(context, MaterialPageRoute(builder:(context){
      return WeatherScreen(
        parseWeatherData: weatherData,
        psrseAirPollution: airData,
      ); // 데이터를 weather_screen - 35으로 전달
    }));
  }

// parseWeatherData를 불러와서 weatherData에 전달해줌

  // void fetchData() async {
  //
  //
  //     var myJson = parsingData['weather'][0]['description'];
  //     print(myJson);
  //
  //     var wind = parsingData ['wind']['speed'];
  //     print(wind);
  //
  //     var id = parsingData['id'];
  //     print(id);
  //   }else{
  //     print(response.statusCode);
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: SpinKitDoubleBounce(    // loading.....ux
          color: Colors.white,
          size: 80.0,

        ),
      ),
    );
  }
}