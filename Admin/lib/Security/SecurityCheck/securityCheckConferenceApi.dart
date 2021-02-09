import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:keepapp/seccurityCheck_Conference_repository/lib/securityCheck_Conference_repository.dart';
import 'package:keepapp/utils/Utils.dart';
import 'package:googleapis_auth/auth.dart';

String parent =
    "projects/aakarfoundry-6fabe/databases/(default)/documents/conference";

String CONFERENCE_API =
    "https://firestore.googleapis.com/v1/projects/aakarfoundry-6fabe/databases/(default)/documents/conference/";

/// update existing note [noteModel]
Future<bool> updateConferenceData(
    SecurityCheck_Conference securityCheck) async {
  String docId = securityCheck.doc_id;
  String updateApi =
      "$CONFERENCE_API$docId?updateMask.fieldPaths=status&updateMask.fieldPaths=entryTime&updateMask.fieldPaths=exitTime";

  try {
    var response = await http.patch(
      updateApi,
      headers: {"Authorization": "Bearer ${Utils.loginToken}"},
      body: json.encode(
        {
          "fields": {
            "status": {"stringValue": securityCheck.status},
            "entryTime": {"integerValue": securityCheck.entryTime},
            "exitTime": {"integerValue": securityCheck.exitTime},
          }
        },
      ),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.body);
      return false;
    }
  } catch (err) {
    throw err;
  }
}

Future<void> uploadImage(Image image) async {
  String imageUploadApi =
      "https://storage.googleapis.com/upload/storage/v1/b/mybucket/o?uploadType=media&name=${image}";
  try {
    var response = await http.post(
      imageUploadApi,
      headers: {
        "Authorization": "Bearer ${Utils.loginToken}",
        "Content-Type": "image/png"
      },
    );
    if (response.statusCode == 200) {
      print("Image Uploaded Successfully");
      print(response.body);
    } else {
      print("Image Uploaded UnSuccessfully");
      print(response.body);
    }
  } catch (e) {
    print(e);
  }
}

Future<void> upload(Image image2) async {
  var accountCredentials = ServiceAccountCredentials.fromJson({
    "private_key_id": "eef19117ddcb9611fa9f435f3c6d050a9d8e44ad",
    "private_key":
        "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC9pSZcogbMLYj+\ndK5SJkGYSeUpJ6TwOWFSSrvha3DcU8fARNEWDHtPEIqcyWEnEOhJR9B0tfNH96eC\nCzwVLPLAFVWilsTiYywFE3CDRmzbQthIg7tjiSaJGfaiyivV7viZK/qdk2k8c0Tv\nw2msmJNqJmuQR+HX63TABUnp6u2ueBIv/eDgiqVh04kE49NUdVGMuoJeNVBXlxGs\n9F9WBNO5EhkkKtB1SNe7B31hxuhzCgVATrHgmllfwAPMIc0cnYWqL04sFVW/LnC1\nD69YTUrecuBh2kMYiEBFPDi4ok7MWFuDqkUyk1aw8UYPH75/cVzhWduylBOZe5b4\n6tPH1sgLAgMBAAECggEAO7nnewUMXwF4Q6s7u2ORBQVAxtVVfNKVc/VVdoj/4mQA\nZO1HbEpCC4SKIxbJIiSRA4M6g4dKN0An4Szon0KosRYHAk25dBMHqhGVPcLQRb2n\noC7ctVxcZpFmu54wcA/y+0p+g2IJoqAq9df1UAY9ZxDyj14UIoxlGJSR0rnKYUek\no4duZPxJ+kV0qldKWnDLizLE3WE505x+3XaW9aW3F0p/4ipSHtX0fZpRDo6MoIJj\njmpYmfcg0+ZCA4OP/GMGCTJ6bbmgOh+a06C7FL/rdTSeqC06N1gazF0v2CMzPt6L\nUMh9hEhoEY0AJMZfwEQFaOXLJrHTiN8CBNYFAu3jAQKBgQDgRsxBIruobTAH++hE\nUNiqeIwRqhk7Cz0FeYXbQE7Ua/FXl9TlgCRyY6H0JmEwGmtaIW8cZGoz2EP5VZs8\nRe7yhqTY8eTSXP18SB9XZnd9QSypI09gZdv4vGOe6ai6oxxC+TwfJgkN2sTLvPUv\n8nuAYlMQ+2oHKc6lcN5Ys0GXhQKBgQDYeFMjW6RVlMtn1aJlhER3gCivNp0vPDLs\nIILmwszcA66O/CJ3WKnpRClsJfg8U6u3N08GjEQOX09Q/Wb4CHSY8NSiEwtttL+U\nIyuyK9gul7d7jPstp7q9W7LxQjyDdzQIE+ic9dfsbx2StU9pjoBPCjL+84fJ0que\nIoqSlbzOTwKBgEnujL6cGIh5FfBL1lFO5V2sx1+7Vv3jwoXffYS9Oj9EJhbd8kyF\nZX5f4a9+R2N4EhNwGhSd9XSJwj6bPcUsuIwyXn01oFzIUrd5fvtsx87+gR5wiWYZ\nrd3dHGnyVLDRvCtHxc3u1+U9TMpsy9a2dIfp4cAjYNxjp79Z6bILxX+RAoGAZcyQ\nLHyYV7bVwUrySBNfr2MRvvRMDz6cI/dWF/dcJ8uDd7KS8tU7cnufj0B78MLYah0U\niNvF1Yx03H2Owu4XByWamW2jXkA2KBAyKGP+Eks++ldeeCX857gL+vFPS/PvAC18\novPqS0ImAixJ4DYnmQQO317faMYt9vv/dtf8JnkCgYEAnZCU+OjwM2jhW5+unK+d\ntGWM+2rjkNRwp2Rz2Ib2rJss1ToDATiUQ35gmWarU09s2D3ocVauMWZZ9Luxy/DU\nEzokwcyvwgsu+WxrQ9cXm7fmfeOAx/jbPW0Cdq1fAhIFKBV6LtVD6X8PRRet6XPY\nSIYWZlozJhUE1LyGiKEVd/Q=\n-----END PRIVATE KEY-----\n",
    "client_email":
        "firebase-adminsdk-cstpr@aakarfoundry-6fabe.iam.gserviceaccount.com",
    "client_id": "108242585825244733621",
    "type": "service_account"
  });

  var scopes = [
    'https://www.googleapis.com/auth/cloud-platform',
  ];

  var client = Client();
  AccessCredentials credentials =
      await obtainAccessCredentialsViaServiceAccount(
          accountCredentials, scopes, client);
  String accessToken = credentials.accessToken.data;

  File image = File('assets/images/boy.png');
  var request = Request(
    'POST',
    Uri.parse(
        'https://www.googleapis.com/upload/storage/v1/b/mybucket/o?uploadType=media&name=$image2'),
  );
  request.headers['Authorization'] = "Bearer $accessToken";
  request.headers['Content-Type'] = "image/png";

  // request.bodyBytes = await image.readAsBytes();

  Response response = await Response.fromStream(await request.send());
  print("response is ");
  print(response.statusCode);
  print("response body");
  print(response.body);
  client.close();
}
