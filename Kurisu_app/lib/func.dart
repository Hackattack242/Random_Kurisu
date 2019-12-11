import 'package:http/http.dart';
import 'package:reddit/reddit.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';



Future<String> fetchPost(String assistantId) async {
  final response =
      await http.get('https://www.reddit.com/comments/$assistantId/.json');
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    print('got response');
    print(response.body);
    var sitmap = json.decode(response.body);
    String kurl = sitmap[0]['data']['children'][0]['data']['url'];
    return kurl;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}

Future<Map> mapAssistant(Map am)
async {
  var assistantMap = am;
  return assistantMap;
}

Future<String> getAssistant()
async{ 
  Map assistantMap;
  bool date = false;
  do{
  Random rnd; //many thanks to u/Anticycloner and u/TheMrGhostx
  int min = 1;
  int max = 1000;
  rnd = new Random();
  int r = min + rnd.nextInt(max - min);
  String assistant = 'Daily Random Kurisu';
  String sterm = "";
  if (r < 168 || date == true)
  {
  date = true;
  int month = 1 + rnd.nextInt(12 - 1);
  int day = 1 + rnd.nextInt(31 - 1);
  sterm = '$assistant ($day,$month)';
  }
  else{sterm = '$assistant #$r';}
  
  print(sterm);
  Reddit reddit = await redauth();
  print("auth successful");
  assistantMap = await reddit.sub("Kurisutina").search(sterm).fetch().then(mapAssistant);
  print(assistantMap);
  }while(assistantMap['data']['children'].length == 0);
  var assistantId = assistantMap['data']['children'][0]['data']['name'];
  print('got id');
  assistantId = assistantId.substring(3);  
  String kurl = await fetchPost(assistantId);
  print(kurl);
  return kurl;

}
Future<Reddit> redauth() 
async{
    Reddit reddit = new Reddit(new Client());
    reddit.authSetup("REDACTED", "REDACTED");
    return reddit;
}
