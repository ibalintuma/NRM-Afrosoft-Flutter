import 'dart:convert';
import 'package:http/http.dart' as http;

//Auth token we will use to generate a meeting and connect to it
//String token = "<Generated-from-dashboard>";
String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiIzYzVhZmNjMy05ZTFlLTRiZjItYTJmMC1mYTVkYjFlN2RiODUiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTc2Mjc4NzIwMiwiZXhwIjoxNzY1Mzc5MjAyfQ.iZa6LzzZPZFixyF5XPC48OhP3p2gflHYp2qlRx_w_Zg";

// API call to create meeting
Future<String> createMeeting() async {
  final http.Response httpResponse = await http.post(
    Uri.parse("https://api.videosdk.live/v2/rooms"),
    headers: {'Authorization': token},
  );

  print("token: $token");
  print( httpResponse.body);

//Destructuring the roomId from the response
  return json.decode(httpResponse.body)['roomId'];
}