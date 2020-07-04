import 'package:dio/dio.dart';
import 'package:gbk2utf8/gbk2utf8.dart';

class BApi {
  static final String baseUrl = 'https://hq.sinajs.cn/list=';

  static String responseGbkDecoder(List<int> responseBytes,
      RequestOptions options, ResponseBody responseBody) {
    return gbk.decode(responseBytes);
  }

  /// 请求gp列表
  static Future<String> loadSelect(String code) async {
    BaseOptions option = BaseOptions(responseDecoder: responseGbkDecoder);
    try {
      Response res = await Dio(option).get('$baseUrl$code');
      return res.data;
    } catch (e) {
      throw e;
    }
  }

  /// 加载新闻 
  static Future loadNews(String url, Map<String, dynamic> paras) async {
    try {
      Response res = await Dio().get(url, queryParameters: paras);
      return res.data;
    } catch (e) {
      throw e;
    }
  }
}
