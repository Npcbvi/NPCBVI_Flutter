
class ApiController {

  static final int timeout = 18;

/*  static Future<StoreResponse> versionApiRequest(String storeId) async {

    var url = ApiConstants.baseUrl.replaceAll("storeId", storeId) +
        ApiConstants.version;

    print("----url--${url}");


    try {
      FormData formData = new FormData.fromMap({
        "device_id": "",
        "device_token": "",
      });
      print("@@versionApiRequest----${url}"+formData.fields.toString());

      Dio dio = new Dio();
      Response response = await dio.post(url,
          data: formData,
          options: new Options(
              contentType: "application/json",
              responseType: ResponseType.plain));
      print(response.statusCode);
      print(response.data);
    *//*  StoreResponse storeData =
      StoreResponse.fromJson(json.decode(response.data));
      print("-------store.success ---${storeData.success}");
      SharedPrefs.saveStore(storeData.store);*//*
      //check older version
    //  String version = await SharedPrefs.getAPiDetailsVersion();
   //   print("older version is $version");


      return storeData;
    } catch (e) {
      print(e);
    }
    return null;
  }*/


}