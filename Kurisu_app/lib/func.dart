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
    //throw Exception('done');
    var sitmap = json.decode(response.body);
    String kurl = sitmap[0]['data']['children'][0]['data']['url'];
    //print (kurl);
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
  do
  {
  Random rnd; //many thanks to u/Anticycloner and u/TheMrGhostx
  int min = 1;//168;
  int max = 1000;
  rnd = new Random();
  int r = min + rnd.nextInt(max - min);
  //print (r);
  String assistant = 'Daily Random Kurisu';
  String sterm = '$assistant #$r';
  print(sterm);
  Reddit reddit = await redauth();
  assistantMap = await reddit.sub("Kurisutina").search(sterm).fetch().then(mapAssistant);
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
