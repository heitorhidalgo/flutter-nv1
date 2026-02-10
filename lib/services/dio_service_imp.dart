import 'package:dio/dio.dart';
import 'dio_service.dart';

class DioServiceImp implements DioService {
  @override
  Dio getDio() {
    return Dio(
      BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3',
        headers: {
          'content-type': 'application/json;charset=utf-8',
          // Cole sua API Key do TMDB abaixo após a palavra Bearer
          'authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkODI1YmQ4ZDgxMDY0YjY1OTJjODlkZTY3OTkwYTM4YyIsIm5iZiI6MTc3MDc2MzAzMy45NTUwMDAyLCJzdWIiOiI2OThiYjMxOTA0NTA3NGVmMWJkM2E0YWYiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.NAXEjbaoQaja2HCIakPN2yBJtoHNSECG_ZBFZmJqZNI',
        },
      ),
    );
  }
}