

import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

var DOMAIN  = "https://shule.artytechcreators.com/";
var APP_URL_BASE  = "https://shule.artytechcreators.com/api/";
var APP_URL_FILE  = "https://shule.artytechcreators.com/images/";

const appBackground = Color(0xFFFBFBFB);
const blackColor = Color(0xFF000000);
const lightBlackColor = Color(0xFF3B3B3B);
const lightGreyColor = Color(0xFFEFECEC);
const darkGreyColor = Color(0xFF9CA3AF);
const primaryColor = Color(0xFF0C7BC2);
const secondaryColor = Color(0xFFF5881F);
const appBackgroundColor = Color(0xFFf7f9f9);
const indicatorColor = Color(0xFFAF24BF);
const bannerColor = Color(0xFF6665F1);


const greyColor = Color(0xFF707070);
const popColor = Color(0xFF9CA3AF);
const lightPinkColor = Color(0xFFFF4C9C);
const mainColor = Color(0xFFFF4C9C);
const lighterPinkColor = Color(0xFFFCE7F3);

const darkPinkColor = Color(0xFFDB2777);
const inputLightGreyColor = Color(0xFFF4F4F4);

const gradientLightDarkPinkColor = Color(0xFFF9ECF3);
const gradientLightPinkColor = Color(0xFFF9ECF3);

const gradientPinkColor = Color(0xFFFF4C9C);
const gradientDarkPinkColor = Color(0xFFAF24BF);

const bgPinkColor = Color(0xFFf5ebf5);

const subColor = Color(0xFFAF24BF);
const lightSubColor = Color(0xFFEDE9FE);
const textDarkColor = Color(0xFF3d2309);
const whiteColor = Color(0xFFFFFFFF);
const lightBgColor = Color(0xFFf4f4f4);


var ADMIN_PERSON_ID = 1;

//measurements
var smallMargin = 5.0;

void showSnackBar(BuildContext context, String message){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

void logoutPerson(context) async {
  var preferences = await SharedPreferences.getInstance();
  preferences.setBool("is_user_logged_in", false);

  logoutAgent(context);

  Navigator.pushNamedAndRemoveUntil(context, "/splash", (route) => false);
}

void logoutAgent(context) async {
  var preferences = await SharedPreferences.getInstance();
  preferences.setBool("is_agent_logged_in", false);
  preferences.remove("agent");
}

Future<String> getSharedPreference(String key) async {
  var preferences =  await SharedPreferences.getInstance();
  return preferences.getString(key) ?? "";
}

Future<bool> is_subscription_active() async {
  var preferences = await SharedPreferences.getInstance();
  var userSubscriptionExpiryDate = preferences.getString("user_subscription_expiry_date");
  if( userSubscriptionExpiryDate == null || userSubscriptionExpiryDate == "" ){
    return false;
  } else {
    var dateTime = DateTime.parse(userSubscriptionExpiryDate);
    //if is expired
    var now = DateTime.now();
    return dateTime.isAfter(now);
  }
}

void saveAgentInPreference(agent) async {
  var preferences = await SharedPreferences.getInstance();
  preferences.setBool("is_agent_logged_in", true);
  preferences.setString("agent", jsonEncode(agent));
}

void savePersonInPreference(person) async {
  //{id: 9534, user_name: ibalintuma, picture: , email: ibalintuma1@gmail.com, district: Bundibugyo, password: 1234567890, firebase_token: , notification_id: null}
  print("Saving person in preference");
  var preferences = await SharedPreferences.getInstance();
  preferences.setBool("is_user_logged_in", true);
  preferences.setString("user", jsonEncode(person));
  preferences.setString("user_id", "${person["id"]}");
  preferences.setString("person_id", "${person["id"]}");
  preferences.setString("user_name", person["user_name"] as String? ?? "");
  //preferences.setString("user_country", person["country"] as String? ?? "");
  preferences.setString("user_email", person["email"] as String? ?? "");
  //preferences.setString("user_gender", person["gender"] as String? ?? "");
  //preferences.setString("user_phone", person["phone"] as String? ?? "");
  preferences.setString("user_picture", person["picture"] as String? ?? "");
  //preferences.setString("user_bio", person["bio"] as String? ?? "");
  //preferences.setString("user_job", person["job"] as String? ?? "");
  //preferences.setString("user_work_place", person["work_place"] as String? ?? "");
  //preferences.setString("user_subscription_expiry_date", person["subscription_expiry_date"] as String? ?? "");
  //preferences.setDouble("user_profile_completion_percentage",
  //    person["profile_completion_percentage"] is String
  //        ? double.tryParse(person["profile_completion_percentage"]) ?? 0.0
  //       : person["profile_completion_percentage"] as double? ?? 0.0);
}

void saveToken(token,token_type) async {
  print("Saving person in preference");
  var preferences = await SharedPreferences.getInstance();
  preferences.setBool("is_user_logged_in", true);

  preferences.setString("token", token);
  preferences.setString("token_type", token_type);
}

String formatLaravelTime(String created_at){
  var date = DateTime.parse(created_at);
  return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
}
//notification time - to "Jul 12, 2024 8:31 pm"
String formatNotificationTime(String created_at) {
  var date = DateTime.parse(created_at);
  return DateFormat('MMM dd, yyyy h:mm a').format(date);
}

String formatDateOnlyUserFriendly(String dateString) {
  // Parse the date string into a DateTime object
  DateTime dateTime = DateTime.parse(dateString);

  // Format the date into a user-friendly string
  String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);

  return formattedDate;
}


