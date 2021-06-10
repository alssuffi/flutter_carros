import 'dart:async';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class LoripsumBloc {
  final _streamController = StreamController<String>();

  Stream<String> get stream => _streamController.stream;

  fetch() async {
    String s = await LoripsumApi.getLoripsum();

    _streamController.add(s);
  }

  void dispose() {
    _streamController.close();
  }
}

class LoripsumApi {
  static Future<String> getLoripsum() async {
    /*
    //var url = Uri.parse("https://loripsum.net/api");
    var url = await Dio().get('https://loripsum.net/api');

    print("get > $url");

    //var response = await http.get(url);

    var response = url; //await http.get(url);

    String text = response.data.toString();
    print(text);

    text = text.replaceAll("<p>", " ");
    text = text.replaceAll("</p>", "");
  */
    return "Rodrigo Carlos Alssuffi";
  }
}
