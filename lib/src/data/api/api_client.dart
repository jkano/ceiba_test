import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ApiClient extends GetConnect implements GetxService {
  final String appBaseUrl;

  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
  }

  Future<Response> getData(String uri) async {
    try {
      Response response = await get(uri);
      return response;
    } catch (e) {
      return Response(statusCode: 404, statusText: e.toString());
    }
  }
}