String formatNumberWithCommas(String number) {
  final formatter = NumberFormat('#,###');
  return formatter.format(int.parse(number));
}



var boxDecoration = BoxDecoration(border: Border.all(color: Colors.grey, width: 1), borderRadius: BorderRadius.circular(5),);
InputDecoration inputDecoration(String hintText){
  return InputDecoration(
    contentPadding: const EdgeInsets.all(6),
    hintText: hintText,
    hintStyle: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.normal),
    isDense: true,
    border: const OutlineInputBorder( borderSide: BorderSide.none, ), filled: false, // Needed to respect the background color
  );
}

String getDurationFromNow(String dateTimeString) {
  // Define the date format
  DateFormat dateTimeFormatter = DateFormat("yyyy-MM-dd HH:mm:ss");

  // Parse the input date string
  DateTime pastDateTime = dateTimeFormatter.parse(dateTimeString);
  DateTime now = DateTime.now();

  // Calculate the duration
  Duration duration = now.difference(pastDateTime);

  // Return appropriate time ago string
  if (duration.inDays >= 30) {
    int months = (duration.inDays / 30).floor();
    return "$months months ago";
  } else if (duration.inDays >= 1) {
    return "${duration.inDays} days ago";
  } else if (duration.inHours >= 1) {
    return "${duration.inHours} hours ago";
  } else if (duration.inMinutes >= 1) {
    return "${duration.inMinutes} minutes ago";
  } else {
    return "${duration.inSeconds} seconds ago";
  }
}

//text

Widget bossHeading(String text,{ fontSize = 25 }){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child:
    Align( alignment: Alignment.center,
    child:  Text(text, textAlign: TextAlign.center,
      style: TextStyle(  color: blackColor, fontSize: double.parse("$fontSize"), fontWeight: FontWeight.bold, ),),
    ),
  );
}

//buttons

Widget bossButtonGradientFilled(String text, Function() onPressed){
  return GestureDetector(
    onTap: onPressed,
    child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [gradientDarkPinkColor, gradientLightPinkColor],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(13),
        margin: EdgeInsets.all(smallMargin),
        child: Center(child: Text(text, style: TextStyle( color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold,),))),
  );
}

Widget squareTile(String imagePath){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child:Image.asset(imagePath,
        height: 30,
        width: 30,),
  );
}

