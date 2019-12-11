import 'package:http/http.dart';
import 'package:reddit/reddit.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';



Future<String> fetchPost(String moogId) async {
  final response =
      await http.get('https://www.reddit.com/comments/$moogId/.json');
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    print('got response');
    print(response.body);
    //throw Exception('done');
    var sitmap = json.decode(response.body);
    String murl = sitmap[0]['data']['children'][0]['data']['url'];
    print (murl);
    return murl;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}

Future<Map> mapMoog(Map mm)
async {
  var moogMap = mm;
  return moogMap;
}

Future<String> getMug()
async{ 
  Random rnd;
  int min = 1;
  int max = 450;
  rnd = new Random();
  int r = min + rnd.nextInt(max - min);
  //print (r);
  String moog = 'daily dose of mugi';
  String sterm = '$moog #$r';
  Reddit reddit = await redauth();
  Map moogMap = await reddit.sub("k_on").search(sterm).fetch().then(mapMoog);
  var moogId = moogMap['data']['children'][0]['data']['name'];
  print('got id');
  moogId = moogId.substring(3);  
  String murl = await fetchPost(moogId);
  print(murl);
  return murl;

}
Future<Reddit> redauth() 
async{
    Reddit reddit = new Reddit(new Client());
    reddit.authSetup("REDACTED", "REDACTED");
    return reddit;
}
