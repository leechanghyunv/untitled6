import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {
  final String url;
  final String url2;

  Network(this.url, this.url2); // 생성자를 통해서 url 데이터를 전달받을 수 있게
//Future<dynamic> - await에 값을 전달해줌 // 데이터의 타입이 다양하므로 dynamic

  Future<dynamic> getJasonData() async {
    http.Response response = await http.get(
        Uri.parse(url)); // Future값이 리턴될 때까지 기다
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;  // 왜
    }
  }
  Future<dynamic> getAirData() async {
    http.Response response = await http.get(
        Uri.parse(url2));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
  }

}