Widget bossButtonRight(String text, Function() onPressed, {Color color = subColor}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Padding(
        padding: const EdgeInsets.only(),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: color),
                color: color,
                borderRadius: BorderRadius.circular(30)
            ),
            padding: const EdgeInsets.symmetric(vertical: 7.0,horizontal: 17),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(text, style: TextStyle(color: Colors.white),),
                Icon(Icons.chevron_right,color: Colors.white,),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget LoginButtonOvalFilled(String text, Function() onPressed){
  return GestureDetector(
    onTap: onPressed,
    child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        width: double.infinity,
        decoration: BoxDecoration(
          color: darkPinkColor,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.all(15),
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
  );
}



artyTechPickPicture( BuildContext context, Function(String) onSuccess) async {

  /*
        <activity
            android:name="com.yalantis.ucrop.UCropActivity"
            android:screenOrientation="portrait"
            android:theme="@style/Theme.AppCompat.Light.NoActionBar"/>

            //add ios permissions
            */

  finishPicking(String path) async {
    if(path == ""){
      onSuccess("");
      return;
    }

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings( toolbarTitle: 'Cropper', toolbarColor: greyColor, toolbarWidgetColor: Colors.white, aspectRatioPresets: [CropAspectRatioPreset.square]),
        IOSUiSettings( title: 'Cropper', aspectRatioPresets: [CropAspectRatioPreset.square] ),
      ],
    );

    if (croppedFile != null) {
      onSuccess(croppedFile.path);
    } else {
      onSuccess("");
    }

  }

  final ImagePicker _picker = ImagePicker();

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Take a Picture'),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image =
                await _picker.pickImage(source: ImageSource.camera);
                if (image != null) {
                  finishPicking(image.path);
                } else {
                  finishPicking("");
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text('Choose from Gallery'),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image =
                await _picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  finishPicking(image.path);
                } else {
                  finishPicking("");
                }
              },
            ),
          ],
        ),
      );
    },
  );
}


Widget bossBabeDropDown(String text, String current,  dynamic items , Function(String) onSaved,{ IconData? prefixIcon, keyboardType = TextInputType.text, String? currentValue }){
  var children = [];
  children = items;
  return Container(
    margin: EdgeInsets.all(smallMargin),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
          child: Wrap(
            children: [
              Text("$text", style: TextStyle(color: blackColor, fontSize: 15, fontWeight: FontWeight.bold),),
              SizedBox(width: 5,),
              if( currentValue != null )
                Text("Current: $currentValue", style: TextStyle(fontSize: 12, color : Colors.green ),),
            ],
          ),
        ),

        ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: children.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                current = children[index];
                onSaved(current!);
              },
              child: Container(
                  decoration: boxDecoration,
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(2),
                  width: double.infinity,
                  child: Row(
                    children: [
                      if(current == children[index])
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.check, color: Colors.orange,size: 23,),
                        ),
                      Text(children[index]),
                    ],
                  )),
            );
          },
        ),




      ],
    ),
  );
}


Widget bossTextInput(String text, Function(String) onSaved, {
  IconData? prefixIcon,
  suffixIcon,
  keyboardType = TextInputType.text,
  hideLabel = true,
  obscureText = false,
  Function(String)? onChanged,
  TextEditingController? controller,  // Add controller parameter
  String? initialValue  // Add initial value parameter
}) {
  return Container(
    margin: EdgeInsets.all(smallMargin),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(!hideLabel)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
            child: Text("$text", style: TextStyle(color: greyColor, fontSize: 15, fontWeight: FontWeight.bold),),
          ),

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          width: double.infinity,
          child: TextFormField(
            style: TextStyle(color: Colors.black),
            controller: controller,  // Use the controller
            initialValue: controller == null ? initialValue : null,  // Only use initialValue if no controller
            decoration: inputDecoration("$text").copyWith(
              fillColor: Colors.white,
              filled : true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: inputLightGreyColor,width: 2),
                borderRadius: BorderRadius.circular(8),
              ),

              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: secondaryColor.withAlpha(100), width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Colors.black,) : null,
              suffixIcon: suffixIcon !=null ? Icon(suffixIcon,color: Colors.black):  null,
            ),
            obscureText: obscureText,
            keyboardType: keyboardType,
            onSaved: (value){
              onSaved(value!);
            },
            onChanged: onChanged,
          ),
        ),
      ],
    ),
  );
}


