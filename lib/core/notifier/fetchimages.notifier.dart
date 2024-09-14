import 'package:flutter/material.dart';
import 'package:galleryapp/core/api/fetchimages/fetchimages.api.dart';
import 'package:galleryapp/core/model/fetchimages.data.dart';
import 'package:get_it/get_it.dart';
import 'dart:developer' as devtools show log;

class FetchimageNotifier with ChangeNotifier {
  //! Get the Dio instance from get_it
  final FetchimagesApi fetchapi = GetIt.I<FetchimagesApi>();

  Future fetchImage(context, noofpage, {search}) async {
    try {
      var response =
          await fetchapi.getImages(noofpage, context, search: search);

      if (response != null) {
        Fetchimagesdata data = Fetchimagesdata.fromJson(response.data);

        // final Map<String, dynamic> parsedData =
        //     await jsonDecode(response.data.toString());
        // final uniqeid = response["hits"][0]["id"];
        //devtools.log("getImage id ${response.toString()} ");
        return data;
      } else {
        devtools.log("getImages data not received");
      }
    } catch (e) {
      devtools.log("getImages error is $e ");
    }
  }
}
