import 'package:geolocator/geolocator.dart';

class MyLocation {   // class -> 설계도

  double? latitude2; //late = tell that going to initialize the variable
  double? longitude2;
//Position의 argument -> longitude,latitude

  Future<void> getMyCurrentLocation() async {  // 메서드 -> 설계도에서 ->구체적인기능
    try {
      Position position = await Geolocator.  // 항상 future 값을 기다림
      getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      latitude2 = position.latitude;
      longitude2 = position.longitude;
      print(latitude2);
      print(longitude2);
    } catch (e) {
      print('there is a problem to solve');
    }
  }
}