Widget bossSearchInput(String text, Function(String) onSaved, {
  IconData? prefixIcon,
  suffixIcon,
  keyboardType = TextInputType.text,
  hideLabel = true,
  obscureText = false,
  Function(String)? onChanged,
  TextEditingController? controller,  // Add controller parameter
  String? initialValue  // Add initial value parameter
}) {
  return Container(
    margin: EdgeInsets.all(smallMargin),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(!hideLabel)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
            child: Text("$text", style: TextStyle(color: greyColor, fontSize: 15, fontWeight: FontWeight.bold),),
          ),

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          width: double.infinity,
          child: TextFormField(

            controller: controller,  // Use the controller
            initialValue: controller == null ? initialValue : null,  // Only use initialValue if no controller
            decoration: inputDecoration("$text").copyWith(
              contentPadding: EdgeInsets.only(left: 20),
              fillColor: Colors.white,
              filled : true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: greyColor.withAlpha(80),width: 1),
                borderRadius: BorderRadius.circular(30),
              ),

              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor, width: 1),
                borderRadius: BorderRadius.circular(30),
              ),
              prefixIcon: prefixIcon != null ? Icon(prefixIcon,) : null,
              suffixIcon: suffixIcon !=null ? Icon(suffixIcon,):  null,
            ),
            obscureText: obscureText,
            keyboardType: keyboardType,
            onSaved: (value){
              onSaved(value!);
            },
            onChanged: onChanged,
          ),
        ),
      ],
    ),
  );
}

Widget artyTechTextArea(String text,  Function(String) onSaved){
  return Container(
    height: 100,
    margin: EdgeInsets.all(smallMargin),
    decoration: boxDecoration,
    width: double.infinity,
    child: TextFormField(

      maxLines: 5,
      decoration: inputDecoration(text),
      onSaved: (value){
        onSaved(value!);
      },
    ),
  );
}

Widget artyTechErrorWidget(String text){
  return Center(child: Text(text, style: TextStyle(color: Colors.red),),);
}

Widget bossButtonOutline(String text, Function() onPressed){
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.transparent,
        border: Border.all(color: darkPinkColor, width: 1),
      ),
      padding: EdgeInsets.all(10),
      child: Text(text, style: TextStyle(color: darkPinkColor, fontSize: 13),), alignment: Alignment.center,),
  );
}


String requestFile(String path){
  return APP_URL_FILE + path;
}

Future<void> requestAPI( String path, data, Function(bool) onProgress, Function(dynamic) onSuccess, Function(dynamic) onError, {String method = "POST"}) async {
  var dio;
  var full_path = "";

  //if path starts with http
  if (path.startsWith("http")) {
    full_path = path;
  } else {
    full_path = APP_URL_BASE + path;
  }

  var pref = await SharedPreferences.getInstance();
  var token = pref.getString("token") ?? "";
  var options = Options(
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
    headers: {
      "Authorization": "Bearer $token",
      'Content-Type': 'application/x-www-form-urlencoded',
    },);

  try {
    onProgress(true);
    if (method == "POST") {
      dio = Dio().post(
        full_path, data: FormData.fromMap(data), options: options,);
    } else if (method == "GET") {
      dio = Dio().get(full_path, queryParameters: data, options: options);
    } else if (method == "PUT") {
      dio = Dio().put(full_path, data: data, options: options);
    } else if (method == "DELETE") {
      dio = Dio().delete(full_path, data: data, options: options);
    }

    var response = await dio;

    //print(response.data);
    onProgress(false);
    print(response.data);
    onSuccess(response.data);

  } on DioException catch (error) {
    onProgress(false);
    print(error.message);
    print(error.type);
    print(error.response?.data);
    onError(error.response?.data);

  }
}

Widget bossBaseLoader(){
  return LoadingAnimationWidget.threeArchedCircle(
    color: secondaryColor,
    size: 30,
  );
}

Color hexToColor(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}


showAlertDialog(BuildContext context, String title, String message, Function() onConfirm) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("OK", style: TextStyle(color: Colors.red),),
    onPressed: () {
      Navigator.pop(context);
      onConfirm();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );

}

