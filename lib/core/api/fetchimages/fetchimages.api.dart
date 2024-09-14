import 'package:dio/dio.dart';
import 'package:galleryapp/app/routes/apiroutes.dart';
import 'package:galleryapp/meta/widgets/customsnackbar.dart';
import 'dart:developer' as devtools show log;

class FetchimagesApi {
  final Dio dio;

  FetchimagesApi(this.dio);

  //! Get Images (Function to handle all image data)
  getImages(int page, context, {search}) async {
    Map<String, dynamic> queryParams = {
      'key': '44978634-21f63b4c475f2fbb3306cf779',
      'per_page': 24,
      'page': page,
      'q': search
    };

//! Make an HTTP GET request using Dio
    final response = await dio.get(
      APIRoutes.localHost, //! The URL or endpoint for the request
      queryParameters:
          queryParams, //! Parameters to include in the query string of the request
    );

//! Get the HTTP status code from the response
    final statuscode = response.statusCode;

    if (statuscode == 200) {
      return response;
    } else {
      devtools.log("getImages api data not found");
      return ShowsnackBarUtiltiy.showSnackbar(
          message: "Data not found", context: context);
    }
  }
}
