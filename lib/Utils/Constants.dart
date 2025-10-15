
  import 'dart:ui';

var sampleDate = "2024";
var ONESIGNAL_APP_ID = "9e36d99a";

var APPLE_RESTRICTED_FEATURE = false; // Hide Apple features like iCloud, Sign in with Apple, etc.

  var TERMS_AND_CONDITIONS_URL = "https://docs.google.com/document/d/e/2PACX-1vSF8uv7LL3MNbx-WCqku6_g4-GG0dV8WiTDwUJoiKCShJwmyNRh7IzXzCPy7qHOoMaaeww9N4KkoOLs/pub";
  var PRIVACY_POLICY_URL = "https://docs.google.com/document/d/e/2PACX-1vT2XRV_IUz5vk_UHB1pVHvfqeOD7Jo2Jh_YfkCZVOIibmfIeb8uAhWugwUIBbA92AY9d528PmARZCM6/pub";

  var MAIN_LINK = "https://nrm.afrosoftug.com/";

  String getApiURL( String path) {
    return "$MAIN_LINK$path";
  }
  String getImageURL( String folder, String name) {
    return "$MAIN_LINK$folder/$name";
  }