Widget artyTechDropDown(String text, String current,  dynamic items , Function(String) onSaved,{ IconData? prefixIcon, keyboardType = TextInputType.text, String? currentValue }){
  var children = [];
  children = items;
  return Container(
    margin: EdgeInsets.all(5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
          child: Wrap(
            children: [
              Text("$text", style: TextStyle(color: popColor, fontSize: 15, fontWeight: FontWeight.bold),),
              SizedBox(width: 5,),
              if( currentValue != null )
                Text("Current: $currentValue", style: TextStyle(fontSize: 12, color : Colors.green ),),
            ],
          ),
        ),

        ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: children.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                current = children[index];
                onSaved(current!);
              },
              child: Container(
                  decoration: boxDecoration,
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(2),
                  width: double.infinity,
                  child: Row(
                    children: [
                      if(current == children[index])
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.check, color: popColor,size: 23,),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(children[index]),
                      ),
                    ],
                  )),
            );
          },
        ),




      ],
    ),
  );
}

artyTechPickVideo( BuildContext context, Function(String) onSuccess) async {

  finishPicking(String path) async {
    if(path == ""){
      onSuccess("");
      return;
    }

    onSuccess(path);

  }

  final ImagePicker _picker = ImagePicker();

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.videocam),
              title: Text('Take a Video'),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image =
                await _picker.pickVideo(source: ImageSource.camera);
                if (image != null) {
                  finishPicking(image.path);
                } else {
                  finishPicking("");
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.videocam_outlined),
              title: Text('Choose from Gallery'),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image =
                await _picker.pickVideo(source: ImageSource.gallery);
                if (image != null) {
                  finishPicking(image.path);
                } else {
                  finishPicking("");
                }
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget bossButtonOval(String text, Function() onPressed, {filled = true, color = primaryColor}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: filled ? color : Colors.transparent,
        border: Border.all(color: color, width: 2),
      ),
      padding: EdgeInsets.all(10),
      child: Text(text, style: TextStyle(color: filled ? Colors.white : color, fontSize: 15, fontWeight: FontWeight.bold),), alignment: Alignment.center,),
  );
}


Future<String?> getAppUniqueId() async {
  final deviceInfoPlugin = DeviceInfoPlugin();
  final deviceInfo = await deviceInfoPlugin.deviceInfo;
  if (deviceInfo is AndroidDeviceInfo) {
    return deviceInfo.id; // Unique ID for Android
  } else if (deviceInfo is IosDeviceInfo) {
    return deviceInfo.identifierForVendor; // Unique ID for iOS
  } else {
    return "unknown"; // Fallback for other platforms
  }
}
Future<String?> getPlatform() async {
  final deviceInfoPlugin = DeviceInfoPlugin();
  final deviceInfo = await deviceInfoPlugin.deviceInfo;
  if (deviceInfo is AndroidDeviceInfo) {
    return "android"; // Unique ID for Android
  } else if (deviceInfo is IosDeviceInfo) {
    return "ios"; // Unique ID for iOS
  } else {
    return "unknown"; // Fallback for other platforms
  }
}

Future<bool?> isPlatformIOS() async {
  return ( await getPlatform() == "ios" );
}

Future<bool?> isUserCountrySupported() async {
  var countries = ["uganda", "kenya", "tanzania", "rwanda", "burundi","" ];
  var preferences = await SharedPreferences.getInstance();
  var userCountry = preferences.getString("user_country") ?? "";
  print("UserCountry: $userCountry");
  return countries.contains(userCountry.toLowerCase());
}

Future<String?> getAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}



BoxDecoration cardBoxDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    boxShadow: boxShadow(),
  );
}

boxShadow() {
  return [
    BoxShadow(
      color: Colors.grey.withOpacity(0.2),
      spreadRadius: 1,
      blurRadius: 3,
      offset: Offset(0, 2), // changes position of shadow
    ),
  ];
}

Widget noContentWidget(String item,) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning, size: 50, color: Colors.grey,),
          Text(
            "No $item found",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30,),
          Text(
            "Please try again later or check your internet connection.",
            style: TextStyle(color: Colors.grey, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 60,),
        ],
      ),
    ),
  );
}


customLog(dynamic data){
  var logger = Logger();
  logger.d( data );
}